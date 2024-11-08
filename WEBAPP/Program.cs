using Microsoft.AspNetCore.Authentication.Cookies;
using WEBAPP.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme).AddCookie(p =>
{
    p.LoginPath = "/auth/login";
    p.ExpireTimeSpan = TimeSpan.FromDays(10);
    p.AccessDeniedPath = "/auth/error404";
});
builder.Services.AddScoped<SiteProvider>();
builder.Services.AddMvc();
var app = builder.Build();

app.UseStaticFiles();
app.MapDefaultControllerRoute();

app.Run();
