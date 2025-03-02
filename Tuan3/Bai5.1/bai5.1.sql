--BÀI 5: ỨNG DỤNG VÀO BÀI TOÁN CỤ THỂ 
--BÀI 5.1. 
--Câu 1: Sử dụng tài khoản với quyền quản trị thực hiện tạo login, user và cấp quyền 
--1.1 Tạo login tên admin1, mật khẩu Abc12345 
--1.2 Tạo user thuộc cơ sở dữ liệu master (Databases System Databases master) 
--1.3 Cấp quyền tạo cơ sở dữ liệu, tạo bảng
create login admin1 with password ='Abc12345'
create user admin1 for login admin1

GRANT CREATE ANY DATABASE TO admin1;

-- Cấp quyền tạo bảng trong tất cả các cơ sở dữ liệu mà admin1 có quyền truy cập
GRANT ALTER ANY SCHEMA TO admin1;
GRANT CREATE TABLE TO admin1;
grant control server to admin1