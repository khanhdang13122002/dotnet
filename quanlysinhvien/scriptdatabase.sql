USE [master]
GO
/****** Object:  Database [QuanLiSinhVien]    Script Date: 10/06/2021 7:47:32 SA ******/
CREATE DATABASE [QuanLiSinhVien]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLiSinhVien', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.KHANH\MSSQL\DATA\QuanLiSinhVien.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLiSinhVien_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.KHANH\MSSQL\DATA\QuanLiSinhVien_log.ldf' , SIZE = 1792KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuanLiSinhVien] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLiSinhVien].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLiSinhVien] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLiSinhVien] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLiSinhVien] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QuanLiSinhVien] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLiSinhVien] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLiSinhVien] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLiSinhVien] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLiSinhVien] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLiSinhVien] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLiSinhVien] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QuanLiSinhVien] SET DELAYED_DURABILITY = DISABLED 
GO
USE [QuanLiSinhVien]
GO
/****** Object:  UserDefinedFunction [dbo].[FUNC_Diem4]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FUNC_Diem4](
	@xl char(2))
RETURNS float
AS
BEGIN
	IF(@xl = 'D')
		return 1.0
	ELSE IF(@xl = 'D+')
		return 1.5
	ELSE IF(@xl = 'C')
		return 2.0
	ELSE IF(@xl = 'C+')
		return 2.5
	ELSE IF(@xl = 'B')
		return 3.0
	ELSE IF(@xl = 'B+')
		return 3.5
	ELSE
		return 4.0
	return 0
END
GO
/****** Object:  UserDefinedFunction [dbo].[FUNC_DiemTB]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FUNC_DiemTB](
	@C float,
	@B float,
	@A float)
RETURNS float
BEGIN
	DECLARE @Tong float
	SET @Tong = @C*0.1 + @B*0.3 + @A*0.6
	RETURN Round(@Tong,1)
END

GO
/****** Object:  UserDefinedFunction [dbo].[FUNC_DiemTB4KiHoc]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FUNC_DiemTB4KiHoc](
	@Masv char(10),
	@KiHoc int)
RETURNS float
AS
BEGIN
	DECLARE @tb float
	SET @tb= 0
	IF(@KiHoc > 0)
	BEGIN
		Set @tb =  (SELECT ROUND(SUM(dbo.FUNC_Diem4(dbo.FUNC_XepLoai(dbo.FUNC_DiemTB(Diem.C,Diem.B,diem.A)))*MonHoc.SoTinChi)/SUM(MonHoc.SoTinChi),2) as 'Tb' FROM Diem,MonHoc WHERE Diem.MaMH = MonHoc.MaMH and dbo.FUNC_DiemTB(Diem.C,Diem.B,diem.A) >= 4.0 and KiHoc = @KiHoc and MaSV = @Masv )
	END
	ELSE
	BEGIN
		Set @tb =  (SELECT ROUND(SUM(dbo.FUNC_Diem4(dbo.FUNC_XepLoai(dbo.FUNC_DiemTB(Diem.C,Diem.B,diem.A)))*MonHoc.SoTinChi)/SUM(MonHoc.SoTinChi),2) as 'Tb' FROM Diem,MonHoc WHERE Diem.MaMH = MonHoc.MaMH and dbo.FUNC_DiemTB(Diem.C,Diem.B,diem.A) >= 4.0 and MaSV = @Masv )
	END
	RETURN @tb
END


GO
/****** Object:  UserDefinedFunction [dbo].[FUNC_DiemTBKiHoc]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FUNC_DiemTBKiHoc](
	@Masv char(10),
	@KiHoc int)
RETURNS float
AS
BEGIN
	DECLARE @tb float
	SET @tb= 0
	IF(@KiHoc >0)
	BEGIN
		Set @tb =  (SELECT ROUND(SUM(dbo.FUNC_DiemTB(Diem.C,Diem.B,diem.A)*MonHoc.SoTinChi)/SUM(MonHoc.SoTinChi),2) as 'Tb' FROM Diem,MonHoc WHERE Diem.MaMH = MonHoc.MaMH and dbo.FUNC_DiemTB(Diem.C,Diem.B,diem.A) >= 4.0 and KiHoc = @KiHoc and MaSV = @Masv )
	END
	ELSE
	BEGIN
		Set @tb =  (SELECT ROUND(SUM(dbo.FUNC_DiemTB(Diem.C,Diem.B,diem.A)*MonHoc.SoTinChi)/SUM(MonHoc.SoTinChi),2) as 'Tb' FROM Diem,MonHoc WHERE Diem.MaMH = MonHoc.MaMH and dbo.FUNC_DiemTB(Diem.C,Diem.B,diem.A) >= 4.0 and MaSV = @Masv )
	END
	RETURN @tb
END
GO
/****** Object:  UserDefinedFunction [dbo].[FUNC_HocBong]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FUNC_HocBong](
	@KiHoc int)
RETURNS @TbHocBong TABLE
(
	MaSV char(10),
	HoTen nvarchar(25),
	MaLop char(10)
)
AS
	BEGIN
		INSERT INTO @TbHocBong 
			SELECT SinhVien.MaSV,SinhVien.HoTen,SinhVien.MaLop
				FROM Diem inner join SinhVien on SinhVien.MaSv = Diem.MaSV
					 WHERE  SinhVien.MaSV NOT IN (Select MaSV From Diem WHERE dbo.FUNC_DiemTB(diem.C,diem.B,diem.A) < 5.0 and KiHoc = @KiHoc GROUP BY MaSV)and dbo.FUNC_DiemTB4KiHoc(SinhVien.MaSV,@KiHoc) >= 2.5 and Diem.KiHoc = @KiHoc
		GROUP BY SinhVien.MaSV,SinhVien.HoTen,SinhVien.MaLop
		RETURN
	END


GO
/****** Object:  UserDefinedFunction [dbo].[FUNC_KiHoc_CheckNull]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FUNC_KiHoc_CheckNull](
	@KiHoc int)
RETURNS BIT
AS
BEGIN
	DECLARE @count int;
	SET @count = (SELECT COUNT(KiHoc) FROM HocKi WHERE KiHoc = @KiHoc)
	IF(@count > 0)
		RETURN 0
	RETURN 1
END
GO
/****** Object:  UserDefinedFunction [dbo].[FUNC_SinhVien_CheckNull]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FUNC_SinhVien_CheckNull](
	@MaSV char(10))
RETURNS BIT
AS
BEGIN
	DECLARE @num int
	SET @num = (SELECT Count(MaSV) FROM SinhVien WHERE MaSV = @MaSV GROUP BY MaSV)
	IF(@num > 0)
		RETURN 0 
	RETURN 1
END
GO
/****** Object:  UserDefinedFunction [dbo].[FUNC_TongTC]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FUNC_TongTC](
	@MaSV char(10),
	@KiHoc int)
RETURNS int
AS
BEGIN
	DECLARE @tong int
	SET @tong = (SELECT SUM(MonHoc.SoTinChi) FROM Diem,MonHoc WHERE Diem.MaMH = MonHoc.MaMH and Diem.MaSV = @MaSV and Diem.KiHoc = @KiHoc GROUP BY Diem.MaSV)
	RETURN @tong
END
GO
/****** Object:  UserDefinedFunction [dbo].[FUNC_TongTinChiDaHoc]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FUNC_TongTinChiDaHoc](
	@MaSV char(10),
	@KiHoc int)
RETURNS INT
AS
BEGIN
	IF(@KiHoc > 0)
		RETURN (SELECT SUM(MonHoc.SoTinChi) FROM Diem,MonHoc WHERE Diem.MaMH = MonHoc.MaMH and dbo.FUNC_DiemTB(Diem.C,Diem.B,diem.A) >= 4.0 and MaSV = @MaSV and Diem.KiHoc = @KiHoc)
	RETURN (SELECT SUM(MonHoc.SoTinChi) FROM Diem,MonHoc WHERE Diem.MaMH = MonHoc.MaMH and dbo.FUNC_DiemTB(Diem.C,Diem.B,diem.A) >= 4.0 and Diem.MaSV = @MaSV)
END
GO
/****** Object:  UserDefinedFunction [dbo].[FUNC_XepLoai]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FUNC_XepLoai](
	@DiemTB float)
RETURNS char(2)
AS
BEGIN
	if(@DiemTB < 4.0)
		RETURN 'F'
	else if(@DiemTB >= 4.0 and @DiemTB <= 5.0)
		RETURN 'D'
	else if(@DiemTB >= 5.0 and @DiemTB <  5.5)
		RETURN 'D+'
	else if(@DiemTB >= 5.5 and @DiemTB <  6.5)
		RETURN 'C'
	else if(@DiemTB >= 6.5 and @DiemTB <  7.0)
		RETURN 'C+'
	else if(@DiemTB >= 7.0 and @DiemTB <  8.0)
		RETURN 'B'
	else if(@DiemTB >= 8.0 and @DiemTB <  8.5)
		RETURN 'B+'
	else if(@DiemTB >= 8.5)
		RETURN 'A'
	RETURN ''
END
GO
/****** Object:  Table [dbo].[BoMon]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BoMon](
	[MaBM] [char](10) NOT NULL,
	[TenBM] [nvarchar](50) NULL,
	[MaKhoa] [char](10) NULL,
 CONSTRAINT [PK_BoMon] PRIMARY KEY CLUSTERED 
(
	[MaBM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChuyenNganh]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChuyenNganh](
	[MaCN] [char](10) NOT NULL,
	[TenCN] [nvarchar](100) NULL,
	[MaKhoa] [char](10) NULL,
 CONSTRAINT [PK_ChuyenNganh] PRIMARY KEY CLUSTERED 
(
	[MaCN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CTKhoaHoc]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CTKhoaHoc](
	[MaKH] [int] NOT NULL,
	[MaSV] [char](10) NOT NULL,
 CONSTRAINT [PK_CTKhoaHoc] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC,
	[MaSV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Diem]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Diem](
	[MaSV] [char](10) NOT NULL,
	[MaMH] [char](10) NOT NULL,
	[C] [float] NULL,
	[B] [float] NULL,
	[A] [float] NULL,
	[KiHoc] [int] NOT NULL,
 CONSTRAINT [PK_Diem] PRIMARY KEY CLUSTERED 
(
	[MaSV] ASC,
	[MaMH] ASC,
	[KiHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GiangVien]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GiangVien](
	[MaGV] [char](10) NOT NULL,
	[HoTen] [nvarchar](25) NULL,
	[GioiTinh] [bit] NULL,
	[NgaySinh] [date] NULL,
	[QueQuan] [nvarchar](25) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[EMail] [char](50) NULL,
	[SDT] [char](11) NULL,
	[MaBM] [char](10) NULL,
	[Pic] [char](15) NULL,
 CONSTRAINT [PK_GiangVien] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HanhKiem]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HanhKiem](
	[MaSV] [char](10) NOT NULL,
	[Diem] [int] NULL,
	[KiHoc] [int] NOT NULL CONSTRAINT [DF_HanhKiem_NamHoc]  DEFAULT ((1)),
 CONSTRAINT [PK_HanhKiem] PRIMARY KEY CLUSTERED 
(
	[MaSV] ASC,
	[KiHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HocKi]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocKi](
	[KiHoc] [int] NOT NULL,
	[BatDau] [date] NULL,
	[KetThuc] [date] NULL,
 CONSTRAINT [PK_HocKi] PRIMARY KEY CLUSTERED 
(
	[KiHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Khoa]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Khoa](
	[MaKhoa] [char](10) NOT NULL,
	[TenKhoa] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[SoDienThoai] [nvarchar](25) NULL,
 CONSTRAINT [PK_Khoa] PRIMARY KEY CLUSTERED 
(
	[MaKhoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhoaHoc]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhoaHoc](
	[MaKH] [int] IDENTITY(1,1) NOT NULL,
	[MaMH] [char](10) NULL,
	[MaGV] [char](10) NULL,
	[KiHoc] [int] NULL,
 CONSTRAINT [PK_KhoaHoc] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LichSu]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LichSu](
	[ID] [char](10) NOT NULL,
	[ThaoTac] [nvarchar](50) NULL,
	[ThoiGian] [varchar](100) NULL,
 CONSTRAINT [PK_LichSu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Lop]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Lop](
	[MaLop] [char](10) NOT NULL,
	[TenLop] [nvarchar](50) NULL,
	[MaGV] [char](10) NULL,
	[MaCN] [char](10) NULL,
	[NienKhoa] [int] NULL,
 CONSTRAINT [PK_Lop] PRIMARY KEY CLUSTERED 
(
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MonHoc]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MonHoc](
	[MaMH] [char](10) NOT NULL,
	[TenMH] [nchar](100) NULL,
	[SoTinChi] [int] NULL,
 CONSTRAINT [PK_MonHoc] PRIMARY KEY CLUSTERED 
(
	[MaMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PhanHoiSinhVien]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PhanHoiSinhVien](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaSV] [char](10) NULL,
	[TinhTrang] [nchar](15) NULL,
	[YKienPhanHoi] [nchar](1000) NULL,
 CONSTRAINT [PK_PhanHoiSinhVien] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SinhVien]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SinhVien](
	[MaSV] [char](10) NOT NULL CONSTRAINT [DF_SinhVien_MaSv]  DEFAULT ((123456)),
	[HoTen] [nvarchar](25) NULL,
	[GioiTinh] [bit] NULL,
	[NgaySinh] [date] NULL,
	[QueQuan] [nvarchar](25) NULL,
	[DiaChi] [nvarchar](100) NULL,
	[EMail] [char](50) NULL,
	[SDT] [char](11) NULL,
	[MaLop] [char](10) NULL,
	[Pic] [image] NULL,
 CONSTRAINT [PK_SinhVien] PRIMARY KEY CLUSTERED 
(
	[MaSV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] NOT NULL,
	[Tai_Khoan] [char](25) NOT NULL,
	[Mat_Khau] [char](16) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[HanhKiem_View]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[HanhKiem_View]
AS
SELECT        dbo.SinhVien.MaSV, dbo.SinhVien.HoTen, dbo.HanhKiem.Diem, dbo.HanhKiem.KiHoc, dbo.SinhVien.MaLop
FROM            dbo.SinhVien INNER JOIN
                         dbo.HanhKiem ON dbo.SinhVien.MaSV = dbo.HanhKiem.MaSV

GO
/****** Object:  View [dbo].[KhoaHoc_View]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[KhoaHoc_View]
AS
SELECT        dbo.KhoaHoc.MaKH, dbo.KhoaHoc.MaMH, dbo.MonHoc.TenMH, dbo.KhoaHoc.MaGV, dbo.GiangVien.HoTen, dbo.KhoaHoc.KiHoc
FROM            dbo.KhoaHoc INNER JOIN
                         dbo.GiangVien ON dbo.KhoaHoc.MaGV = dbo.GiangVien.MaGV INNER JOIN
                         dbo.MonHoc ON dbo.KhoaHoc.MaMH = dbo.MonHoc.MaMH AND dbo.KhoaHoc.MaMH = dbo.MonHoc.MaMH

GO
/****** Object:  View [dbo].[Lop_View]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Lop_View]
AS
SELECT        dbo.Lop.MaLop, dbo.Lop.TenLop, dbo.Lop.MaGV, dbo.GiangVien.HoTen AS TenGV, dbo.Lop.MaCN, dbo.ChuyenNganh.TenCN, dbo.Lop.NienKhoa
FROM            dbo.Lop INNER JOIN
                         dbo.ChuyenNganh ON dbo.Lop.MaCN = dbo.ChuyenNganh.MaCN INNER JOIN
                         dbo.GiangVien ON dbo.Lop.MaGV = dbo.GiangVien.MaGV

GO
/****** Object:  View [dbo].[SinhVien_View]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SinhVien_View]
AS
SELECT        dbo.SinhVien.MaSV, dbo.SinhVien.HoTen, dbo.SinhVien.GioiTinh, dbo.SinhVien.NgaySinh, dbo.SinhVien.QueQuan, dbo.SinhVien.DiaChi, dbo.SinhVien.EMail, dbo.SinhVien.SDT, dbo.SinhVien.MaLop, dbo.SinhVien.Pic, 
                         dbo.Lop.TenLop, dbo.Lop.MaCN, dbo.ChuyenNganh.TenCN, dbo.ChuyenNganh.MaKhoa, dbo.Khoa.TenKhoa, dbo.Lop.NienKhoa
FROM            dbo.ChuyenNganh INNER JOIN
                         dbo.Khoa ON dbo.ChuyenNganh.MaKhoa = dbo.Khoa.MaKhoa INNER JOIN
                         dbo.Lop ON dbo.ChuyenNganh.MaCN = dbo.Lop.MaCN INNER JOIN
                         dbo.SinhVien ON dbo.Lop.MaLop = dbo.SinhVien.MaLop

GO
/****** Object:  View [dbo].[XemDiem_View]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[XemDiem_View]
AS
SELECT        dbo.SinhVien.MaSV, dbo.SinhVien.HoTen, dbo.MonHoc.MaMH, dbo.MonHoc.TenMH, dbo.Diem.C, dbo.Diem.B, dbo.Diem.A, dbo.Diem.KiHoc
FROM            dbo.Diem INNER JOIN
                         dbo.MonHoc ON dbo.Diem.MaMH = dbo.MonHoc.MaMH INNER JOIN
                         dbo.SinhVien ON dbo.Diem.MaSV = dbo.SinhVien.MaSV

GO
INSERT [dbo].[BoMon] ([MaBM], [TenBM], [MaKhoa]) VALUES (N'BMCNPM    ', N'Bộ môn Công nghệ Phần mềm', N'CNTT      ')
INSERT [dbo].[BoMon] ([MaBM], [TenBM], [MaKhoa]) VALUES (N'BMKHMT    ', N'Bộ môn Khoa học máy tính', N'CNTT      ')
INSERT [dbo].[BoMon] ([MaBM], [TenBM], [MaKhoa]) VALUES (N'BMMMT     ', N'Bộ môn Mạng máy tính', N'CNTT      ')
INSERT [dbo].[BoMon] ([MaBM], [TenBM], [MaKhoa]) VALUES (N'BMTHCB    ', N'Bộ môn Tin học Cơ bản', N'CNTT      ')
INSERT [dbo].[BoMon] ([MaBM], [TenBM], [MaKhoa]) VALUES (N'BMTHDC    ', N'Bộ môn Tin học Địa chất', N'CNTT      ')
INSERT [dbo].[BoMon] ([MaBM], [TenBM], [MaKhoa]) VALUES (N'BMTHKT    ', N'Bộ môn Tin học Kinh tế', N'CNTT      ')
INSERT [dbo].[BoMon] ([MaBM], [TenBM], [MaKhoa]) VALUES (N'BMTHTD    ', N'Bộ môn Tin học Trắc địa', N'CNTT      ')
INSERT [dbo].[ChuyenNganh] ([MaCN], [TenCN], [MaKhoa]) VALUES (N'CNPM      ', N'Công Nghệ phần mềm', N'CNTT      ')
INSERT [dbo].[ChuyenNganh] ([MaCN], [TenCN], [MaKhoa]) VALUES (N'KHMTUD    ', N'Khoa học máy tính ứng dụng', N'CNTT      ')
INSERT [dbo].[ChuyenNganh] ([MaCN], [TenCN], [MaKhoa]) VALUES (N'THCB      ', N'Tin học cơ bản', N'CNTT      ')
INSERT [dbo].[ChuyenNganh] ([MaCN], [TenCN], [MaKhoa]) VALUES (N'THDC      ', N'Tin học địa chất', N'CNTT      ')
INSERT [dbo].[ChuyenNganh] ([MaCN], [TenCN], [MaKhoa]) VALUES (N'THKT      ', N'Tin học kinh tế ', N'CNTT      ')
INSERT [dbo].[ChuyenNganh] ([MaCN], [TenCN], [MaKhoa]) VALUES (N'THM       ', N'Tin học mỏ', N'CNTT      ')
INSERT [dbo].[ChuyenNganh] ([MaCN], [TenCN], [MaKhoa]) VALUES (N'THTD      ', N'Tin học trắc địa', N'CNTT      ')
INSERT [dbo].[CTKhoaHoc] ([MaKH], [MaSV]) VALUES (15, N'1621050237')
INSERT [dbo].[CTKhoaHoc] ([MaKH], [MaSV]) VALUES (15, N'1621050245')
INSERT [dbo].[CTKhoaHoc] ([MaKH], [MaSV]) VALUES (16, N'1621050237')
INSERT [dbo].[CTKhoaHoc] ([MaKH], [MaSV]) VALUES (1018, N'1621050237')
INSERT [dbo].[CTKhoaHoc] ([MaKH], [MaSV]) VALUES (1020, N'1621050237')
INSERT [dbo].[Diem] ([MaSV], [MaMH], [C], [B], [A], [KiHoc]) VALUES (N'1621050237', N'01        ', 10, 10, 10, 20181)
INSERT [dbo].[Diem] ([MaSV], [MaMH], [C], [B], [A], [KiHoc]) VALUES (N'1621050237', N'02        ', 5.5, 9.5, 8, 20181)
INSERT [dbo].[Diem] ([MaSV], [MaMH], [C], [B], [A], [KiHoc]) VALUES (N'1621050237', N'12        ', 5, 5, 5, 20181)
INSERT [dbo].[Diem] ([MaSV], [MaMH], [C], [B], [A], [KiHoc]) VALUES (N'1621050237', N'14        ', 10, 4, 4, 20171)
INSERT [dbo].[Diem] ([MaSV], [MaMH], [C], [B], [A], [KiHoc]) VALUES (N'1621050237', N'14        ', 10, 10, 5, 20181)
INSERT [dbo].[Diem] ([MaSV], [MaMH], [C], [B], [A], [KiHoc]) VALUES (N'1621050245', N'01        ', 6, 8, 1, 20181)
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'01        ', N'Phạm Văn Đồng TEST', 0, CAST(N'1972-03-09' AS Date), N'Thanh Hóa', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'phamvandong@humg.edu.vn                           ', N'0904656357 ', N'BMCNPM    ', NULL)
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'05        ', N'Nguyễn Thế Lộc', 1, CAST(N'1976-09-03' AS Date), N'Quảng Ninh', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'nguyentheloc@humg.edu.vn                          ', N'0983330682 ', N'BMCNPM    ', N'               ')
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'07        ', N'Nguyễn Thị Hữu Phương', 0, CAST(N'1980-04-23' AS Date), N'Hà Nội', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'nguyenthihuuphuong@humg.e                         ', N'0982189348 ', N'BMCNPM    ', N'07.jpg         ')
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'08        ', N'Hồ Thị Thảo Trang', 0, CAST(N'1982-12-04' AS Date), N'Hưng Yên', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'hothithaotrang@humg.edu.v                         ', N'           ', N'BMCNPM    ', N'08.png         ')
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'09        ', N'Đỗ Anh Tuấn', 1, CAST(N'1975-03-05' AS Date), N'Hà Nội', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'doanhtuan@humg.edu.vn                             ', N'0989640069 ', N'BMCNPM    ', N'09.png         ')
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'10        ', N'Nguyễn Thị Thanh', 0, CAST(N'1972-08-12' AS Date), N'Hà Nam', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'nguyenthithanh@humg.edu.v                         ', N'0982148611 ', N'BMCNPM    ', N'10.png         ')
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'11        ', N'Phạm Thị Hải Vân', 0, CAST(N'1978-12-12' AS Date), N'Tây Ninh', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'phamthihaivan@humg.edu.vn                         ', N'0969591368 ', N'BMCNPM    ', N'11.jpg         ')
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'12        ', N'Tạ Quang Chiểu', 1, CAST(N'1989-12-22' AS Date), N'Hà Nội', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'taquangchieu@humg.edu.vn                          ', N'0913522275 ', N'BMCNPM    ', N'12.jpg         ')
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'13        ', N'Đào Thị Thu Vân', 0, CAST(N'1982-10-10' AS Date), N'Nam Định', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'daothithuvan@humg.edu.vn                          ', N'0987833395 ', N'BMCNPM    ', N'13.jpg         ')
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'14        ', N'Đặng Hữu Nghị', 1, CAST(N'1984-07-19' AS Date), N'Hà Nội', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'nghidanghuu@gmail.com                             ', N'0989640319 ', N'BMCNPM    ', N'14.jpg         ')
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'15        ', N'Vũ Lan Phương', 0, CAST(N'1982-04-08' AS Date), N'Bắc Ninh', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'phuongvl79@gmail.com                              ', N'0984223379 ', N'BMTHDC    ', N'15.jpg         ')
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'16        ', N'Bùi Thị Vân Anh', 0, CAST(N'1985-11-24' AS Date), N'Hà Nội', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'buithivananh@humg.edu.vn                          ', N'0974948508 ', N'BMCNPM    ', N'16.jpg         ')
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'19        ', N'Dương Chí Thiện', 1, CAST(N'1985-09-28' AS Date), N'Hà Nội', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'duongchithien@humg.edu.vn                         ', N'0986986743 ', N'BMCNPM    ', N'19.jpg         ')
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'20        ', N'Đặng Quốc Trung', 1, CAST(N'1988-09-21' AS Date), N'Hà Nội', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'dangquoctrung@humg.edu.vn                         ', N'0986488842 ', N'BMCNPM    ', N'20.jpg         ')
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'21312312  ', N'DANG DUY KHANH', 0, CAST(N'2021-06-05' AS Date), N'', N'', N'                                                  ', N'           ', N'BMCNPM    ', NULL)
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'2131233   ', N'Dang Duy Khanh', 0, CAST(N'2021-06-05' AS Date), N'', N'', N'                                                  ', N'           ', N'BMCNPM    ', NULL)
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'2313231   ', N'Hoang Duy Hong', 1, CAST(N'2021-06-08' AS Date), N'', N'', N'                                                  ', N'           ', N'BMCNPM    ', NULL)
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'28        ', N'Vương Thị Như Quỳnh', 0, CAST(N'1977-07-07' AS Date), N'Hà Nam', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'vuongnhuquynh@humg.edu.vn                         ', N'0915357151 ', N'BMCNPM    ', N'28.jpg         ')
INSERT [dbo].[GiangVien] ([MaGV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaBM], [Pic]) VALUES (N'30        ', N'Phạm Đức Hậu', 1, CAST(N'1984-04-06' AS Date), N'Hà Nội', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'ádasd         ggg                                 ', N'0913511609 ', N'BMCNPM    ', N'30.jpg         ')
INSERT [dbo].[HanhKiem] ([MaSV], [Diem], [KiHoc]) VALUES (N'1621050237', 80, 20171)
INSERT [dbo].[HanhKiem] ([MaSV], [Diem], [KiHoc]) VALUES (N'1621050237', 80, 20172)
INSERT [dbo].[HanhKiem] ([MaSV], [Diem], [KiHoc]) VALUES (N'1621050237', 80, 20181)
INSERT [dbo].[HanhKiem] ([MaSV], [Diem], [KiHoc]) VALUES (N'1621050245', 80, 20171)
INSERT [dbo].[HocKi] ([KiHoc], [BatDau], [KetThuc]) VALUES (20161, CAST(N'2016-09-01' AS Date), CAST(N'2016-12-30' AS Date))
INSERT [dbo].[HocKi] ([KiHoc], [BatDau], [KetThuc]) VALUES (20162, CAST(N'2017-01-10' AS Date), CAST(N'2017-05-30' AS Date))
INSERT [dbo].[HocKi] ([KiHoc], [BatDau], [KetThuc]) VALUES (20163, CAST(N'2017-07-01' AS Date), CAST(N'2017-08-15' AS Date))
INSERT [dbo].[HocKi] ([KiHoc], [BatDau], [KetThuc]) VALUES (20171, CAST(N'2017-09-01' AS Date), CAST(N'2017-12-30' AS Date))
INSERT [dbo].[HocKi] ([KiHoc], [BatDau], [KetThuc]) VALUES (20172, CAST(N'2018-01-10' AS Date), CAST(N'2018-05-30' AS Date))
INSERT [dbo].[HocKi] ([KiHoc], [BatDau], [KetThuc]) VALUES (20173, CAST(N'2018-07-01' AS Date), CAST(N'2018-07-01' AS Date))
INSERT [dbo].[HocKi] ([KiHoc], [BatDau], [KetThuc]) VALUES (20181, CAST(N'2018-09-01' AS Date), CAST(N'2018-12-30' AS Date))
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [SoDienThoai]) VALUES (N'CD        ', N'Khoa Cơ - Điện
', N'P.604, 605 - Nhà C12 tầng, Trường Đại học Mỏ-Địa chất', N'(8424) 37523432')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [SoDienThoai]) VALUES (N'CNTT      ', N'Khoa Công nghệ Thông tin
', N'Tầng 5 nhà C đại học Mỏ địa chất', N'(84-24) 3838-7570')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [SoDienThoai]) VALUES (N'DK        ', N'Khoa Dầu khí
', N'Tầng 8, Nhà C12 tầng, Trường Đại học Mỏ - Địa chất', N'(+84 024)38387569')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [SoDienThoai]) VALUES (N'GDQP      ', N'Khoa Giáo dục Quốc phòng
', N'Tầng 7, phòng 710, Nhà C12, Trường Đại học Mỏ - Địa chất', N'+84-24.38387615')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [SoDienThoai]) VALUES (N'KHCB      ', N'Khoa Khoa học cơ bản', N'Phòng 11.03, Tầng 11 nhà C12 khu A Trường ĐH Mỏ - Địa chất', N'024.38387564')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [SoDienThoai]) VALUES (N'KHKTDC    ', N'Khoa Khoa học và Kỹ thuật địa chất
', N'Tầng 4, Nhà C 12 tầng, Khu A - Trường Đại học Mỏ - Địa chất', N'04. 38387567')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [SoDienThoai]) VALUES (N'KTQTKD    ', N'Khoa Kinh tế và Quản trị kinh doanh
', N'Phòng C12.08 nhà C12 tầng khu A Trường ĐH Mỏ - Địa chất', N'0243.8387566')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [SoDienThoai]) VALUES (N'LLCT      ', N'Khoa Lý luận Chính trị
', N'Phòng 12 - 01, Nhà C - 12 tầng, Trường Đại học Mỏ - Địa chất', N'02438383315')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [SoDienThoai]) VALUES (N'M         ', N'Khoa Mỏ
', N'Số 18, phố Viên,·phường Đức Thắng, quận Bắc Từ Liêm, Hà Nội', N'(84-4) 3838-7565')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [SoDienThoai]) VALUES (N'MT        ', N'Khoa Môi trường
', N'Phòng 607 - Nhà C12 tầng, Trường Đại học Mỏ-Địa chất', N'(84-24) 37525052')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [SoDienThoai]) VALUES (N'TD        ', N'Khoa Trắc địa - Bản đồ và Quản lý đất đai', N'Tầng 10, nhà C12 tầng khu A Trường ĐH Mỏ - Địa chất', N'+84-24.38387568')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa], [DiaChi], [SoDienThoai]) VALUES (N'XD        ', N'Khoa Xây dựng', N'Tầng 6, Nhà C12 tầng Trường Đại học Mỏ - Địa chất', N'(84-4) 37522472')
SET IDENTITY_INSERT [dbo].[KhoaHoc] ON 

INSERT [dbo].[KhoaHoc] ([MaKH], [MaMH], [MaGV], [KiHoc]) VALUES (15, N'01        ', N'09        ', 20181)
INSERT [dbo].[KhoaHoc] ([MaKH], [MaMH], [MaGV], [KiHoc]) VALUES (16, N'02        ', N'09        ', 20181)
INSERT [dbo].[KhoaHoc] ([MaKH], [MaMH], [MaGV], [KiHoc]) VALUES (17, N'01        ', N'01        ', 20181)
INSERT [dbo].[KhoaHoc] ([MaKH], [MaMH], [MaGV], [KiHoc]) VALUES (1018, N'14        ', N'07        ', 20181)
INSERT [dbo].[KhoaHoc] ([MaKH], [MaMH], [MaGV], [KiHoc]) VALUES (1019, N'14        ', N'08        ', 20181)
INSERT [dbo].[KhoaHoc] ([MaKH], [MaMH], [MaGV], [KiHoc]) VALUES (1020, N'12        ', N'07        ', 20181)
SET IDENTITY_INSERT [dbo].[KhoaHoc] OFF
INSERT [dbo].[LichSu] ([ID], [ThaoTac], [ThoiGian]) VALUES (N'1421050395', N'update', N'09:16:29 SA')
INSERT [dbo].[LichSu] ([ID], [ThaoTac], [ThoiGian]) VALUES (N'acascc11  ', N'Add Student', N'09:26:40 SA')
INSERT [dbo].[Lop] ([MaLop], [TenLop], [MaGV], [MaCN], [NienKhoa]) VALUES (N'asdasdasd ', NULL, NULL, NULL, NULL)
INSERT [dbo].[Lop] ([MaLop], [TenLop], [MaGV], [MaCN], [NienKhoa]) VALUES (N'asdk      ', NULL, NULL, NULL, NULL)
INSERT [dbo].[Lop] ([MaLop], [TenLop], [MaGV], [MaCN], [NienKhoa]) VALUES (N'CNPMAK61  ', N'Công Nghệ phần mềm A Khóa 61', NULL, N'CNPM      ', 61)
INSERT [dbo].[Lop] ([MaLop], [TenLop], [MaGV], [MaCN], [NienKhoa]) VALUES (N'CNPMBK61  ', N'Công nghệ phần mềm B Khóa 61', NULL, N'CNPM      ', 61)
INSERT [dbo].[Lop] ([MaLop], [TenLop], [MaGV], [MaCN], [NienKhoa]) VALUES (N'CNPMCK61  ', N'Công Nghệ phần mềm C Khóa 61', N'09        ', N'CNPM      ', 61)
INSERT [dbo].[Lop] ([MaLop], [TenLop], [MaGV], [MaCN], [NienKhoa]) VALUES (N'CNPMDK61  ', N'Công nghệ phần mềm D Khóa 61', N'01        ', N'CNPM      ', 61)
INSERT [dbo].[Lop] ([MaLop], [TenLop], [MaGV], [MaCN], [NienKhoa]) VALUES (N'KHMTUDAK61', N'Khoa học máy tính ứng dụng A khóa 61', NULL, N'CNPM      ', 61)
INSERT [dbo].[Lop] ([MaLop], [TenLop], [MaGV], [MaCN], [NienKhoa]) VALUES (N'KHMTUDBK61', N'Khoa học máy tính ứng dụng B khóa 61', NULL, N'CNPM      ', 61)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'01        ', N'Tin học đại cương                                                                                   ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'02        ', N'Cơ sở lập trình                                                                                     ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'03        ', N'Kiến trúc máy tính                                                                                  ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'04        ', N'Cơ sở dữ liệu                                                                                       ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'05        ', N'Lập trình hướng đối tượng C++                                                                       ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'06        ', N'Cấu trúc và dữ liệu giải thuật                                                                      ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'07        ', N'Kiến trúc máy tính                                                                                  ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'08        ', N'Mạng máy tính                                                                                       ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'09        ', N'Lập trình .NET 1                                                                                    ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'10        ', N'Hệ quảng trị cơ sở dữ liệu SQL                                                                      ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'11        ', N'Tin ứng dụng                                                                                        ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'12        ', N'Nguyên lý hệ điều hành + BTL                                                                        ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'13        ', N'Đạo đức máy tính                                                                                    ', 2)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'14        ', N'Tiếng Anh chuyên ngành công nghệ thông tin                                                          ', 2)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'15        ', N'Lập trình mạng                                                                                      ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'16        ', N'Lập trình JAVA                                                                                      ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'17        ', N'Lập trình Web                                                                                       ', 2)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'18        ', N'Lập trình .NET 2                                                                                    ', 3)
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [SoTinChi]) VALUES (N'19        ', N'Thực tập tin học cơ sở                                                                              ', 3)
SET IDENTITY_INSERT [dbo].[PhanHoiSinhVien] ON 

INSERT [dbo].[PhanHoiSinhVien] ([ID], [MaSV], [TinhTrang], [YKienPhanHoi]) VALUES (1, N'1621050237', N'Đang học       ', N'Môi trường học tố                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ')
INSERT [dbo].[PhanHoiSinhVien] ([ID], [MaSV], [TinhTrang], [YKienPhanHoi]) VALUES (2, N'1421050395', N'Đi làm         ', N'Đã ổn định công việc                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ')
INSERT [dbo].[PhanHoiSinhVien] ([ID], [MaSV], [TinhTrang], [YKienPhanHoi]) VALUES (3, N'1521020202', N'Đang học       ', N'Yêu trường                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              ')
INSERT [dbo].[PhanHoiSinhVien] ([ID], [MaSV], [TinhTrang], [YKienPhanHoi]) VALUES (4, N'1521050154', N'Thực tập       ', N'Thực tập khá hiệu quả                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ')
SET IDENTITY_INSERT [dbo].[PhanHoiSinhVien] OFF
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1421050395', N'Phan Thế Hiển', 0, CAST(N'2020-09-02' AS Date), N'Kiên Giang', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1421050395@student.humg.edu.vn                    ', NULL, N'CNPMDK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1521020202', N'Trần Minh
 Hiếu', 1, CAST(N'2018-09-30' AS Date), N'Bình Phước', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1521020202@student.humg.edu.vn                    ', N'09731953138', N'CNPMAK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1521050154', N'Đỗ Tất
 Cường', 1, CAST(N'2018-09-30' AS Date), N'Bình Thuận', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1521050154@student.humg.edu.vn                    ', N'09731953138', N'CNPMAK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1521050296', N'Vũ Trọng Đức', 1, CAST(N'2018-09-30' AS Date), N'Cà Mau', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1521050296@student.humg.edu.vn                    ', N'09731953138', N'CNPMBK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1521050340', N'Trần Đăng
 Cường
', 1, CAST(N'1998-09-20' AS Date), N'Hà Nội
', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1521050340@student.humg.edu.vn                    ', N'09731953138', N'CNPMAK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1611050020', N'Lê Thành Đạt', 1, CAST(N'2018-09-30' AS Date), N'Hà Nội', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1611050020@student.humg.edu.vn                    ', N'09731953138', N'CNPMCK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050041', N'Đào Tuấn
 Anh', 1, CAST(N'1998-10-22' AS Date), N'Hà Nội
', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050041@student.humg.edu.vn                    ', N'09731953138', N'CNPMBK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050059', N'Ngô Xuân
 Đạt
', 1, CAST(N'1998-03-28' AS Date), N'Hà Nội
', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050059@student.humg.edu.vn                    ', N'09731953138', N'CNPMDK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050083', N'Trịnh Như
 Bình
', 1, CAST(N'1998-04-06' AS Date), N'Hà Nội
', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050083@student.humg.edu.vn                    ', N'09731953138', N'CNPMAK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050152', N'Đặng Thị
 Biên', 0, CAST(N'2018-09-30' AS Date), N'Hà Nội', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050152@student.humg.edu.vn                    ', N'09731953138', N'CNPMBK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050192', N'Phạm Minh Hải', 1, CAST(N'2018-09-30' AS Date), N'Hà Nội', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050192@student.humg.edu.vn                    ', N'09731953138', N'CNPMCK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050237', N'Ngô Công Minh', 1, CAST(N'2018-09-30' AS Date), N'Hà Nội', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050245@student.humg.e                         ', N'09731953138', N'KHMTUDBK61', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050245', N'Lưu Thị Hạnh', 0, CAST(N'2018-09-30' AS Date), N'Hà Nội', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050245@student.humg.edu.vn                    ', N'09731953138', N'CNPMBK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050283', N'Tạ Xuân
 Công', 0, CAST(N'2018-09-30' AS Date), N'Thái Nguyên
1', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050283@student.humg.edu.vn                    ', N'09731953138', N'KHMTUDAK61', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050291', N'Dương Hữu
 Đức
', 1, CAST(N'1998-06-16' AS Date), N'Thái Nguyên
', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050291@student.humg.edu.vn                    ', N'09731953138', N'CNPMCK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050368', N'Trần Anh
 Đức
', 1, CAST(N'1998-09-12' AS Date), N'Thái Nguyên
', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050368@student.humg.edu.vn                    ', N'09731953138', N'CNPMBK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050525', N'Thiều Văn
 Bình
', 1, CAST(N'1998-01-18' AS Date), N'Thái Nguyên
', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050525@student.humg.edu.vn                    ', N'09731953138', N'CNPMBK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050635', N'Trần Xuân
 Đức
', 1, CAST(N'1998-01-07' AS Date), N'Thái Nguyên
', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050635@student.humg.edu.vn                    ', N'09731953138', N'CNPMAK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050715', N'Trần Mạnh
 Đạt
', 1, CAST(N'1998-03-26' AS Date), N'Bình Thuận
', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050715@student.humg.edu.vn                    ', N'09731953138', N'CNPMDK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050888', N'Dương Hữu
 Đức
', 1, CAST(N'2018-09-30' AS Date), N'Bình Thuận
', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050888@student.humg.edu.vn                    ', N'09731953138', N'CNPMCK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'1621050890', N'Ngô Đức Mạnh', 1, CAST(N'2018-09-30' AS Date), N'Hà Nội', N'Số 18​ Phố Viên - Phường Đức Thắng - Q. Bắ​c Từ Liêm - Hà Nội​', N'1621050890@student.humg.edu.vn                    ', N'09731953138', N'KHMTUDBK61', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'21321312  ', N'ascasc', 0, CAST(N'2020-09-02' AS Date), N'', N'', N'                                                  ', N'           ', N'CNPMBK61  ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'21443242  ', N'KHANHDAICA', 0, CAST(N'2020-09-02' AS Date), NULL, N'hai phong', NULL, NULL, N'CNPMBK61  ', 0xFFD8FFE000104A46494600010101006000600000FFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC0001108001E001E03012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F1CD1B469754B9C64244837B17E0103A806BA59B57D0B4F4DDA1D9CB1EA518DAB2019E475E83D6A0D4A58ECBC396DA467CBD495F0EABC1E703AD6DF823C3F6367AAC075662B7CFF34711190C0F7FE55949A477461728BDF785756B7581EC655D5A618795B81BFD7A5727A968177A6DEBDB18A49B6FF1C48594FE22A6D7FF0073E24BDF28600978C718AF50F0778C7C3563E1BB78353963FB5AFDFDF1863D077352E4D6C4B81E6536BF1DC585BC725B06B98E40ED39EAD8C575307886DA6787C46CEAB35A288C5AE797F7FD2B81B78918DBE47DE9029FA6457A77883C25A4597845AF60B7DB38453BBF0A7392EA3A726CC8BE9F4FF194335C4691D85C4232107594FEBEB5D97832C3C371F86EDD357FB2C77A3EFACD9DDD0556B3F0968F078506AB1DBE2ED21F315FD0E6BC9751D46E6F6F5E79DF748DD4D45B9B445C9DB567FFD9)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'acascc11  ', N'TestThu', 0, CAST(N'2021-06-03' AS Date), NULL, NULL, NULL, NULL, N'KHMTUDAK61', 0xFFD8FFE000104A46494600010101006000600000FFDB004300080606070605080707070909080A0C140D0C0B0B0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232FFC0001108001E001E03012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F9FEBAD363A0E85A2594FA9DA497F7F7B08996159CA2A293C67182320FA1E54E2B92AEF6D20D23C6DA7699602EFEC1AA59C3E4ED68C3F9A8AA3A1E33D3206723E6E0F5A395C9D91D98449F359272B697F5F3D2E66EBBA5E8F73E1F8B5CD0619E28526FB3DC42E0B6C3D431249C7551D48F987439CF295DC78A9EDFC35A227856C84ACF2959EEE7917024E98DB9F751F77A6DC649DD5C3D54E3CAEC462ADED34493B6B6DAE751A2F862D25D246B5AE5FF00D8B4E67D91841B9E53C8E3AE391E84E01E839AA5E23D534DD467823D274D8ECED2DD36A9D8049212064B919CE31C6493D4E79E2F43AA7876EBC3DA669FAAA6A826B2F3706D447B4EF7CFF11F4C7A77A8FF00E287FF00A987FF0020D6DECDB8FBA3AAD469A8C568D2BF765EB0F16D9EA964BA5F8AADFED1084F2E1BE45CCD11247CC4FD31C8E4EDE4366B2FC4BE1B3A2CA973693ADE69570C7ECF751B06071D5588E370C1FAE3EA04FF00F1437FD4C5FF00902A5D7BC43A4DC785AC741D261BDF26DA632996EF686FE2E3E5EBCB9F4C6075CD5CA2DC1FB4E9B33CDA98994AA462B5FF0023FFD9)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'ascasasc  ', N'kanhac', 0, CAST(N'2020-09-02' AS Date), NULL, NULL, NULL, NULL, N'asdasdasd ', NULL)
INSERT [dbo].[SinhVien] ([MaSV], [HoTen], [GioiTinh], [NgaySinh], [QueQuan], [DiaChi], [EMail], [SDT], [MaLop], [Pic]) VALUES (N'saccsas   ', N'ascaca', 0, CAST(N'2020-09-02' AS Date), NULL, NULL, NULL, NULL, N'asdasdasd ', NULL)
INSERT [dbo].[User] ([ID], [Tai_Khoan], [Mat_Khau]) VALUES (0, N'khanh13122002            ', N'admin           ')
INSERT [dbo].[User] ([ID], [Tai_Khoan], [Mat_Khau]) VALUES (1, N'khanh                    ', N'admin           ')
INSERT [dbo].[User] ([ID], [Tai_Khoan], [Mat_Khau]) VALUES (2, N'khanh1312                ', N'admin           ')
INSERT [dbo].[User] ([ID], [Tai_Khoan], [Mat_Khau]) VALUES (3, N'john                     ', N'12345678        ')
INSERT [dbo].[User] ([ID], [Tai_Khoan], [Mat_Khau]) VALUES (4, N'khanh1331                ', N'admin1312       ')
INSERT [dbo].[User] ([ID], [Tai_Khoan], [Mat_Khau]) VALUES (5, N'khanh9999                ', N'13122002        ')
INSERT [dbo].[User] ([ID], [Tai_Khoan], [Mat_Khau]) VALUES (6, N'khanh121221u213          ', N'admin           ')
INSERT [dbo].[User] ([ID], [Tai_Khoan], [Mat_Khau]) VALUES (7, N'khanh13122002aa          ', N'13122002        ')
ALTER TABLE [dbo].[BoMon]  WITH CHECK ADD  CONSTRAINT [FK_BoMon_Khoa] FOREIGN KEY([MaKhoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[BoMon] CHECK CONSTRAINT [FK_BoMon_Khoa]
GO
ALTER TABLE [dbo].[ChuyenNganh]  WITH CHECK ADD  CONSTRAINT [FK_ChuyenNganh_Khoa] FOREIGN KEY([MaKhoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[ChuyenNganh] CHECK CONSTRAINT [FK_ChuyenNganh_Khoa]
GO
ALTER TABLE [dbo].[CTKhoaHoc]  WITH CHECK ADD  CONSTRAINT [FK_CTKhoaHoc_KhoaHoc] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhoaHoc] ([MaKH])
GO
ALTER TABLE [dbo].[CTKhoaHoc] CHECK CONSTRAINT [FK_CTKhoaHoc_KhoaHoc]
GO
ALTER TABLE [dbo].[CTKhoaHoc]  WITH CHECK ADD  CONSTRAINT [FK_CTKhoaHoc_SinhVien] FOREIGN KEY([MaSV])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO
ALTER TABLE [dbo].[CTKhoaHoc] CHECK CONSTRAINT [FK_CTKhoaHoc_SinhVien]
GO
ALTER TABLE [dbo].[Diem]  WITH CHECK ADD  CONSTRAINT [FK_Diem_HocKi] FOREIGN KEY([KiHoc])
REFERENCES [dbo].[HocKi] ([KiHoc])
GO
ALTER TABLE [dbo].[Diem] CHECK CONSTRAINT [FK_Diem_HocKi]
GO
ALTER TABLE [dbo].[Diem]  WITH CHECK ADD  CONSTRAINT [FK_Diem_MonHoc] FOREIGN KEY([MaMH])
REFERENCES [dbo].[MonHoc] ([MaMH])
GO
ALTER TABLE [dbo].[Diem] CHECK CONSTRAINT [FK_Diem_MonHoc]
GO
ALTER TABLE [dbo].[Diem]  WITH CHECK ADD  CONSTRAINT [FK_Diem_SinhVien] FOREIGN KEY([MaSV])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO
ALTER TABLE [dbo].[Diem] CHECK CONSTRAINT [FK_Diem_SinhVien]
GO
ALTER TABLE [dbo].[GiangVien]  WITH CHECK ADD  CONSTRAINT [FK_GiangVien_BoMon] FOREIGN KEY([MaBM])
REFERENCES [dbo].[BoMon] ([MaBM])
GO
ALTER TABLE [dbo].[GiangVien] CHECK CONSTRAINT [FK_GiangVien_BoMon]
GO
ALTER TABLE [dbo].[HanhKiem]  WITH CHECK ADD  CONSTRAINT [FK_HanhKiem_HocKi] FOREIGN KEY([KiHoc])
REFERENCES [dbo].[HocKi] ([KiHoc])
GO
ALTER TABLE [dbo].[HanhKiem] CHECK CONSTRAINT [FK_HanhKiem_HocKi]
GO
ALTER TABLE [dbo].[HanhKiem]  WITH CHECK ADD  CONSTRAINT [FK_HanhKiem_SinhVien] FOREIGN KEY([MaSV])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO
ALTER TABLE [dbo].[HanhKiem] CHECK CONSTRAINT [FK_HanhKiem_SinhVien]
GO
ALTER TABLE [dbo].[KhoaHoc]  WITH CHECK ADD  CONSTRAINT [FK_KhoaHoc_GiangVien] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiangVien] ([MaGV])
GO
ALTER TABLE [dbo].[KhoaHoc] CHECK CONSTRAINT [FK_KhoaHoc_GiangVien]
GO
ALTER TABLE [dbo].[KhoaHoc]  WITH CHECK ADD  CONSTRAINT [FK_KhoaHoc_HocKi] FOREIGN KEY([KiHoc])
REFERENCES [dbo].[HocKi] ([KiHoc])
GO
ALTER TABLE [dbo].[KhoaHoc] CHECK CONSTRAINT [FK_KhoaHoc_HocKi]
GO
ALTER TABLE [dbo].[KhoaHoc]  WITH CHECK ADD  CONSTRAINT [FK_KhoaHoc_MonHoc] FOREIGN KEY([MaMH])
REFERENCES [dbo].[MonHoc] ([MaMH])
GO
ALTER TABLE [dbo].[KhoaHoc] CHECK CONSTRAINT [FK_KhoaHoc_MonHoc]
GO
ALTER TABLE [dbo].[KhoaHoc]  WITH CHECK ADD  CONSTRAINT [FK_KhoaHoc_MonHoc1] FOREIGN KEY([MaMH])
REFERENCES [dbo].[MonHoc] ([MaMH])
GO
ALTER TABLE [dbo].[KhoaHoc] CHECK CONSTRAINT [FK_KhoaHoc_MonHoc1]
GO
ALTER TABLE [dbo].[LichSu]  WITH CHECK ADD  CONSTRAINT [FK_LichSu_SinhVien] FOREIGN KEY([ID])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO
ALTER TABLE [dbo].[LichSu] CHECK CONSTRAINT [FK_LichSu_SinhVien]
GO
ALTER TABLE [dbo].[Lop]  WITH CHECK ADD  CONSTRAINT [FK_Lop_ChuyenNganh] FOREIGN KEY([MaCN])
REFERENCES [dbo].[ChuyenNganh] ([MaCN])
GO
ALTER TABLE [dbo].[Lop] CHECK CONSTRAINT [FK_Lop_ChuyenNganh]
GO
ALTER TABLE [dbo].[Lop]  WITH CHECK ADD  CONSTRAINT [FK_Lop_GiangVien] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GiangVien] ([MaGV])
GO
ALTER TABLE [dbo].[Lop] CHECK CONSTRAINT [FK_Lop_GiangVien]
GO
ALTER TABLE [dbo].[PhanHoiSinhVien]  WITH CHECK ADD  CONSTRAINT [FK_PhanHoiSinhVien_SinhVien] FOREIGN KEY([MaSV])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO
ALTER TABLE [dbo].[PhanHoiSinhVien] CHECK CONSTRAINT [FK_PhanHoiSinhVien_SinhVien]
GO
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD  CONSTRAINT [FK_SinhVien_Lop] FOREIGN KEY([MaLop])
REFERENCES [dbo].[Lop] ([MaLop])
GO
ALTER TABLE [dbo].[SinhVien] CHECK CONSTRAINT [FK_SinhVien_Lop]
GO
/****** Object:  StoredProcedure [dbo].[Diem_GetDiemTbKi]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Diem_GetDiemTbKi](
	@MaSV char(10),
	@KiHoc int)
AS
BEGIN
	SELECT dbo.FUNC_DiemTBKiHoc(@MaSV,@KiHoc)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_BoMon_Select_All]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_BoMon_Select_All]
AS
BEGIN
	SELECT *FROM BoMon
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ChuyenNganh_Select_All]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ChuyenNganh_Select_All]
AS
BEGIN
	SELECT *FROM ChuyenNganh
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Diem_CheckNull]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Diem_CheckNull](
	@MaSV char(10),
	@MaMH char(10),
	@KiHoc int)
AS
BEGIN
	SELECT *FROM Diem WHERE MaSV = @MaSV and MaMH = @MaMH and KiHoc = @KiHoc
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Diem_Delete]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Diem_Delete](
	@MaSV char(10),
	@MaMH char(10),
	@KiHoc int)
AS
BEGIN
	Delete Diem WHERE MaSV = @MaSV and MaMH = @MaMH and KiHoc = @KiHoc
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Diem_Delete_ByKhoaHoc]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Diem_Delete_ByKhoaHoc](
@MaMH char(10),
@KiHoc int)
AS
BEGIN
	Delete Diem WHERE MaMH = @MaMH and KiHoc = @KiHoc
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Diem_GetDiem4TbKi]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Diem_GetDiem4TbKi](
	@MaSV char(10),
	@KiHoc int)
AS
BEGIN
	SELECT dbo.FUNC_DiemTB4KiHoc(@MaSV,@KiHoc)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Diem_GetDiemTbKi]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Diem_GetDiemTbKi](
	@MaSV char(10),
	@KiHoc int)
AS
BEGIN
	SELECT dbo.FUNC_DiemTBKiHoc(@MaSV,@KiHoc)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Diem_GetSoTinChi]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_Diem_GetSoTinChi](
	@MaSV char(10),
	@KiHoc int)
AS
BEGIN
	SELECT dbo.FUNC_TongTinChiDaHoc(@MaSV,@KiHoc)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Diem_Insert]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Diem_Insert](
	@MaSV char(10),
	@MaMH char(10),
	@C float,
	@B float,
	@A float,
	@KiHoc int)
AS
BEGIN
	INSERT INTO Diem VALUES(@MaSV,@MaMH,@C,@B,@A,@KiHoc)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Diem_Select_ByMaSV]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Diem_Select_ByMaSV](@MaSV char(10))
AS
BEGIN
	Select Diem.MaMH,MonHoc.TenMH,MonHoc.SoTinChi,Diem.C,Diem.B,Diem.A, dbo.FUNC_DiemTB(Diem.C,Diem.B,Diem.A) as 'TongDiem' , dbo.FUNC_XepLoai( dbo.FUNC_DiemTB(Diem.C,Diem.B,Diem.A)) as 'DiemChu' FROM Diem,MonHoc Where Diem.MaSV = @MaSV and MonHoc.MaMH = Diem.MaMH
	END
GO
/****** Object:  StoredProcedure [dbo].[SP_Diem_Select_ByMaSVKiHoc]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Diem_Select_ByMaSVKiHoc](
	@MaSV char(10),
	@KiHoc int)
AS
BEGIN
	SELECT  Diem.MaMH,MonHoc.TenMH,MonHoc.SoTinChi,Diem.C,Diem.B,Diem.A,dbo.FUNC_DiemTB(Diem.C,Diem.B,Diem.A) as 'TongDiem',dbo.FUNC_XepLoai(dbo.FUNC_DiemTB(Diem.C,Diem.B,Diem.A)) as 'DiemChu' FROM Diem,MonHoc WHERE Diem.MaMH = MonHoc.MaMH and  MaSV = @MaSV and KiHoc = @KiHoc
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Diem_SelectKiHoc_ByMaSV]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Diem_SelectKiHoc_ByMaSV](
	@MaSV char(10))
AS
BEGIN
	SELECT KiHoc FROM Diem WHERE MaSV = @MaSV GROUP BY KiHoc
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Diem_Update]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Diem_Update](
	@MaSV char(10),
	@MaMH char(10),
	@C float,
	@B float,
	@A float,
	@KiHoc int)
AS
BEGIN
	UPDATE Diem SET C = ROUND(@C,1), B = ROUND(@B,1), A = ROUND(@A,1) WHERE MaSV = @MaSV and MaMH = @MaMH and KiHoc = @KiHoc
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DoiMatKhau]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DoiMatKhau]
(@MaSV char(10),
 @MatKhau char(10))
AS
BEGIN
	UPDATE SinhVien Set MatKhau = @MatKhau WHERE MaSV = @MaSV
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GiangVien_Delete]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GiangVien_Delete](
@MaGV char(10))
AS
BEGIN
	Delete GiangVien Where MaGV = @MaGV
	Delete PhanQuyen WHERE ID = @MaGV
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GiangVien_GetMaxMaGV]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GiangVien_GetMaxMaGV]
AS
BEGIN
	SELECT MAX(MaGV) FROM GiangVien
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GiangVien_Insert]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GiangVien_Insert](
	@MaGV nchar(10),
	@MatKhau nchar(32),
	@HoTen nvarchar(25),
	@GioiTinh bit,
	@NgaySinh Date,
	@QueQuan nvarchar(25),
	@DiaChi nvarchar(100),
	@EMail char(25),
	@SDT char(11),
	@MaBM char(10),
	@Pic char(15))
AS

BEGIN
	INSERT INTO GiangVien VALUES(@MaGV,@HoTen,@GioiTinh,@NgaySinh,@QueQuan,@DiaChi,@EMail,@SDT,@MaBM,@Pic)  	
END

BEGIN
	INSERT INTO PhanQuyen VALUES(@MaGV,@MatKhau,0,0,0,1,0,0)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GiangVien_NhapDiem]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GiangVien_NhapDiem](
@MaKH int )
AS
BEGIN
	SELECT SinhVien.MaSV,SinhVien.HoTen,C,B,A FROM KhoaHoc,Diem,MonHoc,SinhVien,CTKhoaHoc WHERE SinhVien.MaSV = CTKhoaHoc.MaSV and CTKhoaHoc.MaKH = KhoaHoc.MaKH and KhoaHoc.MaMH = MonHoc.MaMH and Diem.MaMH = KhoaHoc.MaMH and Diem.MaSV = CTKhoaHoc.MaSV and KhoaHoc.MaKH = @MaKH
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GiangVien_Select_All]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GiangVien_Select_All]
AS
BEGIN
	SELECT *FROM GiangVien
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GiangVien_SelectLop]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GiangVien_SelectLop](
	@MaGV int)
AS
BEGIN
	SELECT *FROM LOP WHERE MaGV = @MaGV
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GiangVien_Update]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GiangVien_Update](
	@MaGV nchar(10),
	@HoTen nvarchar(25),
	@GioiTinh bit,
	@NgaySinh Date,
	@QueQuan nvarchar(25),
	@DiaChi nvarchar(100),
	@EMail char(25),
	@SDT char(11),
	@MaBM char(10),
	@Pic char(15))
AS

BEGIN
	UPDATE GiangVien SET  HoTen=@HoTen, GioiTinh=@GioiTinh,NgaySinh=@NgaySinh, QueQuan=@QueQuan, DiaChi=@DiaChi, Email=@EMail, SDT=@SDT, MaBM=@MaBM, Pic=@Pic WHERE MaGV = @MaGV  
END

/*
BEGIN
	UPDATE PhanQuyen SEt MatKhau = @MatKhau WHERE ID = @MaGV
END
*/
GO
/****** Object:  StoredProcedure [dbo].[SP_HanhKiem_Select]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_HanhKiem_Select](
	@MaLop char(10),
	@KiHoc int)
AS
BEGIN
	SELECT *FROM dbo.HanhKiem_View WHERE MaLop = @MaLop and KiHoc = @KiHoc
END
GO
/****** Object:  StoredProcedure [dbo].[SP_HanhKiem_Select_ByMaSV]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_HanhKiem_Select_ByMaSV](@MaSV char(10))
AS
BEGIN
	SELECT HanhKiem,HocKy,NamHoc FROM HanhKiem WHERE MaSV = @MaSV
END
GO
/****** Object:  StoredProcedure [dbo].[SP_HocBong_Select_All]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_HocBong_Select_All](
	@KiHoc int)
AS
BEGIN
	SELECT MaSV,HoTen,MaLop,dbo.FUNC_DiemTB4KiHoc(MaSV,@KiHoc) AS'DiemTB',dbo.FUNC_TongTC(MaSv,@KiHoc) AS 'TongTC' FROM FUNC_HocBong(@KiHoc)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_HocKi_Select_All]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_HocKi_Select_All]
AS
BEGIN
	SELECT *FROM HocKi
END
GO
/****** Object:  StoredProcedure [dbo].[SP_HocKi_Select_MaxKiHoc]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_HocKi_Select_MaxKiHoc]
AS
BEGIN
	SELECT MAX(KiHoc) FROM HocKi
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KhoaHoc_Delete]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_KhoaHoc_Delete](
@MaKH int)
AS
BEGIN
	DELETE CTKhoaHoc WHERE MaKH = @MaKH
	DELETE KhoaHoc WHERE MaKH = @MaKH	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KhoaHoc_Delete_SinhVien]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_KhoaHoc_Delete_SinhVien](
@MaKH int,
@MaSV char(10))
AS
BEGIN
	DELETE CTKhoaHoc WHERE MaKH = @MaKH and MaSV = @MaSV
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KhoaHoc_Insert]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_KhoaHoc_Insert](
@MaMH char(10),
@MaGV char(10),
@KiHoc int)
AS
BEGIN
	INSERT INTO KhoaHoc VALUES(@MaMH,@MaGV,@KiHoc)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KhoaHoc_Insert_SinhVien]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_KhoaHoc_Insert_SinhVien](
@MaKH int,
@MaSV char(10))
AS
BEGIN
	INSERT INTO CTKhoaHoc VALUES (@MaKH,@MaSV)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KhoaHoc_Select_ByKiHocMaGV]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_KhoaHoc_Select_ByKiHocMaGV](
@KiHoc int,
@MaGV char(10))
AS
BEGIN
	SELECT *FROM KhoaHoc WHERE KiHoc = @KiHoc and MaGV = @MaGV
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KhoaHoc_Select_ByKiHocMaMH]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_KhoaHoc_Select_ByKiHocMaMH](
@KiHoc int,
@MaMH char(10))
AS
BEGIN
	SELECT *FROM KhoaHoc WHERE KiHoc = @KiHoc and MaMH = @MaMH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KhoaHoc_Select_ByMaKH]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_KhoaHoc_Select_ByMaKH](
@MaKH int)
AS
BEGIN
	SELECT SinhVien.MaSV,SinhVien.HoTen,SinhVien.MaLop FROM CTKhoaHoc,SinhVien WHERE MaKH = @MaKH and CTKhoaHoc.MaSV = SinhVien.MaSV
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KhoaHoc_SelectGV_ByMaKH]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_KhoaHoc_SelectGV_ByMaKH](
	@MaKH int)
AS
BEGIN
	SELECT *FROM KhoaHoc_View WHERE MaKH = @MaKH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KiHoc_CheckNull]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_KiHoc_CheckNull](
	@KiHoc int)
AS
BEGIN
	SELECT dbo.FUNC_KiHoc_CheckNull(@KiHoc)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KiHoc_Delete]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_KiHoc_Delete](
	@KiHoc int)
AS
BEGIN
	Delete HocKi WHERE KiHoc = @KiHoc
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KiHoc_Insert]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_KiHoc_Insert](
	@KiHoc int,
	@BatDau Date,
	@KetThuc Date)
AS
BEGIN
	INSERT INTO HocKi VALUES(@KiHoc,@BatDau,@KetThuc)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KiHoc_Update]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_KiHoc_Update](
	@KiHoc int,
	@BatDau Date,
	@KetThuc Date)
AS
BEGIN
	UPDATE HocKi SET BatDau = @BatDau , KetThuc = @KetThuc WHERE KiHoc = @KiHoc
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Lop_Insert]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_Lop_Insert](
@MaLop char(10),
@TenLop nvarchar(50),
@MaGV char(10),
@MaCN char(10),
@NienKhoa int)
AS
BEGiN
	INSERT INTO Lop VALUES(@MaLop,@TenLop,@MaGV,@MaCN,@NienKhoa)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Lop_Select_All]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Lop_Select_All]
AS
BEGIN
	SELECT *FROM Lop_View
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Lop_Select_ByMaCN]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Lop_Select_ByMaCN](@MaCN char(10))
AS
BEGIN
	SELECT *FROM Lop WHERE MaCN = @MaCN
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Lop_Update]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_Lop_Update](
@MaLop char(10),
@TenLop nvarchar(50),
@MaGV char(10),
@MaCN char(10),
@NienKhoa int)
AS
BEGiN
	Update Lop SEt TenLop = @TenLop , MaGV = @MaGV, MaCN = @MaCN, NienKhoa = @NienKhoa WHERE MaLop = @MaLop
END
GO
/****** Object:  StoredProcedure [dbo].[SP_MonHoc_Delete]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_MonHoc_Delete](
	@MaMH char(10))
AS
BEGIN
	DELETE MonHoc WHERE MaMH = @MaMH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_MonHoc_Insert]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_MonHoc_Insert](
	@MaMH char(10),
	@TenMH nvarchar(100),
	@SoTinChi int)
AS
BEGIN
	INSERT INTO MonHoc VALUES(@MaMH,@TenMH,@SoTinChi)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_MonHoc_Select_All]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MonHoc_Select_All]
AS
BEGIN
	SELECT *FROM MonHoc
END
GO
/****** Object:  StoredProcedure [dbo].[SP_MonHoc_Select_ByHocKi]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MonHoc_Select_ByHocKi](
@KiHoc int)
AS
BEGIN
	/*SELECT MonHoc.MaMH,MonHoc.TenMH From Diem,MonHoc,KhoaHoc Where KhoaHoc.KiHoc = Diem.KiHoc and MonHoc.MaMH = KhoaHoc.MaMH and KhoaHoc.KiHoc = @KiHoc*/
	SELECT KhoaHoc.MaMH,MonHoc.TenMH FROM KhoaHoc,MonHoc WHERE KhoaHoc.MaMH = MonHoc.MaMH and KhoaHoc.KiHoc = @KiHoc GROUP BY KhoaHoc.MaMH,TenMH
END


GO
/****** Object:  StoredProcedure [dbo].[SP_MonHoc_Update]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_MonHoc_Update](
	@MaMH char(10),
	@TenMH nvarchar(100),
	@SoTinChi int)
AS
BEGIN
	UPDATE MonHoc SET TenMH = @TenMH, SoTinChi = @SoTinChi WHERE MaMH = @MaMH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_NhapDiem_DanhSach_ByMaMH]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_NhapDiem_DanhSach_ByMaMH](
	@MaMH char(10))
AS
BEGIN
	SELECT *FROM XemDiem_View Where MaMH = @MaMH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PhanQuyen_KhoiPhucMatKhau]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PhanQuyen_KhoiPhucMatKhau](
@ID char(10),
@MatKhau char(32))
AS
BEGIN
	UPDATE PhanQuyen SET MatKhau = @MatKhau WHERE ID = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PhanQuyen_Login]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PhanQuyen_Login](
@ID char(10),
@MatKhau char(32))
AS
BEGIN
	SELECT *FROM PhanQuyen WHERE ID=@ID and MatKhau=@MatKhau
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PhanQuyen_Select_All]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_PhanQuyen_Select_All]
AS
BEGIN
	SELECT *FROM PhanQuyen
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PhanQuyen_Select_ByID]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PhanQuyen_Select_ByID](
@ID char(10))
AS
BEGIN
	SELECT *FROM PhanQuyen Where ID = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_PhanQuyen_Update]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PhanQuyen_Update](
@ID char(10),
@MatKhau char(32),
@PDT bit,
@GV bit,
@SV bit,
@BU bit,
@RT bit,
@FULLC bit)
AS
BEGIN
	UPDATE PhanQuyen Set MatKhau = @MatKhau, PDT = @PDT, GV = @GV , SV = @SV, BU = @BU , RT = @RT, FULLC = @FULLC Where ID = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_QueQuan_Select_All]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_QueQuan_Select_All]
AS
BEGIN
	SELECT *FROM QueQuan
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SinhVien_CheckNull]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SinhVien_CheckNull](
	@MaSV char(10))
AS
BEGIN
	Select dbo.FUNC_SinhVien_CheckNull(@MaSV)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SinhVien_Delete]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SinhVien_Delete]
(@MaSv char(10))
AS
BEGIN
	DELETE FROM  SinhVien WHERE MaSv = @MaSv
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SinhVien_GetMaxMaSV]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SinhVien_GetMaxMaSV]
AS
BEGIN
	SELECT MAX(MaSV) FROM SinhVien
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SinhVien_Insert]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---
-- CREATE PROCEDURE sp_ThemSinhVien
---
CREATE PROCEDURE [dbo].[SP_SinhVien_Insert](
	@MaSv nchar(10),
	@MatKhau nchar(32),
	@HoTen nvarchar(25),
	@GioiTinh bit,
	@NgaySinh date,
	@QueQuan nvarchar(50),
	@DiaChi nvarchar(100),
	@Mail  char(25),
	@SDT char(11),
	@MaLop char(10),
	@Pic char(15))
AS

BEGIN
	INSERT INTO SinhVien VALUES (@MaSv,@HoTen,@GioiTinh,@NgaySinh,@QueQuan,@DiaChi,@Mail,@SDT,@MaLop,@Pic)
END

BEGIN
	INSERT INTO PhanQuyen VALUES (@MaSv,@MatKhau,0,0,0,0,1,0)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SinhVien_Select]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SinhVien_Select]
AS
BEGIN
	SELECT *FROM SinhVien
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SinhVien_Select_All]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SinhVien_Select_All]
AS
BEGIN
	SELECT *FROM SinhVien
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SinhVien_Select_ByMaSV]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SinhVien_Select_ByMaSV](@MaSV char(10))
AS
BEGIN
SELECT *FROM SinhVien_View WHERE MaSV = @MaSV
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SinhVien_ThongTinCaNhan_Update]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SinhVien_ThongTinCaNhan_Update](
	@MaSV char(10),
	@Email char(25),
	@SDT char(11))
AS
BEGIN
	UPDATE SinhVien SET EMail = @Email, SDT = @SDT WHERE MaSV = @MaSV
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SinhVien_Update]    Script Date: 10/06/2021 7:47:32 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SinhVien_Update](
	@MaSv nchar(10),
	@HoTen nvarchar(25),
	@GioiTinh bit,
	@NgaySinh date,
	@QueQuan nvarchar(50),
	@DiaChi nvarchar(100),
	@Mail  char(25),
	@SDT char(11),
	@MaLop char(10),
	@Pic char(15))
AS

BEGIN
	UPDATE  SinhVien SET HoTen = @HoTen,GioiTinh =  @GioiTinh,NgaySinh = @NgaySinh, QueQuan = @QueQuan, DiaChi = @DiaChi, EMail = @Mail, SDT = @SDT, MaLop = @MaLop, Pic = @Pic WHERE MaSv = @MaSv
END
/*
BEGIN
	UPDATE PhanQuyen SET MatKhau = @MatKhau WHERE ID = @MaSv
END
*/

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "SinhVien"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "HanhKiem"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 119
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'HanhKiem_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'HanhKiem_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "GiangVien"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MonHoc"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 119
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "KhoaHoc"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'KhoaHoc_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'KhoaHoc_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Lop"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 171
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "ChuyenNganh"
            Begin Extent = 
               Top = 115
               Left = 374
               Bottom = 228
               Right = 544
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GiangVien"
            Begin Extent = 
               Top = 3
               Left = 696
               Bottom = 256
               Right = 866
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1890
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Lop_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Lop_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = -45
      End
      Begin Tables = 
         Begin Table = "ChuyenNganh"
            Begin Extent = 
               Top = 6
               Left = 83
               Bottom = 119
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Khoa"
            Begin Extent = 
               Top = 6
               Left = 291
               Bottom = 136
               Right = 461
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Lop"
            Begin Extent = 
               Top = 6
               Left = 499
               Bottom = 136
               Right = 669
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "SinhVien"
            Begin Extent = 
               Top = 6
               Left = 707
               Bottom = 136
               Right = 877
            End
            DisplayFlags = 280
            TopColumn = 6
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 13
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SinhVien_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SinhVien_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SinhVien_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Diem"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 194
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "MonHoc"
            Begin Extent = 
               Top = 5
               Left = 277
               Bottom = 118
               Right = 447
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SinhVien"
            Begin Extent = 
               Top = 41
               Left = 463
               Bottom = 171
               Right = 633
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'XemDiem_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'XemDiem_View'
GO
USE [master]
GO
ALTER DATABASE [QuanLiSinhVien] SET  READ_WRITE 
GO
