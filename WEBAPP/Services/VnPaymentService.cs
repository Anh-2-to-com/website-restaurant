using System.Net;
using Microsoft.Extensions.Options;
using WEBAPP;
using WEBAPP.Models;

namespace WebApp.Services;

public class VNPaymentService
{
    // https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?vnp_Amount=1806000&vnp_Command=pay&vnp_CreateDate=20210801153333&vnp_CurrCode=VND
    //&vnp_IpAddr=127.0.0.1&vnp_Locale=vn&vnp_OrderInfo=Thanh+toan+don+hang+%3A5&vnp_OrderType=other
    //&vnp_ReturnUrl=https%3A%2F%2Fdomainmerchant.vn%2FReturnUrl&vnp_TmnCode=DEMOV210&vnp_TxnRef=5&vnp_Version=2.1.0&vnp_SecureHash=3e0d61a0c0534b2e36680b3f7277743e8784cc4e1d68fa7d276e79c23be7d6318d338b477910a27992f5057bb1582bd44bd82ae8009ffaf6d141219218625c42
    IHttpContextAccessor accessor;
    VNPayment payment;
    public VNPaymentService(IOptions<VNPayment> options, IHttpContextAccessor accessor) => (payment, this.accessor) = (options.Value, accessor);
    public string ToUrl(Invoice obj)
    {
        IDictionary<string, string> dict = new SortedDictionary<string, string>
        {
            {"vnp_Amount" , (obj.TongTien * 100).ToString("#")},
            {"vnp_Command" , payment.Command},
            {"vnp_CreateDate" , obj.NgayHD.ToString("yyyyMMddHHmmss")},
            {"vnp_CurrCode" , payment.CurrCode},
            // {"vnp_IpAddr" , accessor.HttpContext.Connection.RemoteIpAddress.ToString()},
            {"vnp_Locale" , payment.Locale},
            {"vnp_OrderInfo" , $"Payment for Invoice {obj.Id_HoaDon} with {obj.TongTien * 100}"},
            {"vnp_OrderType" , payment.OrderType},
            {"vnp_ReturnUrl" , payment.ReturnUrl},
            {"vnp_TmnCode" , payment.TmnCode},
            {"vnp_TxnRef" , obj.Id_HoaDon.ToString()},
            {"vnp_Version" , payment.Version},
        };
        if (accessor.HttpContext != null && accessor.HttpContext.Connection.RemoteIpAddress != null)
        {
            dict["vnp_IpAddr"] = accessor.HttpContext.Connection.RemoteIpAddress.ToString();
        }
        string queryString = string.Join("&", dict.Select(p => $"{p.Key}={WebUtility.UrlEncode(p.Value)}"));
        string url = payment.Url + "?" + queryString + "&vnp_SecureHash=" + Helper.HmacSha512(queryString, payment.HashSecret);
        return url;
    }
}