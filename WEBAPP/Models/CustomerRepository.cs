using System.Data;
using Dapper;

namespace WEBAPP.Models;

public class CustomerRepository : BaseRepository
{
    public CustomerRepository(IDbConnection connection) : base(connection)
    {
    }
    public Customer? GetCustomerByUserId(string userid) => connection.QuerySingleOrDefault<Customer>("SELECT * FROM KHACHHANG WHERE ID_ND = @UserId", new { userid });
    public int Add(Customer obj) => connection.Execute("AddCustomer", new { obj.TenKH, obj.ID_ND, obj.HinhAnh, obj.NgaySinh, obj.SDT, obj.DiaChi }, commandType: CommandType.StoredProcedure);
}