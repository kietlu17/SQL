--BÀI 3: PHÂN QUYỀN THEO VAI TRÒ 
--1) Tạo CSDL ThuVien 
create database ThuVien
--2) Thực hiện các lệnh import hay Select…into các Table từ CSDL QLTV ở BÀI 1 vào 
--CSDL ThuVien 
use ThuVien
select * 
into Sach
from [QLTV].[dbo].[Sach]

--3) Tạo các users Minh, Huy, Le, Linh, và Binh. Password lần lượt là tên username viết hoa. 
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
--4) Tạo các role sau: QLBH, NVKHO, QLNVTV, QLTV, NVBH cho CSDL ThuVien 
create role QLBH
create role NVKHO
create role QLNVTV
create role QLTV
create role NVBH
--5) Gán các người dùng Minh, Huy, Le, Linh, Bình vào các Role tương ứng theo ma trận 
--phân quyền trong BÀI 1. 
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


--6) Lần lượt đăng nhập vào từng Login và thực hiện các lệnh cho từng người dùng. Các 
--lệnh sinh viên tự nghĩ và thực hiện đủ các lệnh trong cả hai trường hợp là người dùng 
--thực hiện được và không thực hiện được. Giải thích cho từng lệnh. 
--7) Tạo một user mới tên Lan với password là Lan123. Gán quyền update cho user này 
--trên cột TenSach của bảng Sach. Thực hiện lệnh kiểm tra tương ứng. 
create login Lan
with password ='Lan123'

create user Lan for login Lan

grant update (TenSach) on Sach to Lan

--8) Thu hồi quyền cho Role NVBH. Thực hiện lệnh kiểm tra tương ứng 

revoke SELECT on Sach from NVBH;
revoke SELECT on DanhMucSach from NVBH;
revoke SELECT, INSERT, UPDATE, DELETE on HoaDon from NVBH;
revoke SELECT, INSERT, UPDATE, DELETE to ChiTietHD from NVBH;
--9) Thu hồi quyền của người dùng có tên Lan
revoke update (TenSach) on Sach from Lan
--10) Tạo một user mới tên Lan với password là Lan123. Gán quyền update cho user này 
--trên cột TenSach của bảng Sach. Thực hiện lệnh kiểm tra tương ứng. Viết lệnh DENY 
--cho người dùng này

grant update (TenSach) on Sach to Lan

deny update (TenSach) on Sach to Lan