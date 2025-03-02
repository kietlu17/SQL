--2.1
CREATE DATABASE QuanLyNhanSu 
ON PRIMARY
(
    NAME = QuanLyNhanSu_data,
    FILENAME = 'D:\sql\QuanLyNhanSu_data.mdf',
    SIZE = 100MB,
    FILEGROWTH = 50MB
)
LOG ON
(
    NAME = QuanLyNhanSu_log,
    FILENAME = 'D:\sql\QuanLyNhanSu_log.ldf',
    SIZE = 300MB,
    FILEGROWTH = 100MB
);

--2.2
use QuanLyNhanSu

create table  NhanVien (
MaNV varchar(20) primary key not null,
TenNV Nvarchar(100),
NgaySinh varchar(10),
NoiSinh nvarchar(50)
)

create table  LuongNV (
MaNV varchar(20)  not null,
NamThang varchar(7) not null,
Luong float,
primary key(MaNV, NamThang)
)

--2.3
create login LyNT with password ='Abc12345'
create login HungNT with password ='Abc12345'

--2.4
create user LyNT for login LyNT
create user HungNT for login HungNT

--2.5
grant insert, select, delete on NhanVien to LyNT
grant insert, select,delete on LuongNV to LyNT

grant select (MaNv, TenNV) on NhanVien to HungNT
grant update on NhanVien to HungNT
grant update on LuongNV to HungNT