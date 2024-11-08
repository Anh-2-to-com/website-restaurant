namespace WEBAPP.Models;

public class ResultCart
{
    public string Id_MonAn { get; set; } = null!;
    public string TenMon { get; set; } = null!;
    public string HinhAnh { get; set; } = null!;
    public int SoLuong { get; set; }
    public decimal DonGia { get; set; }
    public decimal ThanhTien { get; set; }
    public string Loai { get; set; } = null!;
    public bool IsChecked { get; set; }
    public string Id_Ban { get; set; } = null!;
}