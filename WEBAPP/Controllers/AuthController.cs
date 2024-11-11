using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WEBAPP.Models;

namespace WEBAPP.Controllers;

public class AuthController : BaseController
{
    [Authorize]
    public async Task<IActionResult> Logout()
    {
        ViewData["Title"] = "AITILO";
        if (User != null && User.Identity != null && User.Identity.IsAuthenticated)
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            TempData["Msg"] = "Logout Success";
            return Redirect("/");
        }
        TempData["Msg"] = "Logout Failed";
        return Redirect("/auth/error404");
    }
    public IActionResult Login() => View();
    [HttpPost]
    public async Task<IActionResult> Login(UserLogin obj)
    {
        int ret = Provider.UserAccount.Login(obj);
        if (ret > 0)
        {
            UserAccount? account = Provider.UserAccount.GetUserAccount(obj.Email);
            if (account != null)
            {
                List<Claim> claims = new List<Claim>
                {
                    new Claim(ClaimTypes.NameIdentifier, account.ID_ND),
                    new Claim(ClaimTypes.Email, account.Email),
                    new Claim(ClaimTypes.Role, account.VaiTro)
                };
                ClaimsIdentity identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                ClaimsPrincipal principal = new ClaimsPrincipal(identity);
                await HttpContext.SignInAsync(principal, new AuthenticationProperties
                {
                    IsPersistent = obj.Remember,
                    RedirectUri = "auth/error404"
                });

                TempData["Msg"] = "Login Success";
                if (account.VaiTro.Equals("Quan Ly"))
                    return Redirect("/dashboard");
                return Redirect("/customer");
            }
        }
        TempData["Msg"] = "Login Failed";
        return View(obj);
    }
    public IActionResult Register()
    {
        ViewData["Title"] = "AITILO";
        ViewBag.Roles = new List<string>
        {
            "Khach hang",
            "Nhan Vien",
            "Nhan Vien Kho",
            "Quan Ly"
        };
        return View();
    }
    [HttpPost]
    public IActionResult Register(UserAccount obj)
    {
        ModelState.Remove(nameof(obj.ID_ND));
        int ret = Provider.UserAccount.Add(obj);
        if (ret > 0)
        {
            TempData["Msg"] = "Register Success";
            return Redirect("/auth/login");
        }
        TempData["Msg"] = "Register Failed";
        return View(obj);
    }
    public IActionResult Error404() => View();
}