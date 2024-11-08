namespace WEBAPP.Models;

public class UserLogin
{
    [ConfigurationKeyName("EMAIL")]
    public string Email { get; set; } = null!;
    [ConfigurationKeyName("MATKHAU")]
    public string MatKhau { get; set; } = null!;
    public bool Remember { get; set; }
}