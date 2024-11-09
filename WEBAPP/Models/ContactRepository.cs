using System.Data;
using Dapper;

namespace WEBAPP.Models;

public class ContactRepository : BaseRepository
{
    public ContactRepository(IDbConnection connection) : base(connection)
    {
    }
    public IEnumerable<Contact> GetContacts() => connection.Query<Contact>("SELECT * FROM Contact");
    public int Add(Contact obj) => connection.Execute("INSERT INTO Contact (Email, Subject, Body) VALUES (@Email, @Subject, @Body)", obj);
}