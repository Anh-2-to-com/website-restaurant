using Microsoft.AspNetCore.Mvc;
using WEBAPP.Models;

namespace WEBAPP.Controllers;

public class BaseController : Controller
{
    SiteProvider? provider;
    protected SiteProvider Provider => provider ?? new SiteProvider(HttpContext.RequestServices.GetRequiredService<IConfiguration>());
}