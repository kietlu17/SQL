--Bài 2
--4. Tạo cơ sở dữ liệu QLTV tham số tùy ý. Trong CSDL QLTV có các bảng dữ liệu sau
use QLTV

create table NhomSach
(MaNhom  char(5) , TenNhom nvarchar(25)) 

create table NhanVien(MaNV char(5), HoLot nvarchar(25), TenNV nvarchar(10), Phai  
nvarchar(3), NgaySinh Smalldatetime, DiaChi nvarchar(40)) 

create table DanhMucSach(MaSach char(5), TenSach nvarchar(40), TacGia 
nvarchar(100),  

MaNhom char(5), DonGia Numeric(5), SoLuongTon numeric(5))

create table HoaDon(MaHD char(5), NgayBan  SmallDatetime, MaNV char(5)) 

create table ChiTietHD(MaHD  char(5), MaSach  char(5), SoLuong numeric(5))

insert into NhomSach values ('N001', 'Kỹ thuật trồng trọt')

insert into DanhMucSach values('S111', 'Đèn không hắt bóng ', 'Dzunichi Watanabe (Cao Xuân Hạo dịch)','N001' ,55000, 45)
select * from DanhMucSach

-- 5.Tạo các users Minh, Huy, Le, Linh, và Binh. Password lần lượt là tên username viết hoa
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

create login Binh
with password ='Binh'

create user Binh for login Binh

--6. Cho bảng ma trận phân quyền như sau:

create role QLBH
create role NVKHO
create role QLNVTV
create role QLTV
create role NVBH

ALTER ROLE QLTV ADD MEMBER Minh;
ALTER ROLE QLNVTV ADD MEMBER Huy;
ALTER ROLE QLBH ADD MEMBER Le;
ALTER ROLE NVBH ADD MEMBER Linh;
ALTER ROLE NVKho ADD MEMBER Binh

GRANT SELECT, INSERT, UPDATE, DELETE ON Sach TO QLTV;
GRANT SELECT, INSERT, UPDATE, DELETE ON DanhMucSach TO QLTV;
GRANT SELECT, INSERT, UPDATE, DELETE ON HoaDon TO QLTV;
GRANT SELECT, INSERT, UPDATE, DELETE ON ChiTietHD TO QLTV;
GRANT CONTROL ON NhanVien TO QLTV; -- Cho phép cấp quyền cho user khác

GRANT SELECT ON Sach TO QLNVTV;
GRANT SELECT, INSERT, UPDATE, DELETE ON NhanVien TO QLNVTV;
GRANT SELECT ON DanhMucSach TO QLNVTV;

GRANT SELECT, UPDATE ON Sach TO QLBH;
GRANT SELECT, UPDATE ON DanhMucSach TO QLBH;
GRANT SELECT ON HoaDon TO QLBH;
GRANT SELECT ON ChiTietHD TO QLBH;

GRANT SELECT ON Sach TO NVBH;
GRANT SELECT ON DanhMucSach TO NVBH;
GRANT SELECT, INSERT, UPDATE, DELETE ON HoaDon TO NVBH;
GRANT SELECT, INSERT, UPDATE, DELETE ON ChiTietHD TO NVBH;

GRANT SELECT, INSERT, UPDATE, DELETE ON Sach TO NVKho;
GRANT SELECT, INSERT, UPDATE, DELETE ON DanhMucSach TO NVKho;


--9. Thu hồi quyền sửa trên bảng DanhMucSach cho người dùng Le. Viết lệnh kiểm tra tương ứng. 
revoke select on DanhMucSach from Le

SELECT dp.name AS UserName, dp.type_desc, dp.create_date, dp.modify_date, 
       perm.permission_name, perm.state_desc, perm.class_desc, obj.name AS ObjectName
FROM sys.database_principals AS dp
LEFT JOIN sys.database_permissions AS perm ON dp.principal_id = perm.grantee_principal_id
LEFT JOIN sys.objects AS obj ON perm.major_id = obj.object_id
WHERE dp.name = 'QLNVTV';

--10.Thu hồi quyền sửa và xoá trên bảng NhomSach và DanhMucSach cho người Bình. Viết 
--lệnh kiểm tra tương ứng. 
revoke select on DanhMucSach from NVKho
revoke select on  Sach from NVKho

SELECT dp.name AS UserName, perm.permission_name, perm.state_desc, obj.name AS ObjectName
FROM sys.database_principals AS dp
JOIN sys.database_permissions AS perm ON dp.principal_id = perm.grantee_principal_id
LEFT JOIN sys.objects AS obj ON perm.major_id = obj.object_id
WHERE dp.name = 'Binh';

--11. Viết lệnh từ chối quyền xoá trên bảng NhanVien cho người tên Huy. Viết lệnh kiểm tra tương ứng
deny delete on NhanVien to QLNVTV