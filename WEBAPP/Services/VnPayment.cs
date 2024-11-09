namespace WebApp.Services;

public class VNPayment
{
    // Attribute
    [ConfigurationKeyName("vnp_TmnCode")]
    public string TmnCode { get; set; } = null!;
    [ConfigurationKeyName("vnp_HashSecret")]
    public string HashSecret { get; set; } = null!;
    [ConfigurationKeyName("vnp_Url")]
    public string Url { get; set; } = null!;
    [ConfigurationKeyName("vnp_Version")]
    public string Version { get; set; } = null!;
    [ConfigurationKeyName("vnp_Command")]
    public string Command { get; set; } = null!;
    [ConfigurationKeyName("vnp_CurrCode")]
    public string CurrCode { get; set; } = null!;
    [ConfigurationKeyName("vnp_Locale")]
    public string Locale { get; set; } = null!;
    [ConfigurationKeyName("vnp_OrderType")]
    public string OrderType { get; set; } = null!;
    [ConfigurationKeyName("vnp_ReturnUrl")]
    public string ReturnUrl { get; set; } = null!;
}
