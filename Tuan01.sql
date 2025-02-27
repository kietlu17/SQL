--BÀI 1 
--1. Tạo cơ sở dữ liệu QLTV tham số tùy ý 
create database QLTV
--2. Tạo các LOGIN Minh, Huy, Le, Linh, An, và Binh: 
--a. Password lần lượt là tên username viết hoa
use QLTV
create login Minh
with password ='Minh'

create user Minh for login Minh

create login Huy
with password ='Huy'

create user Huy for login Huy

create login Le
with password ='Le'

create user Le for login Le

create login Linh
with password ='Linh'

create user Linh for login Linh

create login An
with password ='An'

create user An for login An

create login Binh
with password ='Binh'

create user Binh for login Binh

--3. Cho bảng Sach 
--Sach(MaSach INT PRIMARY KEY, 
--TenSach NVARCHAR(40) 
--) 
create table Sach(
	MaSach int primary key not null,
	TenSach NVARCHAR(40) 
)

--a. Tạo các role sau: DataEntry, Supervisor, và Management. 
create role DataEntry
create role Supervisor
create role Management

exec sp_helprole DataEntry

--Gán Minh, Huy, và Linh vào role DataEntry, gán Le vào role Supervisor, và gán An 
--và Binh vào role Management. 

exec sp_addrolemember DataEntry, Minh
exec sp_addrolemember DataEntry, Huy
exec sp_addrolemember DataEntry, Linh

exec sp_addrolemember Supervisor, Le

exec sp_addrolemember Management, An

--b. Cho role DataEntry các quyền SELECT, INSERT, và UPDATE trên bảng Sach. 
grant select, insert, update on Sach to DataEntry

--c. Cho role Supervisor các quyền SELECT và DELETE trên bảng Sach.
grant select, delete on Sach to Supervisor

--d. Cho role Management quyền SELECT trên bảng Sach.
grant select on Sach to Management

--4. Tạo một user mới tên NameManager với password là pc123. Gán quyền update cho 
--user này trên cột TenSach của bảng Sach. 
create login NameManager with password = 'pc123'

create user NameManager for login NameManager

grant update on Sach(TenSach) to NameManager

--6. Thực hiện các bước sau: 
--a. Cho phép user Minh quyền cấp quyền cho các user khác 
grant select,insert,update on Sach to Minh with grant option 
--b. Gán tất cả các quyền mà Minh có cho Binh. Binh có quyền INSERT và UPDATE 
--trên bảng QLTV không?