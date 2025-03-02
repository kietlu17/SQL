CREATE DATABASE QuanLyDaoTao 
ON PRIMARY
(
    NAME = QuanLyDaoTao_data,
    FILENAME = 'D:\sql\QuanLyDaoTao_data.mdf',
    SIZE = 100MB,
    FILEGROWTH = 50MB
)
LOG ON
(
    NAME = QuanLyNhanSu_log,
    FILENAME = 'D:\sql\QuanLyDaoTao_log.ldf',
    SIZE = 300MB,
    FILEGROWTH = 100MB
);
use QuanLyDaoTao

create table Lop(
MaLop varchar(20) primary key not null,
TenLop Nvarchar(100)
)

create table SinhVien(
MaSv varchar(20) primary key not null,
TenSv Nvarchar(100),
NgaySinh varchar(20),
NoiSinh nvarchar(50),
MaLop varchar(20),
FOREIGN key (MaLop) references Lop(MaLop)
)

create table MonHoc(
MaMh varchar(20) primary key not null,
TenMh Nvarchar(100),
SoGio int
)

create table DiemTP(
MaSv varchar(20)  not null,
MaMh varchar(20)  not null,
Diem float
primary key(MaSv, MaMh),
FOREIGN KEY (MaSv) REFERENCES SinhVien(MaSv),
FOREIGN KEY (MaMh) REFERENCES MonHoc(MaMh)
)

--4
insert into Lop values ('CN0201', 'Khóa 2001 ')
insert into Lop values ('CN0202', 'Khóa 2002 ')

insert into SinhVien values ('sv01', 'Nguyễn Văn Hưng', '12/02/1988' , 'Hồ Chí Minh', 'CN0201')
insert into SinhVien values ('sv02', 'LE Hưng', '12/02/1988' , 'Bình Dương ', 'CN0201')
insert into SinhVien values ('sv03', 'LE', '12/02/1988' , 'Bình Dương ', 'CN0202')

insert into MonHoc values ('THVP', 'Tin học văn phòng ', 45)
insert into MonHoc values ('THDC', 'Tin học đại cương  ', 45)
insert into MonHoc values ('CSDL', 'Cơ sở dữ liệu ', 30)

insert into DiemTP values ('sv01', 'THVP', 8.0)
insert into DiemTP values ('sv01', 'THDC', 8.0)
insert into DiemTP values ('sv01', 'CSDL', 8.0)

--6
create role BanGiamHieu
create role KhoaMangTruyenThong
create role KhoaKyThuatPhanMen
create role KhoaTaiChinhKeToan
create role PhongDaoTao

grant select on database::[QuanLyDaoTao] to BanGiamHieu
grant select on SinhVien to KhoaMangTruyenThong
grant select on Lop to KhoaMangTruyenThong

grant select, insert, delete, update on SinhVien to KhoaKyThuatPhanMen
grant select, insert, delete, update on Lop to KhoaKyThuatPhanMen
grant select, insert, delete, update on MonHoc to KhoaKyThuatPhanMen

grant select on DiemTP to KhoaTaiChinhKeToan

grant select, insert, delete, update on schema::dbo to PhongDaoTao

create login AnhNH with password ='Abc12345'
create user AnhNH for login AnhNH
alter role BanGiamHieu add member AnhNH

create login TrungDM with password ='Abc12345'
create user TrungDM for login TrungDM
alter role KhoaMangTruyenThong add member TrungDM

create login ThuatDV with password ='Abc12345'
create user ThuatDV for login ThuatDV
alter role KhoaKyThuatPhanMen add member ThuatDV

create login TuanTV with password ='Abc12345'
create user TuanTV for login TuanTV
alter role KhoaTaiChinhKeToan add member TuanTV

create login TramNTH with password ='Abc12345'
create user TramNTH for login TramNTH
alter role PhongDaoTao add member TramNTH

