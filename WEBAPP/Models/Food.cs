using Microsoft.AspNetCore.Mvc;

namespace WEBAPP.Models;

public class Food
{
    [BindProperty(Name = "ID_MONAN")]
    public string ID_MonAn { get; set; } = null!;
    [BindProperty(Name = "TENMON")]
    public string TenMon { get; set; } = null!;
    [BindProperty(Name = "DONGIA")]
    public decimal DonGia { get; set; }
    [BindProperty(Name = "LOAI")]
    public string Loai { get; set; } = null!;
    [BindProperty(Name = "TRANGTHAI")]
    public string TrangThai { get; set; } = null!;
    [BindProperty(Name = "HINHANH")]
    public string HinhAnh { get; set; } = null!;
}