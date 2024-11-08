using Microsoft.AspNetCore.Mvc;

namespace WEBAPP.Controllers;

public class HomeController : BaseController
{
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
    public IActionResult Search()
    {
        ViewData["Title"] = "AITILO";
        return View();
    }
}