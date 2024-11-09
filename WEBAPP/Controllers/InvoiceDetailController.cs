using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Mvc;
using WebApp.Services;
using WEBAPP.Models;

namespace WEBAPP.Controllers;

public class InvoiceDetailController : BaseController
{
    const string CartToken = "CartToken";
    VNPaymentService vnPayment;
    public InvoiceDetailController(VNPaymentService vnPayment) => this.vnPayment = vnPayment;
    public IActionResult Index()
    {
        ViewData["Title"] = "AITILO";
        string? code = Request.Cookies[CartToken];
        if (string.IsNullOrEmpty(code))
        {
            return Redirect("/food");
        }
        ViewBag.Customer = Provider.Customer.GetCustomerByUserId(User.FindFirstValue(ClaimTypes.NameIdentifier));
        IEnumerable<ResultCart> details = Helper.Details.OrderBy(p => p.Id_Ban);
        ViewBag.Total = Helper.Details.Sum(p => p.ThanhTien);
        return View(details);
    }
    public IActionResult PayCost(int id)
    {
        GetInvoicesByTableId(Helper.Details, Helper.Invoices);
        int ret = Provider.InvoiceDetail.Pay(id.ToString());
        if (ret > 0)
        {
            TempData["Msg"] = "Pay Success";
            Helper.Details.Clear();
            return Redirect("/invoicedetail/invoices");
        }
        else
        {
            TempData["Msg"] = "Pay Failed";
        }
        return Redirect("/invoicedetail");
    }
    public IActionResult Invoices()
    {
        ViewData["Title"] = "AITILO";
        IEnumerable<Invoice> invoices = Helper.Invoices.OrderBy(p => p.Id_HoaDon);
        foreach (var item in invoices)
        {
            item.InvoiceDetails = Provider.InvoiceDetail.GetInvoiceDetails(item.Id_HoaDon);
        }
        Helper.Invoices = new List<Invoice>();
        return View(invoices);
    }
    public IActionResult VnPayment(string id)
    {
        List<string> urls = new List<string>();
        if (Helper.Details.Count > 0)
            GetInvoicesByTableId(Helper.Details, Helper.Invoices);
        foreach (var invoice in Helper.Invoices)
        {
            invoice.NgayHD = DateTime.Now;
            urls.Add(vnPayment.ToUrl(invoice));
        }
        Helper.Details.Clear();
        ViewBag.Urls = urls;
        return View();
    }
    public IActionResult VnPaymentResponse(VNPaymentResponse obj)
    {
        Helper.Invoices.RemoveInvoiceById(obj.TxnRef);
        int ret = Provider.VNPayment.Add(obj);
        int retu = Provider.Invoice.VnPay(obj.TxnRef);
        if (ret > 0 && retu > 0)
        {
            return Redirect("/invoicedetail/vnpayment");
        }
        return Redirect("/auth/error404");
    }
    void GetInvoicesByTableId(List<ResultCart> details, List<Invoice> invoices)
    {
        ResultCart obj = details[0];
        invoices.Add(Provider.Invoice.GetInvoiceByTableId(obj.Id_Ban));
        for (int i = 1; i < Helper.Details.Count; ++i)
        {
            if (obj.Id_Ban.Equals(details[i].Id_Ban))
                continue;
            obj = Helper.Details[i];
            invoices.Add(Provider.Invoice.GetInvoiceByTableId(details[i].Id_Ban));
        }
    }
}