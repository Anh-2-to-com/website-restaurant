using System.Data;
using Dapper;

namespace WEBAPP.Models;

public class UserAccountRepository : BaseRepository
{
    public UserAccountRepository(IDbConnection connection) : base(connection)
    {
    }
    public UserAccount? GetUserAccount(string email) => connection.QuerySingleOrDefault<UserAccount>("SELECT ID_ND, EMAIL, MATKHAU, VAITRO FROM NGUOIDUNG WHERE EMAIL = @email", new { email });
    public int Login(UserLogin obj)
    {
        string sql = "SELECT COUNT(*) FROM NGUOIDUNG WHERE EMAIL = @EMAIL AND MATKHAU = @MATKHAU";
        obj.MatKhau = Convert.ToHexString(Helper.HashPassword(obj.MatKhau)).Substring(0, 64);
        return connection.ExecuteScalar<int>(sql, new { obj.Email, obj.MatKhau });
    }
    public int Add(UserAccount obj) => connection.Execute("AddUser", new { obj.Email, MatKhau = Convert.ToHexString(Helper.HashPassword(obj.MatKhau)), obj.VaiTro }, commandType: CommandType.StoredProcedure);
}