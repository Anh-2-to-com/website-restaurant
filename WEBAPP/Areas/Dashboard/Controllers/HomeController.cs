using Microsoft.AspNetCore.Mvc;
using WEBAPP.Controllers;

namespace WebApp.Areas.Dashboard.Controllers;

[Area("dashboard")]
public class HomeController : BaseController
{
    public IActionResult Index()
    {
        ViewData["Title"] = "Dashboard";
        return View();
    }
    [HttpPost]
    public IActionResult GetMonthlies(int year) => Json(Provider.Statistic.GetMonthlies(year));
}