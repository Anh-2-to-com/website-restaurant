using System.Data;

namespace WEBAPP.Models;

public class BaseRepository
{
    protected IDbConnection connection;
    public BaseRepository(IDbConnection connection) => this.connection = connection;
}