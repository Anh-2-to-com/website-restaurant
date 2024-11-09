using Microsoft.AspNetCore.Mvc;

namespace WEBAPP.Models;

public class InvoiceDetail
{
    [BindProperty(Name = "ID_HOADON")]
    public string Id_HoaDon { get; set; } = null!;
    [BindProperty(Name = "ID_MONAN")]
    public string Id_MonAn { get; set; } = null!;
    [BindProperty(Name = "SOLUONG")]
    public int SoLuong { get; set; }
    [BindProperty(Name = "DONGIA")]
    public decimal DonGia { get; set; }
}