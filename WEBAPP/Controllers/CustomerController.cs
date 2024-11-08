using System.Security.Claims;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WEBAPP.Models;

namespace WEBAPP.Controllers;

public class CustomerController : BaseController
{
    public IActionResult Index()
    {
        ViewData["Title"] = "AITILO";
        Customer obj = Provider.Customer.GetCustomerByUserId(User.FindFirstValue(ClaimTypes.NameIdentifier));
        ViewBag.Cust = obj ?? new Customer();
        return View();
    }
    [HttpPost]
    public IActionResult Add(Customer obj, IFormFile f)
    {
        if (f != null)
        {
            string root = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", "User");
            if (!string.IsNullOrEmpty(obj.HinhAnh))
            {
                if (System.IO.File.Exists(Path.Combine(root, obj.HinhAnh)))
                {
                    System.IO.File.Delete(Path.Combine(root, obj.HinhAnh));
                }
            }
            string ext = Path.GetExtension(f.FileName);
            obj.HinhAnh = Helper.RandomString(32 - ext.Length) + ext;
            using (Stream stream = new FileStream(Path.Combine(root, obj.HinhAnh), FileMode.Create))
            {
                f.CopyTo(stream);
            }
        }
        obj.ID_ND = User.FindFirst(ClaimTypes.NameIdentifier).Value;
        int ret = Provider.Customer.Add(obj);
        if (ret > 0)
        {
            TempData["Msg"] = "Update Success";
            return Redirect("/customer");
        }
        TempData["Msg"] = "Update Failed";
        return View(obj);
    }
}