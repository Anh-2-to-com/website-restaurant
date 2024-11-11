using System.Data;
using Dapper;
using WEBAPP.Models;

namespace WebApp.Models;

public class StatisticRepository : BaseRepository
{
    public StatisticRepository(IDbConnection connection) : base(connection)
    {
    }
    public IEnumerable<Monthly> GetMonthlies(int year) => connection.Query<Monthly>("GetEarningsByYear", new { @Year = year }, commandType: CommandType.StoredProcedure);
}