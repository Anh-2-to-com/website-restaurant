using Microsoft.AspNetCore.Mvc;

namespace WEBAPP.Models;

public class Invoice
{
    [BindProperty(Name = "ID_HOADON")]
    public string Id_HoaDon { get; set; } = null!;
    [BindProperty(Name = "ID_KH")]
    public string Id_KH { get; set; } = null!;
    [BindProperty(Name = "ID_BAN")]
    public string Id_Ban { get; set; } = null!;
    [BindProperty(Name = "NGAYHD")]
    public DateTime NgayHD { get; set; }
    [BindProperty(Name = "TIENMONAN")]
    public decimal TienMonAn { get; set; }
    [BindProperty(Name = "CODE_VOUCHER")]
    public string? Code_Voucher { get; set; }
    [BindProperty(Name = "TIENGIAM")]
    public decimal TienGiam { get; set; }
    [BindProperty(Name = "TONGTIEN")]
    public decimal TongTien { get; set; }
    [BindProperty(Name = "TRANGTHAI")]
    public string TrangThai { get; set; } = null!;
    public IEnumerable<InvoiceDetail>? InvoiceDetails { get; set; }
}