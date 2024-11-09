using System.Data;
using Dapper;

namespace WEBAPP.Models;

public class InvoiceDetailRepository : BaseRepository
{
    public InvoiceDetailRepository(IDbConnection connection) : base(connection)
    {
    }
    public IEnumerable<InvoiceDetail> GetInvoiceDetails(string invoiceid) => connection.Query<InvoiceDetail>("SELECT * FROM CTHD WHERE ID_HOADON = @Id_HoaDon", new { @Id_HoaDon = invoiceid });
    public int Pay(string customerid) => connection.Execute("Payment", new { @ID_KH = customerid }, commandType: CommandType.StoredProcedure);
    public int Add(string cartcode, InvoiceDetail obj) => connection.Execute("AddInvoiceDetail", new { @ID_GH = cartcode, @ID_HOADON = obj.Id_HoaDon }, commandType: CommandType.StoredProcedure);
}