CREATE DATABASE DB_QLNhaHang
GO
USE DB_QLNhaHang
GO
-------------------------------------Tạo bảng----------------------------------------
----Tao bang NGUOIDUNG
create table NGUOIDUNG(
	ID_ND VARCHAR(16),
	EMAIL VARCHAR(64) NOT NULL,
	MATKHAU VARCHAR(64) NOT NULL,
	VAITRO VARCHAR(64)
	constraint PK_NGUOIDUNG primary key(ID_ND)
)
GO
---Them rang buoc NGUOIDUNG
alter table NGUOIDUNG
ADD CONSTRAINT uni_NGUOIDING_EMAIL UNIQUE (EMAIL)
add constraint chk_NGUOIDUNG_VAITRO check (VAITRO in ('Khach Hang','Nhan Vien','Nhan Vien Kho','Quan Ly'))

----Tao bang NHANVIEN
create table NHANVIEN(
	ID_NV VARCHAR(16),
	TENNV NVARCHAR(64) NOT NULL,
	NGAYVAOLAM DATE NOT NULL DEFAULT GETDATE(),
	SDT VARCHAR(16) NOT NULL,
	CHUCVU NVARCHAR(64),
	ID_ND VARCHAR(16) DEFAULT NULL,
	ID_NQL VARCHAR(16),
	TINHTRANG NVARCHAR(64)
	constraint PK_NHANVIEN primary key(ID_NV)
)
GO
ALTER TABLE NHANVIEN ADD HINHANH VARCHAR(64)
GO
---Them rang buoc NHANVIEN
alter table NHANVIEN
add constraint chk_NHANVIEN_CHUCVU check (CHUCVU IN ('Phuc vu','Tiep tan','Thu ngan','Bep','Kho','Quan ly'))
alter table NHANVIEN
add constraint chk_NHANVIEN_TINHTRANG check (TINHTRANG IN ('Dang lam viec','Da nghi viec'));
GO
----Tao bang KHACHHANG
create table KHACHHANG(
	ID_KH VARCHAR(16),
	TENKH NVARCHAR(64) NOT NULL,
	NGAYTHAMGIA DATE NOT NULL DEFAULT GETDATE(),
	DOANHSO DECIMAL(10,2) DEFAULT 0,
	DIEMTICHLUY INT DEFAULT 0,
	ID_ND VARCHAR(16) NOT NULL,
	constraint PK_KHACHHANG primary key(ID_KH)
)
GO
ALTER TABLE KHACHHANG ADD HINHANH VARCHAR(64)
ALTER TABLE KHACHHANG ADD NGAYSINH DATE
ALTER TABLE KHACHHANG ADD SDT VARCHAR(16)
ALTER TABLE KHACHHANG ADD DIACHI VARCHAR(128)
GO
----Tao bang MONAN
create table MONAN(
	ID_MONAN VARCHAR(16) NOT NULL,
	TENMON NVARCHAR(64) NOT NULL,
	DONGIA DECIMAL(10,2) NOT NULL,
	LOAI NVARCHAR(64),
	TRANGTHAI NVARCHAR(32),
	constraint PK_MONAN primary key(ID_MONAN)
)
GO
---Them rang buoc MONAN
alter table MONAN
add constraint chk_MONAN_LOAI check (LOAI in ('Aries','Taurus','Gemini','Cancer','Leo','Virgo'
                                          ,'Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'))
alter table MONAN
add constraint chk_MONAN_TRANGTHAI check (TRANGTHAI in('Dang kinh doanh','Ngung kinh doanh'))   
GO
----Tao bang BAN
create table BAN(
	ID_BAN VARCHAR(16) NOT NULL,
	TENBAN NVARCHAR(64) NOT NULL,
	VITRI NVARCHAR(64) NOT NULL,
	TRANGTHAI NVARCHAR(64),
	constraint PK_BAN primary key(ID_BAN)
)
GO
---Them rang buoc BAN
alter table BAN
add constraint chk_BAN_TRANGTHAI check (TRANGTHAI in ('Con trong','Dang dung bua','Da dat truoc'));
GO
----Tao bang VOUCHER
create table VOUCHER(
	CODE_VOUCHER VARCHAR(16) NOT NULL,
	MOTA NVARCHAR(64) NOT NULL,
	PHANTRAM INT,
	LOAIMA NVARCHAR(64),
	SOLUONG INT,
	DIEM DECIMAL(10,2),
	constraint PK_VOUCHER primary key(CODE_VOUCHER)
)
GO
---Them rang buoc VOUCHER
alter table VOUCHER
add constraint chk_VOUCHER_Phantram check (PHANTRAM > 0 AND Phantram <= 100)
alter table VOUCHER
add constraint chk_VOUCHER_LoaiMA check (LOAIMA in ('All','Aries','Taurus','Gemini','Cancer','Leo','Virgo'
                                                 ,'Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces'))
GO
----Tao bang HOADON
create table HOADON(
	ID_HOADON VARCHAR(16) NOT NULL,
	ID_KH VARCHAR(16) NOT NULL,	
	ID_BAN VARCHAR(16) NOT NULL,	
	NGAYHD DATE NOT NULL,
	TIENMONAN DECIMAL(10,2),
	CODE_VOUCHER VARCHAR(16),
	TIENGIAM DECIMAL(10,2),
	TONGTIEN DECIMAL(10,2),
	TRANGTHAI NVARCHAR(64),
	constraint PK_HOADON primary key(ID_HOADON)
)
GO
---Them rang buoc HOADON
alter table HOADON
	add constraint chk_HOADON_TRANGTHAI check (TRANGTHAI in ('Chua thanh toan','Da thanh toan'));
ALTER TABLE HOADON
	ADD CONSTRAINT df_TIENMONAN DEFAULT 0 FOR TIENMONAN;
GO
----Tao bang CTHD
create table CTHD(
	ID_HOADON VARCHAR(16) NOT NULL,
	ID_MONAN VARCHAR(16) NOT NULL,
	SOLUONG INT NOT NULL,
	DONGIA DECIMAL(10,2) NOT NULL
	constraint PK_CTHD primary key(ID_HOADON, ID_MONAN)
)
GO
----Tao bang NGUYENLIEU
create table NGUYENLIEU(
	ID_NL VARCHAR(16) NOT NULL,
	TENNL NVARCHAR(64) NOT NULL,
	DONGIA DECIMAL(10,2) NOT NULL, 
	DONVITINH NVARCHAR(16),
	constraint PK_NGUYENLIEU primary key(ID_NL)
)
GO
---Them rang buoc NGUYENLIEU
alter table NGUYENLIEU
    add constraint chk_NGUYENLIEU_DONVITINH check (DONVITINH in ('g','kg','ml','l'));
GO
----Tao bang KHO
create table KHO(
	ID_NL VARCHAR(16) NOT NULL,
	SLTON INT DEFAULT 0,
	constraint PK_KHO primary key(ID_NL)
)
GO
----Tao bang PHIEUNK
create table PHIEUNK(
	ID_NK VARCHAR(16) NOT NULL,
	ID_NV VARCHAR(16) NOT NULL,
	NGAYNK DATE NOT NULL,
	TONGTIEN DECIMAL(10,2) DEFAULT 0,
	constraint PK_PHIEUNK primary key(ID_NK)
)
GO
----Tao bang PHIEUNK
create table CTNK(
	ID_NK VARCHAR(16) NOT NULL,
	ID_NL VARCHAR(16) NOT NULL,
	SOLUONG INT NOT NULL,
	THANHTIEN DECIMAL(10,2),
	constraint PK_CTNK primary key(ID_NK,ID_NL)
)
GO
----Tao bang PHIEUXK
create table PHIEUXK(
	ID_XK VARCHAR(16) NOT NULL,
	ID_NV VARCHAR(16) NOT NULL,
	NGAYXK DATE NOT NULL,
	constraint PK_PHIEUXK primary key(ID_XK)
)
GO
----Tao bang CTXK
create table CTXK(
	ID_XK VARCHAR(16) NOT NULL,
	ID_NL VARCHAR(16) NOT NULL,
	SOLUONG INT NOT NULL,
	constraint PK_CTXK primary key(ID_XK,ID_NL)
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

------------------------------------Khóa Ngoại-------------------------------------
------------Khoa ngoai NHANVIEN
alter table NHANVIEN
add constraint FK_NHANVIEN_NGUOIDUNG foreign key(ID_ND) references NGUOIDUNG(ID_ND)-------1

alter table NHANVIEN
add constraint FK_NHANVIEN_NHANVIEN foreign key(ID_NQL) references NHANVIEN(ID_NV)

------------Khoa ngoai KHACHHANG
alter table KHACHHANG
add constraint FK_KHACHHANG_NGUOIDUNG foreign key(ID_ND) references NGUOIDUNG(ID_ND)

------------Khoa ngoai HOADON
alter table HOADON
add constraint FK_HOADON_KHACHHANG foreign key(ID_KH) references KHACHHANG(ID_KH)

alter table HOADON
add constraint FK_HOADON_BAN foreign key(ID_BAN) references BAN(ID_BAN)

alter table HOADON
add constraint FK_HOADON_VOUCHER foreign key(CODE_VOUCHER) references VOUCHER(CODE_VOUCHER)

------------Khoa ngoai CTHD
alter table CTHD
add constraint FK_CTHD_HOADON foreign key(ID_HOADON) references HOADON(ID_HOADON)

alter table CTHD
add constraint FK_CTHD_MONAN foreign key(ID_MONAN) references MONAN(ID_MONAN)

------------Khoa ngoai KHO
alter table KHO
add constraint FK_KHO_NGUYENLIEU foreign key(ID_NL) references NGUYENLIEU(ID_NL)

------------Khoa ngoai PHIEUNK
alter table PHIEUNK
add constraint FK_PHIEUNK_NHANVIEN foreign key(ID_NV) references NHANVIEN(ID_NV)

------------Khoa ngoai CTNK
alter table CTNK
add constraint FK_CTNK_PHIEUNK foreign key(ID_NK) references PHIEUNK(ID_NK)

alter table CTNK
add constraint FK_CTNK_NGUYENLIEU foreign key(ID_NL) references NGUYENLIEU(ID_NL)

------------Khoa ngoai PHIEUXK
alter table PHIEUXK
add constraint FK_PHIEUXK_NHANVIEN foreign key(ID_NV) references NHANVIEN(ID_NV)

------------Khoa ngoai CTXK
alter table CTXK
add constraint FK_CTXK_PHIEUXK foreign key(ID_XK) references PHIEUXK(ID_XK)

alter table CTXK
add constraint FK_CTXK_NGUYENLIEU foreign key(ID_NL) references NGUYENLIEU(ID_NL)
GO



------------------------------Nhập liệu-----------------------------
-- Dữ liệu cho bảng NGUOIDUNG
-------Tai khoan Nguoi Dung Cua Nhan Vien
-- INSERT INTO NGUOIDUNG(ID_ND,Email,MatKhau,Vaitro) VALUES (100,'NDH@gmail.com','123','Quan Ly')
-- INSERT INTO NGUOIDUNG(ID_ND,Email,MatKhau,Vaitro) VALUES (101,'PTH@gmail.com','123','Nhan Vien')
-------Tai khoan Nguoi Dung Cua Khach Hang
-- INSERT INTO NGUOIDUNG(ID_ND,Email,MatKhau,Vaitro) VALUES (102,'HQK@gmail.com','123','Khach Hang')

-- Dữ liệu cho bảng NHANVIEN
-- set dateformat DMY
--Co tai khoan
-- INSERT INTO NhanVien(ID_NV,TenNV,NGAYVAOLAM,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (110,'Pham Tuan Han','19/05/2023','0838033234','Tiep tan',116,100,'Dang lam viec')
-- INSERT INTO NhanVien(ID_NV,TenNV,NGAYVAOLAM,SDT,Chucvu,ID_ND,ID_NQL,Tinhtrang) VALUES (111,'Nguyen Duc Hien','26/05/2024','0333172760','Quan ly',114,100,'Dang lam viec')
--Khong co tai khoan
-- INSERT INTO NhanVien(ID_NV,TenNV,NGAYVAOLAM,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (104,'Ha Thao Duong','10/05/2023','0838033232','Phuc vu',100,'Dang lam viec')
-- INSERT INTO NhanVien(ID_NV,TenNV,NGAYVAOLAM,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (105,'Nguyen Quoc Thinh','11/05/2023','0838033734','Phuc vu',100,'Dang lam viec')
-- INSERT INTO NhanVien(ID_NV,TenNV,NGAYVAOLAM,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (106,'Truong Tan Hieu','12/05/2023','0838033834','Phuc vu',100,'Dang lam viec')
-- INSERT INTO NhanVien(ID_NV,TenNV,NGAYVAOLAM,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (107,'Nguyen Thai Bao','10/05/2023','0838093234','Phuc vu',100,'Dang lam viec')
-- INSERT INTO NhanVien(ID_NV,TenNV,NGAYVAOLAM,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (108,'Tran Nhat Khang','11/05/2023','0838133234','Thu ngan',100,'Dang lam viec')
-- INSERT INTO NhanVien(ID_NV,TenNV,NGAYVAOLAM,SDT,Chucvu,ID_NQL,Tinhtrang) VALUES (109,'Nguyen Ngoc Luong','12/05/2023','0834033234','Bep',100,'Dang lam viec')

-- Dữ liệu cho bảng KHACHHANG
-- INSERT INTO KhachHang(ID_KH,TenKH,Ngaythamgia,ID_ND) VALUES (110,'Huynh Quang Khiem','09/02/2003',115)

-- Dữ liệu cho bảng MONAN
--Aries
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(1,'DUI CUU NUONG XE NHO', 250000,'Aries','Dang kinh doanh','1.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(2,'BE SUON CUU NUONG GIAY BAC MONG CO', 230000,'Aries','Dang kinh doanh','2.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(3,'DUI CUU NUONG TRUNG DONG', 350000,'Aries','Dang kinh doanh','3.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(4,'CUU XOC LA CA RI', 129000,'Aries','Dang kinh doanh','4.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(5,'CUU KUNGBAO', 250000,'Aries','Dang kinh doanh','5.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(6,'BAP CUU NUONG CAY', 250000,'Aries','Dang kinh doanh','6.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(7,'CUU VIEN HAM CAY', 19000,'Aries','Dang kinh doanh','7.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(8,'SUON CONG NUONG MONG CO', 250000,'Aries','Dang kinh doanh','8.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(9,'DUI CUU LON NUONG TAI BAN', 750000,'Aries','Dang kinh doanh','9.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(10,'SUONG CUU NUONG SOT NAM', 450000,'Aries','Dang kinh doanh','10.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(11,'DUI CUU NUONG TIEU XANH', 285000,'Aries','Dang kinh doanh','11.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(12,'SUON CUU SOT PHO MAI', 450000,'Aries','Dang kinh doanh', '12.jpg');

--Taurus
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(13,'Bit tet bo My khoai tay', 179000,'Taurus','Dang kinh doanh','13.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(14,'Bo bit tet Uc',169000,'Taurus','Dang kinh doanh','14.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(15,'Bit tet bo My BASIC', 179000,'Taurus','Dang kinh doanh','15.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(16,'My Y bo bam', 169000,'Taurus','Dang kinh doanh','16.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(17,'Thit suon Wagyu', 1180000,'Taurus','Dang kinh doanh','17.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(18,'Steak Thit Vai Wagyu', 1290000,'Taurus','Dang kinh doanh','18.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(19,'Steak Thit Bung Bo', 550000,'Taurus','Dang kinh doanh','19.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(20,'Tomahawk', 2390000,'Taurus','Dang kinh doanh','20.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(21,'Salad Romaine Nuong', 180000,'Taurus','Dang kinh doanh', '21.jpg');

--Gemini
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(22,'Combo Happy', 180000,'Gemini','Dang kinh doanh','22.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(23,'Combo Fantastic', 190000,'Gemini','Dang kinh doanh','23.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(24,'Combo Dreamer', 230000,'Gemini','Dang kinh doanh','24.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(25,'Combo Cupid', 180000,'Gemini','Dang kinh doanh','25.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(26,'Combo Poseidon', 190000,'Gemini','Dang kinh doanh','26.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(27,'Combo LUANG PRABANG', 490000,'Gemini','Dang kinh doanh','27.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(28,'Combo VIENTIANE', 620000,'Gemini','Dang kinh doanh', '28.jpg');

--Cancer
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(29,'Cua KingCrab Duc sot', 3650000,'Cancer','Dang kinh doanh','29.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(30,'Mai Cua KingCrab Topping Pho Mai', 2650000,'Cancer','Dang kinh doanh','30.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(31,'Cua KingCrab sot Tu Xuyen', 2300000,'Cancer','Dang kinh doanh','31.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(32,'Cua KingCrab Nuong Tu Nhien', 2550000,'Cancer','Dang kinh doanh','32.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(33,'Cua KingCrab Nuong Bo Toi', 2650000,'Cancer','Dang kinh doanh','33.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(34,'Com Mai Cua KingCrab Chien', 1850000,'Cancer','Dang kinh doanh', '34.jpg');

--Leo
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(35,'BOSSAM', 650000,'Leo','Dang kinh doanh','35.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(36,'KIMCHI PANCAKE', 350000,'Leo','Dang kinh doanh','36.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(37,'SPICY RICE CAKE', 250000,'Leo','Dang kinh doanh','37.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(38,'SPICY SAUSAGE HOTPOT', 650000,'Leo','Dang kinh doanh','38.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(39,'SPICY PORK', 350000,'Leo','Dang kinh doanh','39.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(40,'MUSHROOM SPICY SILKY TOFU STEW', 350000,'Leo','Dang kinh doanh', '40.jpg');
--Virgo
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(41,'Pavlova', 150000,'Virgo','Dang kinh doanh','41.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(42,'Kesutera', 120000,'Virgo','Dang kinh doanh','42.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(43,'Cremeschnitte', 250000,'Virgo','Dang kinh doanh','43.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(44,'Sachertorte', 150000,'Virgo','Dang kinh doanh','44.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(45,'Schwarzwalder Kirschtorte', 250000,'Virgo','Dang kinh doanh','45.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(46,'New York-Style Cheesecake', 250000,'Virgo','Dang kinh doanh', '46.jpg');

--Libra
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(47,'Cobb Salad', 150000,'Libra','Dang kinh doanh','47.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(48,'Salad Israeli', 120000,'Libra','Dang kinh doanh','48.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(49,'Salad Dau den', 120000,'Libra','Dang kinh doanh','49.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(50,'Waldorf Salad', 160000,'Libra','Dang kinh doanh','50.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(51,'Salad Gado-Gado', 200000,'Libra','Dang kinh doanh','51.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(52,'Nicoise Salad', 250000,'Libra','Dang kinh doanh', '52.jpg');

--Scorpio
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(53,'BULGOGI LUNCHBOX', 250000,'Scorpio','Dang kinh doanh','53.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(54,'CHICKEN TERIYAKI LUNCHBOX', 350000,'Scorpio','Dang kinh doanh','54.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(55,'SPICY PORK LUNCHBOX', 350000,'Scorpio','Dang kinh doanh','55.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(56,'TOFU TERIYAKI LUNCHBOX', 250000,'Scorpio','Dang kinh doanh', '56.jpg');

--Sagittarius
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(57,'Thit ngua do tuoi', 250000,'Sagittarius','Dang kinh doanh','57.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(58,'Steak Thit ngua', 350000,'Sagittarius','Dang kinh doanh','58.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(59,'Thit ngua ban gang', 350000,'Sagittarius','Dang kinh doanh','59.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(60,'Long ngua xao dua', 150000,'Sagittarius','Dang kinh doanh','60.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(61,'Thit ngua xao sa ot', 250000,'Sagittarius','Dang kinh doanh','61.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(62,'Ngua tang', 350000,'Sagittarius','Dang kinh doanh','62.jpg');

--Capricorn
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(63,'Thit de xong hoi', 229000,'Capricorn','Dang kinh doanh','63.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(64,'Thit de xao rau ngo', 199000,'Capricorn','Dang kinh doanh','64.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(65,'Thit de nuong tang', 229000,'Capricorn','Dang kinh doanh','65.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(66,'Thit de chao', 199000,'Capricorn','Dang kinh doanh','66.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(67,'Thit de nuong xien', 199000,'Capricorn','Dang kinh doanh','67.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(68,'Nam de nuong/chao', 199000,'Capricorn','Dang kinh doanh','68.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(69,'Thit de xao lan', 19000,'Capricorn','Dang kinh doanh','69.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(70,'Dui de tan thuoc bac', 199000,'Capricorn','Dang kinh doanh','70.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(71,'Canh de ham duong quy', 199000,'Capricorn','Dang kinh doanh','71.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(72,'Chao de dau xanh', 50000,'Capricorn','Dang kinh doanh','72.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(73,'Thit de nhung me', 229000,'Capricorn','Dang kinh doanh','74.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(74,'Lau de nhu', 499000,'Capricorn','Dang kinh doanh', '75.jpg');


--Aquarius
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(75,'SIGNATURE WINE', 3290000,'Aquarius','Dang kinh doanh','75.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(76,'CHILEAN WINE', 3990000,'Aquarius','Dang kinh doanh','76.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(77,'ARGENTINA WINE', 2890000,'Aquarius','Dang kinh doanh','77.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(78,'ITALIAN WINE', 5590000,'Aquarius','Dang kinh doanh','78.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(79,'AMERICAN WINE', 4990000,'Aquarius','Dang kinh doanh','79.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(80,'CLASSIC COCKTAIL', 200000,'Aquarius','Dang kinh doanh','80.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(81,'SIGNATURE COCKTAIL', 250000,'Aquarius','Dang kinh doanh','81.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(82,'MOCKTAIL', 160000,'Aquarius','Dang kinh doanh','82.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(83,'JAPANESE SAKE', 1490000,'Aquarius','Dang kinh doanh','83.jpg');

--Pisces
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(84,'Ca Hoi Ngam Tuong', 289000,'Pisces','Dang kinh doanh','84.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(85,'Ca Ngu Ngam Tuong', 289000,'Pisces','Dang kinh doanh','85.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(86,'IKURA:Trung ca hoi', 189000,'Pisces','Dang kinh doanh','86.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(87,'KARIN:Sashimi Ca Ngu', 149000,'Pisces','Dang kinh doanh','87.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(88,'KEIKO:Sashimi Ca Hoi', 199000,'Pisces','Dang kinh doanh','88.jpg');
insert into MonAn(ID_MonAn,TenMon,Dongia,Loai,TrangThai,HINHANH) values(89,'CHIYO:Sashimi Bung Ca Hoi', 219000,'Pisces','Dang kinh doanh', '89.jpg');

-- Dữ liệu cho bảng BAN
--Tang 1
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(100,'Ban T1.1','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(101,'Ban T1.2','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(102,'Ban T1.3','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(103,'Ban T1.4','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(104,'Ban T1.5','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(105,'Ban T1.6','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(106,'Ban T1.7','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(107,'Ban T1.8','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(108,'Ban T1.9','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(109,'Ban T1.10','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(110,'Ban T1.11','Tang 1','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(111,'Ban T1.12','Tang 1','Con trong');
--Tang 2
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(112,'Ban T2.1','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(113,'Ban T2.2','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(114,'Ban T2.3','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(115,'Ban T2.4','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(116,'Ban T2.5','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(117,'Ban T2.6','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(118,'Ban T2.7','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(119,'Ban T2.8','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(120,'Ban T2.9','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(121,'Ban T2.10','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(122,'Ban T2.11','Tang 2','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(123,'Ban T2.12','Tang 2','Con trong');
--Tang 3
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(124,'Ban T3.1','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(125,'Ban T3.2','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(126,'Ban T3.3','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(127,'Ban T3.4','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(128,'Ban T3.5','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(129,'Ban T3.6','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(130,'Ban T3.7','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(131,'Ban T3.8','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(132,'Ban T3.9','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(133,'Ban T3.10','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(134,'Ban T3.11','Tang 3','Con trong');
insert into Ban(ID_Ban,TenBan,Vitri,Trangthai) values(135,'Ban T3.12','Tang 3','Con trong');

DELETE BAN

-- Dữ liệu cho bảng VOUCHER
insert into Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) values ('loQy','20% off for Aries Menu',20,'Aries',10,200);
insert into Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) values ('pCfI','30% off for Taurus Menu',30,'Taurus',5,300);
insert into Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) values ('pApo','20% off for Gemini Menu',20,'Gemini',10,200);
insert into Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) values ('ugQx','100% off for Virgo Menu',100,'Virgo',3,500);
insert into Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) values ('nxVX','20% off for All Menu',20,'All',5,300);
insert into Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) values ('Pwyn','20% off for Cancer Menu',20,'Cancer',10,200);
insert into Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) values ('bjff','50% off for Leo Menu',50,'Leo',5,600);
insert into Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) values ('YPzJ','20% off for Aquarius Menu',20,'Aquarius',5,200);
insert into Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) values ('Y5g0','30% off for Pisces Menu',30,'Pisces',5,300);
insert into Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) values ('7hVO','60% off for Aries Menu',60,'Aries',0,1000);
insert into Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) values ('WHLm','20% off for Capricorn Menu',20,'Capricorn',0,200);
insert into Voucher(Code_Voucher,MOTA,Phantram,LoaiMA,SoLuong,Diem) values ('GTsC','20% off for Leo Menu',20,'Leo',0,200);

-- Dữ liệu cho bảng HOADON
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (101,100,100,'10-1-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (102,104,102,'15-1-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (103,105,103,'20-1-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (104,101,101,'13-2-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (105,103,120,'12-2-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (106,104,100,'16-3-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (107,107,103,'20-3-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (108,108,101,'10-4-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (109,100,100,'20-4-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (110,103,101,'5-5-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (111,106,102,'10-5-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (112,108,103,'15-5-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (113,106,102,'20-5-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (114,108,103,'5-6-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (115,109,104,'7-6-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (116,100,105,'7-6-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (117,106,106,'10-6-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (118,102,106,'10-2-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (119,103,106,'12-2-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (120,104,106,'10-4-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (121,105,106,'12-4-2023',0,0,'Chua thanh toan');
-- INSERT INTO HoaDon(ID_HoaDon,ID_KH,ID_Ban,NgayHD,TienMonAn,TienGiam,Trangthai) VALUES (122,107,106,'12-5-2023',0,0,'Chua thanh toan');

-- Dữ liệu cho bảng CTHD
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,1,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,3,1);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (101,10,3);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,1,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,2,1);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (102,4,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (103,12,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (104,30,3);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (104,59,4);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (105,28,1);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (105,88,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,70,3);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,75,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (106,78,4);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (107,32,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (107,12,5);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (108,12,1);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (108,40,4);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (109,45,4);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (110,34,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (110,43,4);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (111,65,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (111,47,4);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,49,3);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,80,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (112,31,5);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (113,80,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (113,80,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (114,30,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (114,32,3);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (115,80,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (116,57,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (116,34,1);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (117,67,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (117,66,3);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (118,34,10);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (118,35,5);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (119,83,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (119,78,2);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (120,38,5);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (120,39,4);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (121,53,5);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (121,31,4);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (122,33,5);
-- INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (122,34,6);

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

--Them data cho PhieuNK
-- INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (100,102,'10-01-2023');
-- INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (101,102,'11-02-2023');
-- INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (102,102,'12-02-2023');
-- INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (103,102,'12-03-2023');
-- INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (104,102,'15-03-2023');
-- INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (105,102,'12-04-2023');
-- INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (106,102,'15-04-2023');
-- INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (107,102,'12-05-2023');
-- INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (108,102,'15-05-2023');
-- INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (109,102,'5-06-2023');
-- INSERT INTO PhieuNK(ID_NK,ID_NV,NgayNK) VALUES (110,102,'7-06-2023');


-- --Them data cho CTNK
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,100,10);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,101,20);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (100,102,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,101,10);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,103,20);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,104,10);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,105,10);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,106,20);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,107,5);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (101,108,5);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,109,10);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,110,20);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,112,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,113,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (102,114,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,112,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,113,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (103,114,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (104,112,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (104,113,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (105,110,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (106,102,25);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (106,115,25);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (107,110,35);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (107,105,25);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,104,25);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,103,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (108,106,30);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,112,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,113,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (109,114,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,102,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,106,25);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,107,15);
-- INSERT INTO CTNK(ID_NK,ID_NL,SoLuong) VALUES (110,110,20);
 

-- --Them data cho PhieuXK
-- INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (100,102,'10-01-2023');
-- INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (101,102,'11-02-2023');
-- INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (102,102,'12-03-2023');
-- INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (103,102,'13-03-2023');
-- INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (104,102,'12-04-2023');
-- INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (105,102,'13-04-2023');
-- INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (106,102,'12-05-2023');
-- INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (107,102,'15-05-2023');
-- INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (108,102,'20-05-2023');
-- INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (109,102,'5-06-2023');
-- INSERT INTO PhieuXK(ID_XK,ID_NV,NgayXK) VALUES (110,102,'10-06-2023');


-- --Them data cho CTXK
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,100,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,101,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (100,102,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,101,7);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,103,10);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,104,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,105,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (101,106,10);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,109,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,110,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,112,10);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,113,8);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (102,114,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (103,114,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (103,104,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (104,101,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (104,112,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (105,113,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (105,102,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (106,103,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (106,114,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (107,105,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (107,106,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (108,115,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (108,110,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (109,110,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (109,112,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (110,113,5);
-- INSERT INTO CTXK(ID_XK,ID_NL,SoLuong) VALUES (110,114,5);

--- PROCEDURE
-- Thêm tài khoản người dùng
GO
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
-- DROP PROC GetInvoiceDetails
CREATE PROC GetInvoiceDetails(
	@ID_GH VARCHAR(16)
)
AS
BEGIN
	SELECT TENMON, HINHANH, SOLUONG, DONGIA, (SOLUONG * DONGIA) AS THANHTIEN, LOAI FROM GIOHANG A JOIN MONAN B ON A.ID_MONAN = B.ID_MONAN AND ID_GH = @ID_GH AND ISCHECKED = 1
END
GO
-- Thanh toan bang tien mat
-- DROP PROC PayCost
CREATE PROC PayCost(
	@ID_KH VARCHAR(16)
)
AS
BEGIN
	UPDATE BAN SET TRANGTHAI = 'Con trong' WHERE ID_BAN IN (SELECT ID_BAN FROM HOADON WHERE ID_KH = @ID_KH AND TRANGTHAI = 'Chua thanh toan')
	UPDATE HOADON SET TRANGTHAI = 'Da thanh toan' WHERE ID_KH = @ID_KH AND TRANGTHAI = 'Chua thanh toan'
END
GO


DELETE GIOHANG 
UPDATE BAN SET TRANGTHAI = 'Con trong'
DELETE CTHD
DELETE HOADON

SELECT * FROM GioHang
SELECT * FROM BAN
SELECT * FROM HOADON
SELECT * FROM CTHD
SELECT * FROM KHACHHANG
SELECT * FROM MONAN
SELECT * FROM NGUOIDUNG

SELECT * FROM HOADON WHERE ID_BAN = 101 AND TRANGTHAI = 'Chua thanh toan'

SELECT * FROM CTHD WHERE ID_HOADON = 5596760