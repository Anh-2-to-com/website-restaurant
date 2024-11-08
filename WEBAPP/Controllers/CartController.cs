using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WEBAPP.Models;

namespace WEBAPP.Controllers;

[Authorize]
public class CartController : BaseController
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
        Customer? customer = Provider.Customer.GetCustomerByUserId(User.FindFirstValue(ClaimTypes.NameIdentifier));
        ViewBag.TableBooks = Provider.Invoice.GetTablesByCustomerId(customer.ID_KH);
        return View(Provider.Cart.GetCartsById(code));
    }
    [HttpPost]
    public IActionResult Add(string productid, int quantity)
    {
        Cart obj = new Cart();
        obj.ID_MonAn = productid;
        obj.SoLuong = quantity;
        string? code = Request.Cookies[CartToken];
        if (string.IsNullOrEmpty(code))
        {
            code = Helper.RandomString(16);
            Response.Cookies.Append(CartToken, code);
        }
        obj.ID_GH = code;
        int ret = Provider.Cart.Add(obj);
        if (ret > 0)
        {
            TempData["Msg"] = "Add Success";
        }
        else
        {
            TempData["Msg"] = "Add Failed";
        }
        return Redirect("/food");
    }
    public IActionResult Delete(string id)
    {
        string? code = Request.Cookies[CartToken];
        if (string.IsNullOrEmpty(code))
        {
            return Redirect("/food");
        }
        int ret = Provider.Cart.Delete(code, id);
        return Redirect("/cart");
    }
    [HttpPost]
    public IActionResult UpdateQuantity(string foodid, int quantity)
    {
        string? code = Request.Cookies[CartToken];
        if (string.IsNullOrEmpty(code))
        {
            return Json(0);
        }
        return Json(Provider.Cart.UpdateQuantity(code, foodid, quantity));
    }
    [HttpPost]
    public IActionResult UpdateSelected(string foodid)
    {
        string? code = Request.Cookies[CartToken];
        if (string.IsNullOrEmpty(code))
        {
            return Json(0);
        }
        return Json(Provider.Cart.UpdateSelected(code, foodid));
    }
    public IActionResult Approved(Pair obj)
    {
        InvoiceDetail detail = new InvoiceDetail();
        string? code = Request.Cookies[CartToken];
        if (string.IsNullOrEmpty(code))
        {
            return Redirect("/cart");
        }
        foreach (var item in Provider.Cart.GetCartsIsChecked(code))
        {
            item.Id_Ban = obj.Id_Ban;
            // System.Console.WriteLine($"{item.Id_MonAn} - {item.TenMon}");
            Helper.Details.Add(item);
        }// naive
        Invoice? invoice = Provider.Invoice.GetInvoiceByTableId(obj.Id_Ban);
        detail.Id_HoaDon = invoice.Id_HoaDon;
        int ret = Provider.InvoiceDetail.Add(code, detail);
        if (ret > 0)
            return Redirect("/invoicedetail");
        return Redirect("/cart");
    }
}