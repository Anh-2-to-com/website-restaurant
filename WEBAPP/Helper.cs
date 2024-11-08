using System.Security.Cryptography;
using System.Text;
using WEBAPP.Models;

namespace WEBAPP;

public static class Helper
{
    public static List<ResultCart> Details = new List<ResultCart>();
    public static List<Invoice> Invoices = new List<Invoice>();
    public static byte[] HashPassword(string plaintext)
    {
        using HashAlgorithm algorithm = SHA512.Create();
        return algorithm.ComputeHash(Encoding.ASCII.GetBytes(plaintext));
    }
    public static string RandomString(int length)
    {
        char[] arr = new char[length];
        string pattern = "1234567890qwertyuiopasdfghjklzxcvbnm";
        Random random = new Random();
        for (int i = 0; i < arr.Length; ++i)
        {
            arr[i] = pattern[random.Next(pattern.Length)];
        }
        return string.Join("", arr);
    }
}