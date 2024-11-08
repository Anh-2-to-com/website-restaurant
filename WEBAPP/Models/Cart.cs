using Microsoft.AspNetCore.Mvc;

namespace WEBAPP.Models;

public class Cart
{
    [BindProperty(Name = "ID_GH")]
    public string ID_GH { get; set; } = null!;
    [BindProperty(Name = "ID_MONAN")]
    public string ID_MonAn { get; set; } = null!;
    [BindProperty(Name = "SOLUONG")]
    public int SoLuong { get; set; }
    [BindProperty(Name = "ISCHECKED")]
    public bool IsChecked { get; set; }
}