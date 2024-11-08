using System.Data;
using Dapper;

namespace WEBAPP.Models;

public class CartRepository : BaseRepository
{
    public CartRepository(IDbConnection connection) : base(connection)
    {
    }
    public IEnumerable<ResultCart> GetCartsIsChecked(string cartcode) => connection.Query<ResultCart>("GetInvoiceDetails", new { @ID_GH = cartcode }, commandType: CommandType.StoredProcedure);
    public int UpdateSelected(string cartcode, string foodid) => connection.Execute("UPDATE GIOHANG SET ISCHECKED = ~ISCHECKED WHERE ID_GH = @Id_GH AND ID_MONAN = @Id_MonAn", new { @Id_GH = cartcode, @Id_MonAn = foodid });
    public int UpdateQuantity(string cartcode, string foodid, int quantity) => connection.Execute("UPDATE GIOHANG SET SOLUONG = @soluong WHERE ID_GH = @Id_GH AND ID_MONAN = @Id_MonAn", new { @soluong = quantity, @Id_GH = cartcode, @Id_MonAn = foodid });
    public int Delete(string cartcode, string foodid) => connection.Execute("DELETE GIOHANG WHERE ID_GH = @Id_GH AND ID_MONAN = @Id_MonAn", new { @Id_GH = cartcode, @Id_MonAn = foodid });
    public IEnumerable<ResultCart> GetCartsById(string code) => connection.Query<ResultCart>("SELECT A.ID_MONAN, TENMON, HINHANH, SOLUONG, DONGIA, SOLUONG * DONGIA AS THANHTIEN, LOAI, ISCHECKED FROM GIOHANG A JOIN MONAN B ON A.ID_MONAN = B.ID_MONAN WHERE ID_GH = @Id_GH", new { @Id_GH = code });
    public int Add(Cart obj) => connection.Execute("AddCart", new { obj.ID_GH, obj.ID_MonAn, obj.SoLuong }, commandType: CommandType.StoredProcedure);
}