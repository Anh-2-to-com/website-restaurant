using System.Security.Claims;
using Microsoft.AspNetCore.Mvc;
using WEBAPP.Models;

namespace WEBAPP.Controllers;

public class InvoiceDetailController : BaseController
{
    const string CartToken = "CartToken";
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
        foreach (var detail in Helper.Details)
        {
            Helper.Invoices.Add(Provider.Invoice.GetInvoiceByTableId(detail.Id_Ban));
        }
        int ret = Provider.InvoiceDetail.PayCost(id.ToString());
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
        IEnumerable<Invoice> invoices = Helper.Invoices.OrderBy(p => p.Id_HoaDon);
        foreach (var item in invoices)
        {
            item.InvoiceDetails = Provider.InvoiceDetail.GetInvoiceDetails(item.Id_HoaDon);
        }
        Helper.Invoices = new List<Invoice>();
        return View(invoices);
    }
}