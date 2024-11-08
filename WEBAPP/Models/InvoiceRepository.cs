using System.Data;
using Dapper;

namespace WEBAPP.Models;

public class InvoiceRepository : BaseRepository
{
    public InvoiceRepository(IDbConnection connection) : base(connection)
    {
    }
    public Invoice? GetInvoiceByTableId(string tableid) => connection.QuerySingleOrDefault<Invoice>("SELECT * FROM HOADON WHERE ID_BAN = @Id_Ban AND TRANGTHAI = 'Chua thanh toan'", new { @Id_Ban = tableid });
    public IEnumerable<ResultTableBook> GetTablesByCustomerId(string customerid)
    {
        string sql = "SELECT A.ID_BAN, B.TENBAN FROM HOADON A JOIN BAN B ON A.ID_BAN = B.ID_BAN AND ID_KH = @Id_KH AND A.TRANGTHAI = 'Chua thanh toan' AND ID_HOADON NOT IN (SELECT ID_HOADON FROM CTHD)";
        return connection.Query<ResultTableBook>(sql, new { @Id_KH = customerid });
    }
}