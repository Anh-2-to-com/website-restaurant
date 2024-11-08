using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace WEBAPP.Controllers;

[Authorize]
public class FoodController : BaseController
{
    public IActionResult Index()
    {
        ViewData["Title"] = "AITILO";
        return View(Provider.Food.GetTypeFoods());
    }
    [HttpPost]
    public IActionResult GetFoodsByTypeFood(string typefood) => Json(Provider.Food.GetFoodsByTypeFood(typefood));
}