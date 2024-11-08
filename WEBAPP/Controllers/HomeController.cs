using Microsoft.AspNetCore.Identity.UI.Services;
using Microsoft.AspNetCore.Mvc;
using WEBAPP.Models;

namespace WEBAPP.Controllers;

public class HomeController : BaseController
{
    IEmailSender sender;
    public HomeController(IEmailSender sender) => this.sender = sender;
    public IActionResult Index()
    {
        ViewData["Title"] = "AITILO";
        return View();
    }
    public IActionResult About()
    {
        ViewData["Title"] = "AITILO";
        return View();
    }

    public IActionResult Book()
    {
        ViewData["Title"] = "AITILO";
        return View();
    }
    public IActionResult Testimonial()
    {
        ViewData["Title"] = "AITILO";
        return View();
    }
    public IActionResult Contact()
    {
        ViewData["Title"] = "AITILO";
        return View();
    }
    [HttpPost]
    public async Task<IActionResult> Contact(Contact obj)
    {
        try
        {
            await sender.SendEmailAsync(obj.Email, obj.Subject, obj.Body);
            if (ModelState.IsValid)
            {
                int ret = Provider.Contact.Add(obj);
                if (ret > 0)
                {
                    TempData["Msg"] = "Send Mail Message";
                    return Redirect("/home/success");
                }
                TempData["Msg"] = "Send Mail Failed";
                return View(obj);
            }
        }
        catch
        {
            TempData["Msg"] = "Send Mail Failed";
        }
        return View(obj);
    }
    public IActionResult Search()
    {
        ViewData["Title"] = "AITILO";
        return View();
    }
    public IActionResult Success() => View();
}