
using WebApp.Models;

namespace WEBAPP.Models;

public class SiteProvider : BaseProvider
{
    public SiteProvider(IConfiguration configuration) : base(configuration)
    {
    }
    UserAccountRepository? userAccount;
    public UserAccountRepository UserAccount => userAccount ?? new UserAccountRepository(Connection);
    FoodRepository? food;
    public FoodRepository Food => food ?? new FoodRepository(Connection);
    TableBookRepository? tableBook;
    public TableBookRepository TableBook => tableBook ?? new TableBookRepository(Connection);
    CustomerRepository? customer;
    public CustomerRepository Customer => customer ?? new CustomerRepository(Connection);
    CartRepository? cart;
    public CartRepository Cart => cart ?? new CartRepository(Connection);
    InvoiceRepository? invoice;
    public InvoiceRepository Invoice => invoice ?? new InvoiceRepository(Connection);
    InvoiceDetailRepository? invoiceDetail;
    public InvoiceDetailRepository InvoiceDetail => invoiceDetail ?? new InvoiceDetailRepository(Connection);
    ContactRepository? contact;
    public ContactRepository Contact => contact ?? new ContactRepository(Connection);
    VNPaymentRepository? vNPayment;
    public VNPaymentRepository VNPayment => vNPayment ?? new VNPaymentRepository(Connection);
}