using Microsoft.AspNetCore.Mvc;

namespace WEBAPP.Models;

public class UserAccount
{
    [BindProperty(Name = "ID_ND")]
    public string ID_ND { get; set; } = null!;
    [BindProperty(Name = "EMAIL")]
    public string Email { get; set; } = null!;
    [BindProperty(Name = "MATKHAU")]
    public string MatKhau { get; set; } = null!;

    [BindProperty(Name = "VAITRO")]
    public string VaiTro { get; set; } = null!;
}