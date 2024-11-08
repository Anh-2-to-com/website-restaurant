using Microsoft.AspNetCore.Mvc;

namespace WEBAPP.Models;

public class Customer
{
    [BindProperty(Name = "ID_KH")]
    public string ID_KH { get; set; } = null!;
    [BindProperty(Name = "TENKH")]
    public string TenKH { get; set; } = null!;
    [BindProperty(Name = "NGAYTHAMGIA")]
    public DateTime NgayThamGia { get; set; }
    [BindProperty(Name = "DOANHSO")]
    public decimal DoanhSo { get; set; }
    [BindProperty(Name = "DIEMTICHLUY")]
    public int DiemTichLuy { get; set; }
    [BindProperty(Name = "ID_ND")]
    public string ID_ND { get; set; } = null!;
    [BindProperty(Name = "HINHANH")]
    public string? HinhAnh { get; set; }
    [BindProperty(Name = "NGAYSINH")]
    public DateTime NgaySinh { get; set; }
    [BindProperty(Name = "SDT")]
    public string SDT { get; set; } = null!;
    [BindProperty(Name = "DIACHI")]
    public string DiaChi { get; set; } = null!;
}