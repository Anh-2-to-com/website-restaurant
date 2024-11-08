using Microsoft.AspNetCore.Mvc;

namespace WEBAPP.Models;

public class TableBook
{
    [BindProperty(Name = "ID_BAN")]
    public string ID_Ban { get; set; } = null!;
    [BindProperty(Name = "TENBAN")]
    public string TenBan { get; set; } = null!;
    [BindProperty(Name = "VITRI")]
    public string ViTri { get; set; } = null!;
    [BindProperty(Name = "TRANGTHAI")]
    public string TrangThai { get; set; } = null!;
}