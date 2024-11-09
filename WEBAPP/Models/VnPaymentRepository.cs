using System.Data;
using Dapper;
using WebApp.Services;
using WEBAPP.Models;

namespace WebApp.Models;

public class VNPaymentRepository : BaseRepository
{
    public VNPaymentRepository(IDbConnection connection) : base(connection)
    {
    }
    public int Add(VNPaymentResponse obj)
    {
        string sql = "INSERT INTO VnPayment (Amount, BankCode, BankTranNo, CardType, OrderInfo, PayDate, ResponseCode, TmnCode, TransactionNo, TransactionStatus, TxnRef) VALUES (@Amount, @BankCode, @BankTranNo, @CardType, @OrderInfo, @PayDate, @ResponseCode, @TmnCode, @TransactionNo, @TransactionStatus, @TxnRef)";
        return connection.Execute(sql, new { obj.Amount, obj.BankCode, obj.BankTranNo, obj.CardType, obj.OrderInfo, obj.PayDate, obj.ResponseCode, obj.TmnCode, obj.TransactionNo, obj.TransactionStatus, obj.TxnRef });
    }
}