using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Identity.UI.Services;
using WebApp.Services;
using WEBAPP;
using WEBAPP.Models;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddScoped<VNPaymentService>();
builder.Services.AddHttpContextAccessor();
builder.Services.Configure<VNPayment>(builder.Configuration.GetSection("Payments:VnPayment"));
builder.Services.AddScoped<IEmailSender, EmailSender>();
builder.Services.Configure<MailSettings>(builder.Configuration.GetSection("MailSettings"));
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
