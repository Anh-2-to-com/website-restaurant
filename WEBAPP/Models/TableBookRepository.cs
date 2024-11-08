using System.Data;
using Dapper;

namespace WEBAPP.Models;

public class TableBookRepository : BaseRepository
{
    public TableBookRepository(IDbConnection connection) : base(connection)
    {
    }
    public int BookATable(string custid, string tableid) => connection.Execute("AddInvoice", new { @ID_KH = custid, @ID_BAN = tableid }, commandType: CommandType.StoredProcedure);
    public IEnumerable<Floor> GetFloors() => connection.Query<Floor>("SELECT DISTINCT VITRI AS FloorName FROM BAN");
    public IEnumerable<TableBook> GetTableBooksByFloor(string floor) => connection.Query<TableBook>("SELECT * FROM BAN WHERE VITRI = @Floor", new { @Floor = floor });
}