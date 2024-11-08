using System.Data;
using Microsoft.Data.SqlClient;

namespace WEBAPP.Models;

public class BaseProvider : IDisposable
{
    IDbConnection? connection;
    IConfiguration configuration;
    public BaseProvider(IConfiguration configuration) => this.configuration = configuration;
    protected IDbConnection Connection => connection ?? new SqlConnection(configuration.GetConnectionString("DB_QLNhaHang"));
    public void Dispose()
    {
        if (connection != null)
            connection.Dispose();
    }
}