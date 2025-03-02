use QuanLyNhanSu

insert into NhanVien values ('A01', 'Nguyễn Anh Lin', 
'1/2/88','TPHCM')

select * from NhanVien

delete from NhanVien where MaNV = 'A01'
-- xóa ko đc vì không có quyền xem bảng NhanVien chỉ có thể xóa tất cả Nhân viên