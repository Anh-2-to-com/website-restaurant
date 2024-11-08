using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WEBAPP.Models;

namespace WEBAPP.Controllers;

[Authorize]
public class ServiceController : BaseController
{
    public IActionResult Index()
    {
        ViewData["Title"] = "AITILO";
        return View(Provider.TableBook.GetFloors());
    }
    [HttpPost]
    public IActionResult GetTablesByFloor(string floor) => Json(Provider.TableBook.GetTableBooksByFloor(floor));
    [HttpPost]
    public IActionResult BookTable(string id_ban)
    {
        Customer customer = Provider.Customer.GetCustomerByUserId(User.FindFirstValue(ClaimTypes.NameIdentifier));
        int ret = Provider.TableBook.BookATable(customer.ID_KH, id_ban);
        if (ret > 0)
            TempData["Msg"] = "Book Table Success";
        else
            TempData["Msg"] = "Book Table Failed";
        return Redirect("/service");
    }
}