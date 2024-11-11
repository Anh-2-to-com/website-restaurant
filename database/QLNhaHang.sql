CREATE DATABASE DB_QLNhaHang
GO
USE DB_QLNhaHang
GO
-------------------------------------Tạo bảng----------------------------------------
----Tao bang NGUOIDUNG
CREATE TABLE NGUOIDUNG(
	ID_ND VARCHAR(16),
	EMAIL VARCHAR(64) NOT NULL,
	MATKHAU VARCHAR(64) NOT NULL,
	VAITRO VARCHAR(64)
	CONSTRAINT PK_NGUOIDUNG PRIMARY KEY(ID_ND)
)
GO
---Them rang buoc NGUOIDUNG
ALTER TABLE NGUOIDUNG
ADD CONSTRAINT uni_NGUOIDING_EMAIL UNIQUE (EMAIL)
ADD CONSTRAINT chk_NGUOIDUNG_VAITRO CHECK (VAITRO IN ('Khach Hang','Nhan Vien','Nhan Vien Kho','Quan Ly'))

----Tao bang NHANVIEN
CREATE TABLE NHANVIEN(
	ID_NV VARCHAR(16),
	TENNV NVARCHAR(64) NOT NULL,
	NGAYVAOLAM DATE NOT NULL DEFAULT GETDATE(),
	SDT VARCHAR(16) NOT NULL,
	CHUCVU NVARCHAR(64),
	ID_ND VARCHAR(16) DEFAULT NULL,
	ID_NQL VARCHAR(16),
	TINHTRANG NVARCHAR(64)
	CONSTRAINT PK_NHANVIEN PRIMARY KEY(ID_NV)
)
GO
ALTER TABLE NHANVIEN ADD HINHANH VARCHAR(64)
GO
---Them rang buoc NHANVIEN
ALTER TABLE NHANVIEN
ADD CONSTRAINT chk_NHANVIEN_CHUCVU CHECK (CHUCVU IN ('Phuc vu','Tiep tan','Thu ngan','Bep','Kho','Quan ly'))
ALTER TABLE NHANVIEN
ADD CONSTRAINT chk_NHANVIEN_TINHTRANG CHECK (TINHTRANG IN ('Dang lam viec','Da nghi viec'));
GO
----Tao bang KHACHHANG
CREATE TABLE KHACHHANG(
	ID_KH VARCHAR(16),
	TENKH NVARCHAR(64) NOT NULL,
	NGAYTHAMGIA DATE NOT NULL DEFAULT GETDATE(),
	DOANHSO DECIMAL(10,2) DEFAULT 0,
	DIEMTICHLUY INT DEFAULT 0,
	ID_ND VARCHAR(16) NOT NULL,
	CONSTRAINT PK_KHACHHANG PRIMARY KEY(ID_KH)
)
GO
ALTER TABLE KHACHHANG ADD HINHANH VARCHAR(64)
ALTER TABLE KHACHHANG ADD NGAYSINH DATE
ALTER TABLE KHACHHANG ADD SDT VARCHAR(16)
ALTER TABLE KHACHHANG ADD DIACHI VARCHAR(128)
GO
----Tao bang MONAN
CREATE TABLE MONAN(
	ID_MONAN VARCHAR(16) NOT NULL,
	TENMON NVARCHAR(64) NOT NULL,
	DONGIA DECIMAL(10,2) NOT NULL,
	LOAI NVARCHAR(64),
	TRANGTHAI NVARCHAR(32),
	CONSTRAINT PK_MONAN PRIMARY KEY(ID_MONAN)
)
GO
ALTER TABLE MONAN ADD HINHANH VARCHAR(64) NOT NULL
---Them rang buoc MONAN
ALTER TABLE MONAN
ADD CONSTRAINT chk_MONAN_LOAI CHECK (LOAI IN ('Aries','Taurus','Gemini','Cancer','Leo','Virgo'
                                          ,'Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'))
ALTER TABLE MONAN
ADD CONSTRAINT chk_MONAN_TRANGTHAI CHECK (TRANGTHAI IN('Dang kinh doanh','Ngung kinh doanh'))   
GO
----Tao bang BAN
CREATE TABLE BAN(
	ID_BAN VARCHAR(16) NOT NULL,
	TENBAN NVARCHAR(64) NOT NULL,
	VITRI NVARCHAR(64) NOT NULL,
	TRANGTHAI NVARCHAR(64),
	CONSTRAINT PK_BAN PRIMARY KEY(ID_BAN)
)
GO
---Them rang buoc BAN
ALTER TABLE BAN
ADD CONSTRAINT chk_BAN_TRANGTHAI CHECK (TRANGTHAI IN ('Con trong','Dang dung bua','Da dat truoc'));
GO
----Tao bang VOUCHER
CREATE TABLE VOUCHER(
	CODE_VOUCHER VARCHAR(16) NOT NULL,
	MOTA NVARCHAR(64) NOT NULL,
	PHANTRAM INT,
	LOAIMA NVARCHAR(64),
	SOLUONG INT,
	DIEM DECIMAL(10,2),
	CONSTRAINT PK_VOUCHER PRIMARY KEY(CODE_VOUCHER)
)
GO
---Them rang buoc VOUCHER
ALTER TABLE VOUCHER
ADD CONSTRAINT chk_VOUCHER_Phantram CHECK (PHANTRAM > 0 AND Phantram <= 100)
ALTER TABLE VOUCHER
ADD CONSTRAINT chk_VOUCHER_LoaiMA CHECK (LOAIMA IN ('All','Aries','Taurus','Gemini','Cancer','Leo','Virgo'
                                                 ,'Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'))
GO
----Tao bang HOADON
CREATE TABLE HOADON(
	ID_HOADON VARCHAR(16) NOT NULL,
	ID_KH VARCHAR(16) NOT NULL,	
	ID_BAN VARCHAR(16) NOT NULL,	
	NGAYHD DATE NOT NULL,
	TIENMONAN DECIMAL(10,2),
	CODE_VOUCHER VARCHAR(16),
	TIENGIAM DECIMAL(10,2),
	TONGTIEN DECIMAL(10,2),
	TRANGTHAI NVARCHAR(64),
	CONSTRAINT PK_HOADON PRIMARY KEY(ID_HOADON)
)
GO
---Them rang buoc HOADON
ALTER TABLE HOADON
	ADD CONSTRAINT chk_HOADON_TRANGTHAI CHECK (TRANGTHAI IN ('Chua thanh toan','Da thanh toan'));
ALTER TABLE HOADON
	ADD CONSTRAINT df_TIENMONAN DEFAULT 0 FOR TIENMONAN;
GO
----Tao bang CTHD
CREATE TABLE CTHD(
	ID_HOADON VARCHAR(16) NOT NULL,
	ID_MONAN VARCHAR(16) NOT NULL,
	SOLUONG INT NOT NULL,
	DONGIA DECIMAL(10,2) NOT NULL
	CONSTRAINT PK_CTHD PRIMARY KEY(ID_HOADON, ID_MONAN)
)
GO
----Tao bang NGUYENLIEU
CREATE TABLE NGUYENLIEU(
	ID_NL VARCHAR(16) NOT NULL,
	TENNL NVARCHAR(64) NOT NULL,
	DONGIA DECIMAL(10,2) NOT NULL, 
	DONVITINH NVARCHAR(16),
	CONSTRAINT PK_NGUYENLIEU PRIMARY KEY(ID_NL)
)
GO
---Them rang buoc NGUYENLIEU
ALTER TABLE NGUYENLIEU
    ADD CONSTRAINT chk_NGUYENLIEU_DONVITINH CHECK (DONVITINH IN ('g','kg','ml','l'));
GO
----Tao bang KHO
CREATE TABLE KHO(
	ID_NL VARCHAR(16) NOT NULL,
	SLTON INT DEFAULT 0,
	CONSTRAINT PK_KHO PRIMARY KEY(ID_NL)
)
GO
----Tao bang PHIEUNK
CREATE TABLE PHIEUNK(
	ID_NK VARCHAR(16) NOT NULL,
	ID_NV VARCHAR(16) NOT NULL,
	NGAYNK DATE NOT NULL,
	TONGTIEN DECIMAL(10,2) DEFAULT 0,
	CONSTRAINT PK_PHIEUNK PRIMARY KEY(ID_NK)
)
GO
----Tao bang PHIEUNK
CREATE TABLE CTNK(
	ID_NK VARCHAR(16) NOT NULL,
	ID_NL VARCHAR(16) NOT NULL,
	SOLUONG INT NOT NULL,
	THANHTIEN DECIMAL(10,2),
	CONSTRAINT PK_CTNK PRIMARY KEY(ID_NK,ID_NL)
)
GO
----Tao bang PHIEUXK
CREATE TABLE PHIEUXK(
	ID_XK VARCHAR(16) NOT NULL,
	ID_NV VARCHAR(16) NOT NULL,
	NGAYXK DATE NOT NULL,
	CONSTRAINT PK_PHIEUXK PRIMARY KEY(ID_XK)
)
GO
----Tao bang CTXK
CREATE TABLE CTXK(
	ID_XK VARCHAR(16) NOT NULL,
	ID_NL VARCHAR(16) NOT NULL,
	SOLUONG INT NOT NULL,
	CONSTRAINT PK_CTXK PRIMARY KEY(ID_XK,ID_NL)
)
GO
CREATE TABLE GIOHANG(
	ID_GH VARCHAR(16) NOT NULL,
	ID_MONAN VARCHAR(16) NOT NULL REFERENCES MONAN(ID_MONAN),
	SOLUONG INT NOT NULL,
	ISCHECKED BIT NOT NULL DEFAULT 0,
	PRIMARY KEY(ID_GH, ID_MonAn)
);
GO
CREATE TABLE Contact(
	Email VARCHAR(32) NOT NULL,
	Subject NVARCHAR(128) NOT NULL,
	Body NTEXT
);
GO
CREATE TABLE VnPayment (
    Amount BIGINT NOT NULL,
    BankCode NVARCHAR(128) NOT NULL,
    BankTranNo NVARCHAR(128) NOT NULL,
    CardType NVARCHAR(128) NOT NULL,
    OrderInfo NVARCHAR(128) NOT NULL,
    PayDate NVARCHAR(128) NOT NULL,
    ResponseCode NVARCHAR(128) NOT NULL,
    TmnCode NVARCHAR(128) NOT NULL,
    TransactionNo NVARCHAR(128) NOT NULL,
    TransactionStatus NVARCHAR(128) NOT NULL,
    TxnRef NVARCHAR(128) NOT NULL
);
GO

------------------------------------Khóa Ngoại-------------------------------------
------------Khoa ngoai NHANVIEN
ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_NHANVIEN_NGUOIDUNG FOREIGN KEY(ID_ND) REFERENCES NGUOIDUNG(ID_ND)-------1

ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_NHANVIEN_NHANVIEN FOREIGN KEY(ID_NQL) REFERENCES NHANVIEN(ID_NV)

------------Khoa ngoai KHACHHANG
ALTER TABLE KHACHHANG
ADD CONSTRAINT FK_KHACHHANG_NGUOIDUNG FOREIGN KEY(ID_ND) REFERENCES NGUOIDUNG(ID_ND)

------------Khoa ngoai HOADON
ALTER TABLE HOADON
ADD CONSTRAINT FK_HOADON_KHACHHANG FOREIGN KEY(ID_KH) REFERENCES KHACHHANG(ID_KH)

ALTER TABLE HOADON
ADD CONSTRAINT FK_HOADON_BAN FOREIGN KEY(ID_BAN) REFERENCES BAN(ID_BAN)

ALTER TABLE HOADON
ADD CONSTRAINT FK_HOADON_VOUCHER FOREIGN KEY(CODE_VOUCHER) REFERENCES VOUCHER(CODE_VOUCHER)

------------Khoa ngoai CTHD
ALTER TABLE CTHD
ADD CONSTRAINT FK_CTHD_HOADON FOREIGN KEY(ID_HOADON) REFERENCES HOADON(ID_HOADON)

ALTER TABLE CTHD
ADD CONSTRAINT FK_CTHD_MONAN FOREIGN KEY(ID_MONAN) REFERENCES MONAN(ID_MONAN)

------------Khoa ngoai KHO
ALTER TABLE KHO
ADD CONSTRAINT FK_KHO_NGUYENLIEU FOREIGN KEY(ID_NL) REFERENCES NGUYENLIEU(ID_NL)

------------Khoa ngoai PHIEUNK
ALTER TABLE PHIEUNK
ADD CONSTRAINT FK_PHIEUNK_NHANVIEN FOREIGN KEY(ID_NV) REFERENCES NHANVIEN(ID_NV)

------------Khoa ngoai CTNK
ALTER TABLE CTNK
ADD CONSTRAINT FK_CTNK_PHIEUNK FOREIGN KEY(ID_NK) REFERENCES PHIEUNK(ID_NK)

ALTER TABLE CTNK
ADD CONSTRAINT FK_CTNK_NGUYENLIEU FOREIGN KEY(ID_NL) REFERENCES NGUYENLIEU(ID_NL)

------------Khoa ngoai PHIEUXK
ALTER TABLE PHIEUXK
ADD CONSTRAINT FK_PHIEUXK_NHANVIEN FOREIGN KEY(ID_NV) REFERENCES NHANVIEN(ID_NV)

------------Khoa ngoai CTXK
ALTER TABLE CTXK
ADD CONSTRAINT FK_CTXK_PHIEUXK FOREIGN KEY(ID_XK) REFERENCES PHIEUXK(ID_XK)

ALTER TABLE CTXK
ADD CONSTRAINT FK_CTXK_NGUYENLIEU FOREIGN KEY(ID_NL) REFERENCES NGUYENLIEU(ID_NL)
GO



------------------------------Nhập liệu-----------------------------
-- Dữ liệu cho bảng NGUOIDUNG
INSERT INTO NGUOIDUNG(ID_ND,Email,MatKhau,Vaitro) VALUES (100,'NDH@gmail.com','3C9909AFEC25354D551DAE21590BB26E38D53F2173B8D3DC3EEE4C047E7AB1C1','Quan Ly')
-- Dữ liệu cho bảng MONAN
--Aries
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(1,'DUI CUU NUONG XE NHO', 250000,'Aries','Dang kinh doanh','1.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(2,'BE SUON CUU NUONG GIAY BAC MONG CO', 230000,'Aries','Dang kinh doanh','2.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(3,'DUI CUU NUONG TRUNG DONG', 350000,'Aries','Dang kinh doanh','3.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(4,'CUU XOC LA CA RI', 129000,'Aries','Dang kinh doanh','4.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(5,'CUU KUNGBAO', 250000,'Aries','Dang kinh doanh','5.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(6,'BAP CUU NUONG CAY', 250000,'Aries','Dang kinh doanh','6.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(7,'CUU VIEN HAM CAY', 19000,'Aries','Dang kinh doanh','7.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(8,'SUON CONG NUONG MONG CO', 250000,'Aries','Dang kinh doanh','8.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(9,'DUI CUU LON NUONG TAI BAN', 750000,'Aries','Dang kinh doanh','9.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(10,'SUONG CUU NUONG SOT NAM', 450000,'Aries','Dang kinh doanh','10.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(11,'DUI CUU NUONG TIEU XANH', 285000,'Aries','Dang kinh doanh','11.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(12,'SUON CUU SOT PHO MAI', 450000,'Aries','Dang kinh doanh', '12.jpg');

--Taurus
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(13,'Bit tet bo My khoai tay', 179000,'Taurus','Dang kinh doanh','13.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(14,'Bo bit tet Uc',169000,'Taurus','Dang kinh doanh','14.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(15,'Bit tet bo My BASIC', 179000,'Taurus','Dang kinh doanh','15.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(16,'My Y bo bam', 169000,'Taurus','Dang kinh doanh','16.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(17,'Thit suon Wagyu', 1180000,'Taurus','Dang kinh doanh','17.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(18,'Steak Thit Vai Wagyu', 1290000,'Taurus','Dang kinh doanh','18.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(19,'Steak Thit Bung Bo', 550000,'Taurus','Dang kinh doanh','19.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(20,'Tomahawk', 2390000,'Taurus','Dang kinh doanh','20.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(21,'Salad Romaine Nuong', 180000,'Taurus','Dang kinh doanh', '21.jpg');

--Gemini
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(22,'Combo Happy', 180000,'Gemini','Dang kinh doanh','22.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(23,'Combo Fantastic', 190000,'Gemini','Dang kinh doanh','23.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(24,'Combo Dreamer', 230000,'Gemini','Dang kinh doanh','24.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(25,'Combo Cupid', 180000,'Gemini','Dang kinh doanh','25.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(26,'Combo Poseidon', 190000,'Gemini','Dang kinh doanh','26.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(27,'Combo LUANG PRABANG', 490000,'Gemini','Dang kinh doanh','27.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(28,'Combo VIENTIANE', 620000,'Gemini','Dang kinh doanh', '28.jpg');

--Cancer
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(29,'Cua KingCrab Duc sot', 3650000,'Cancer','Dang kinh doanh','29.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(30,'Mai Cua KingCrab Topping Pho Mai', 2650000,'Cancer','Dang kinh doanh','30.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(31,'Cua KingCrab sot Tu Xuyen', 2300000,'Cancer','Dang kinh doanh','31.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(32,'Cua KingCrab Nuong Tu Nhien', 2550000,'Cancer','Dang kinh doanh','32.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(33,'Cua KingCrab Nuong Bo Toi', 2650000,'Cancer','Dang kinh doanh','33.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(34,'Com Mai Cua KingCrab Chien', 1850000,'Cancer','Dang kinh doanh', '34.jpg');

--Leo
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(35,'BOSSAM', 650000,'Leo','Dang kinh doanh','35.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(36,'KIMCHI PANCAKE', 350000,'Leo','Dang kinh doanh','36.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(37,'SPICY RICE CAKE', 250000,'Leo','Dang kinh doanh','37.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(38,'SPICY SAUSAGE HOTPOT', 650000,'Leo','Dang kinh doanh','38.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(39,'SPICY PORK', 350000,'Leo','Dang kinh doanh','39.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(40,'MUSHROOM SPICY SILKY TOFU STEW', 350000,'Leo','Dang kinh doanh', '40.jpg');
--Virgo
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(41,'Pavlova', 150000,'Virgo','Dang kinh doanh','41.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(42,'Kesutera', 120000,'Virgo','Dang kinh doanh','42.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(43,'Cremeschnitte', 250000,'Virgo','Dang kinh doanh','43.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(44,'Sachertorte', 150000,'Virgo','Dang kinh doanh','44.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(45,'Schwarzwalder Kirschtorte', 250000,'Virgo','Dang kinh doanh','45.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(46,'New York-Style Cheesecake', 250000,'Virgo','Dang kinh doanh', '46.jpg');

--Libra
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(47,'Cobb Salad', 150000,'Libra','Dang kinh doanh','47.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(48,'Salad Israeli', 120000,'Libra','Dang kinh doanh','48.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(49,'Salad Dau den', 120000,'Libra','Dang kinh doanh','49.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(50,'Waldorf Salad', 160000,'Libra','Dang kinh doanh','50.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(51,'Salad Gado-Gado', 200000,'Libra','Dang kinh doanh','51.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(52,'Nicoise Salad', 250000,'Libra','Dang kinh doanh', '52.jpg');

--Scorpio
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(53,'BULGOGI LUNCHBOX', 250000,'Scorpio','Dang kinh doanh','53.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(54,'CHICKEN TERIYAKI LUNCHBOX', 350000,'Scorpio','Dang kinh doanh','54.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(55,'SPICY PORK LUNCHBOX', 350000,'Scorpio','Dang kinh doanh','55.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(56,'TOFU TERIYAKI LUNCHBOX', 250000,'Scorpio','Dang kinh doanh', '56.jpg');

--Sagittarius
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(57,'Thit ngua do tuoi', 250000,'Sagittarius','Dang kinh doanh','57.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(58,'Steak Thit ngua', 350000,'Sagittarius','Dang kinh doanh','58.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(59,'Thit ngua ban gang', 350000,'Sagittarius','Dang kinh doanh','59.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(60,'Long ngua xao dua', 150000,'Sagittarius','Dang kinh doanh','60.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(61,'Thit ngua xao sa ot', 250000,'Sagittarius','Dang kinh doanh','61.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(62,'Ngua tang', 350000,'Sagittarius','Dang kinh doanh','62.jpg');

--Capricorn
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(63,'Thit de xong hoi', 229000,'Capricorn','Dang kinh doanh','63.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(64,'Thit de xao rau ngo', 199000,'Capricorn','Dang kinh doanh','64.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(65,'Thit de nuong tang', 229000,'Capricorn','Dang kinh doanh','65.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(66,'Thit de chao', 199000,'Capricorn','Dang kinh doanh','66.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(67,'Thit de nuong xien', 199000,'Capricorn','Dang kinh doanh','67.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(68,'Nam de nuong/chao', 199000,'Capricorn','Dang kinh doanh','68.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(69,'Thit de xao lan', 19000,'Capricorn','Dang kinh doanh','69.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(70,'Dui de tan thuoc bac', 199000,'Capricorn','Dang kinh doanh','70.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(71,'Canh de ham duong quy', 199000,'Capricorn','Dang kinh doanh','71.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(72,'Chao de dau xanh', 50000,'Capricorn','Dang kinh doanh','72.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(73,'Thit de nhung me', 229000,'Capricorn','Dang kinh doanh','74.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(74,'Lau de nhu', 499000,'Capricorn','Dang kinh doanh', '75.jpg');


--Aquarius
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(75,'SIGNATURE WINE', 3290000,'Aquarius','Dang kinh doanh','75.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(76,'CHILEAN WINE', 3990000,'Aquarius','Dang kinh doanh','76.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(77,'ARGENTINA WINE', 2890000,'Aquarius','Dang kinh doanh','77.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(78,'ITALIAN WINE', 5590000,'Aquarius','Dang kinh doanh','78.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(79,'AMERICAN WINE', 4990000,'Aquarius','Dang kinh doanh','79.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(80,'CLASSIC COCKTAIL', 200000,'Aquarius','Dang kinh doanh','80.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(81,'SIGNATURE COCKTAIL', 250000,'Aquarius','Dang kinh doanh','81.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(82,'MOCKTAIL', 160000,'Aquarius','Dang kinh doanh','82.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(83,'JAPANESE SAKE', 1490000,'Aquarius','Dang kinh doanh','83.jpg');

--Pisces
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(84,'Ca Hoi Ngam Tuong', 289000,'Pisces','Dang kinh doanh','84.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(85,'Ca Ngu Ngam Tuong', 289000,'Pisces','Dang kinh doanh','85.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(86,'IKURA:Trung ca hoi', 189000,'Pisces','Dang kinh doanh','86.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(87,'KARIN:Sashimi Ca Ngu', 149000,'Pisces','Dang kinh doanh','87.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(88,'KEIKO:Sashimi Ca Hoi', 199000,'Pisces','Dang kinh doanh','88.jpg');
INSERT INTO MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) VALUES(89,'CHIYO:Sashimi Bung Ca Hoi', 219000,'Pisces','Dang kinh doanh', '89.jpg');

-- Dữ liệu cho bảng BAN
--Tang 1
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(100,'Ban T1.1','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(101,'Ban T1.2','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(102,'Ban T1.3','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(103,'Ban T1.4','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(104,'Ban T1.5','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(105,'Ban T1.6','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(106,'Ban T1.7','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(107,'Ban T1.8','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(108,'Ban T1.9','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(109,'Ban T1.10','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(110,'Ban T1.11','Tang 1','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(111,'Ban T1.12','Tang 1','Con trong');
--Tang 2
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(112,'Ban T2.1','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(113,'Ban T2.2','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(114,'Ban T2.3','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(115,'Ban T2.4','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(116,'Ban T2.5','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(117,'Ban T2.6','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(118,'Ban T2.7','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(119,'Ban T2.8','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(120,'Ban T2.9','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(121,'Ban T2.10','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(122,'Ban T2.11','Tang 2','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(123,'Ban T2.12','Tang 2','Con trong');
--Tang 3
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(124,'Ban T3.1','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(125,'Ban T3.2','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(126,'Ban T3.3','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(127,'Ban T3.4','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(128,'Ban T3.5','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(129,'Ban T3.6','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(130,'Ban T3.7','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(131,'Ban T3.8','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(132,'Ban T3.9','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(133,'Ban T3.10','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(134,'Ban T3.11','Tang 3','Con trong');
INSERT INTO Ban(ID_Ban,TenBan,Vitri,Trangthai) VALUES(135,'Ban T3.12','Tang 3','Con trong');

-- Dữ liệu cho bảng VOUCHER
INSERT INTO Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) VALUES ('loQy','20% off for Aries Menu',20,'Aries',10,200);
INSERT INTO Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) VALUES ('pCfI','30% off for Taurus Menu',30,'Taurus',5,300);
INSERT INTO Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) VALUES ('pApo','20% off for Gemini Menu',20,'Gemini',10,200);
INSERT INTO Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) VALUES ('ugQx','100% off for Virgo Menu',100,'Virgo',3,500);
INSERT INTO Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) VALUES ('nxVX','20% off for All Menu',20,'All',5,300);
INSERT INTO Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) VALUES ('Pwyn','20% off for Cancer Menu',20,'Cancer',10,200);
INSERT INTO Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) VALUES ('bjff','50% off for Leo Menu',50,'Leo',5,600);
INSERT INTO Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) VALUES ('YPzJ','20% off for Aquarius Menu',20,'Aquarius',5,200);
INSERT INTO Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) VALUES ('Y5g0','30% off for Pisces Menu',30,'Pisces',5,300);
INSERT INTO Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) VALUES ('7hVO','60% off for Aries Menu',60,'Aries',0,1000);
INSERT INTO Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) VALUES ('WHLm','20% off for Capricorn Menu',20,'Capricorn',0,200);
INSERT INTO Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) VALUES ('GTsC','20% off for Leo Menu',20,'Leo',0,200);

-- Dữ liệu cho bảng NGUYENLIEU
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(100,'Thit ga',40000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(101,'Thit heo',50000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(102,'Thit bo',80000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(103,'Tom',100000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(104,'Ca hoi',500000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(105,'Gao',40000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(106,'Sua tuoi',40000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(107,'Bot mi',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(108,'Dau ca hoi',1000000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(109,'Dau dau nanh',150000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(110,'Muoi',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(111,'Duong',20000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(112,'Hanh tay',50000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(113,'Toi',30000,'kg');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(114,'Dam',50000,'l');
INSERT INTO NguyenLieu(ID_NL,TenNL,Dongia,Donvitinh) VALUES(115,'Thit de',130000,'kg');
GO
--- PROCEDURE
-- Thêm tài khoản người dùng
-- DROP PROC AddUser
CREATE PROC AddUser(
	@EMAIL VARCHAR(64),
	@MATKHAU VARCHAR(64),
	@VAITRO VARCHAR(64)
)
AS
BEGIN
	INSERT INTO NGUOIDUNG (ID_ND, EMAIL, MATKHAU, VAITRO) VALUES
	(CONVERT(INT, 999999 + RAND() * 9999999), @EMAIL, @MATKHAU, @VAITRO)
END
GO
-- Thêm và cập nhật thông tin khách hàng 
-- DROP PROC AddCustomer
CREATE PROC AddCustomer(
	@ID_ND VARCHAR(16),
	@TENKH NVARCHAR(64),
	@HINHANH VARCHAR(64),
	@NGAYSINH DATE,
	@SDT VARCHAR(16),
	@DIACHI VARCHAR(128)
)
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM KHACHHANG WHERE ID_ND = @ID_ND)
		INSERT INTO KHACHHANG (ID_KH, TENKH, ID_ND, HINHANH, NGAYSINH, SDT, DIACHI) VALUES
		(CONVERT(INT,100 + RAND() * 899), @TENKH, @ID_ND, @HINHANH, @NGAYSINH, @SDT, @DIACHI)
	ELSE
		UPDATE KHACHHANG SET TENKH = @TENKH, HINHANH = @HINHANH, NGAYSINH = @NGAYSINH, SDT = @SDT, DIACHI = @DIACHI WHERE ID_ND = @ID_ND
END
GO
-- Tạo hóa đơn
-- DROP PROC AddInvoice
CREATE PROC AddInvoice(
	@ID_KH VARCHAR(16),
	@ID_BAN VARCHAR(16)
)
AS
BEGIN
	IF EXISTS (SELECT * FROM BAN WHERE ID_BAN = @ID_BAN AND TRANGTHAI = 'Con trong')
	BEGIN
		INSERT INTO HOADON (ID_HOADON, ID_KH, ID_BAN, NGAYHD, TIENGIAM, TONGTIEN, TRANGTHAI) VALUES
		(CONVERT(INT,99999 + RAND() * 9999999), @ID_KH, @ID_BAN, GETDATE(), 0, 0, 'Chua thanh toan')
		UPDATE BAN SET TRANGTHAI = 'Da dat truoc' WHERE ID_BAN = @ID_BAN
	END
END
GO
-- Tạo giỏ hàng và cập nhật giỏ hàng
-- DROP PROC AddCart
CREATE PROC AddCart(
	@ID_GH VARCHAR(16),
	@ID_MONAN VARCHAR(16),
	@SoLuong INT
)
AS
BEGIN
	IF EXISTS (SELECT * FROM GIOHANG WHERE ID_GH = @ID_GH AND ID_MONAN = @ID_MONAN)
		UPDATE GIOHANG SET SOLUONG = (SOLUONG + @SoLuong) WHERE ID_GH = @ID_GH AND ID_MONAN = @ID_MONAN
	ELSE
		INSERT INTO GIOHANG (ID_GH, ID_MONAN, SOLUONG) VALUES
		(@ID_GH, @ID_MONAN, @SoLuong)
END
GO
-- Tạo CTHD
-- DROP PROC AddInvoiceDetail
CREATE PROC AddInvoiceDetail(
	@ID_GH VARCHAR(16),
	@ID_HOADON VARCHAR(16)
)
AS
BEGIN
	INSERT INTO CTHD(ID_HOADON, ID_MONAN, SOLUONG, DONGIA)
	SELECT @ID_HOADON, A.ID_MONAN, SOLUONG, B.DONGIA FROM GIOHANG A JOIN MONAN B ON A.ID_MONAN = B.ID_MONAN AND ISCHECKED = 1
	DELETE GIOHANG WHERE ID_GH = @ID_GH AND ISCHECKED = 1
	UPDATE BAN SET TRANGTHAI = 'Dang dung bua' WHERE ID_BAN = (SELECT ID_BAN FROM HOADON WHERE ID_HOADON = @ID_HOADON)
	UPDATE HOADON SET TONGTIEN = (SELECT SUM(SOLUONG * DONGIA) FROM CTHD WHERE ID_HOADON = @ID_HOADON) WHERE ID_HOADON = @ID_HOADON
END
GO
-- Lấy chi tiết hóa đơn
-- DROP PROC GetInvoiceDetails
CREATE PROC GetInvoiceDetails(
	@ID_GH VARCHAR(16)
)
AS
BEGIN
	SELECT TENMON, HINHANH, SOLUONG, DONGIA, (SOLUONG * DONGIA) AS THANHTIEN, LOAI FROM GIOHANG A JOIN MONAN B ON A.ID_MONAN = B.ID_MONAN AND ID_GH = @ID_GH AND ISCHECKED = 1
END
GO
-- Thanh toán bằng tiền mặt
-- DROP PROC Payment
CREATE PROC Payment(
	@ID_KH VARCHAR(16)
)
AS
BEGIN
	UPDATE BAN SET TRANGTHAI = 'Con trong' WHERE ID_BAN IN (SELECT ID_BAN FROM HOADON WHERE ID_KH = @ID_KH AND TRANGTHAI = 'Chua thanh toan')
	UPDATE HOADON SET TRANGTHAI = 'Da thanh toan' WHERE ID_KH = @ID_KH AND TRANGTHAI = 'Chua thanh toan'
END
GO
-- Lấy doanh thu theo năm
-- DROP PROC GetEarningsByYear
CREATE PROC GetEarningsByYear(
	@Year INT
)
AS
BEGIN
	SELECT FORMAT(NGAYHD, 'MMM', 'en-US') AS [Month], SUM(TONGTIEN) AS Total 
	FROM HOADON
	WHERE YEAR(NGAYHD) = @Year AND TRANGTHAI = 'Da thanh toan'
	GROUP BY FORMAT(NGAYHD, 'MMM', 'en-US'), MONTH(NGAYHD)
	ORDER BY MONTH(NGAYHD)
END
GO



-- DELETE GIOHANG 
-- UPDATE BAN SET TRANGTHAI = 'Con trong'
-- DELETE CTHD
-- DELETE HOADON
-- DELETE VnPayment

-- SELECT * FROM GioHang
-- SELECT * FROM BAN
-- SELECT * FROM VnPayment
-- SELECT * FROM HOADON
-- SELECT * FROM CTHD
-- SELECT * FROM KHACHHANG
-- SELECT * FROM MONAN
-- SELECT * FROM NGUOIDUNG
