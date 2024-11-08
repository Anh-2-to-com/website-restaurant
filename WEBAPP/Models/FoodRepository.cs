using System.Data;
using Dapper;

namespace WEBAPP.Models;

public class FoodRepository : BaseRepository
{
    public FoodRepository(IDbConnection connection) : base(connection)
    {
    }
    public IEnumerable<TypeFood> GetTypeFoods() => connection.Query<TypeFood>("SELECT DISTINCT LOAI AS TypeFoodName FROM MONAN");
    public IEnumerable<Food> GetFoodsByTypeFood(string typefood) => connection.Query<Food>("SELECT * FROM MONAN WHERE LOAI = @Loai", new { @Loai = typefood });
}