ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '01695402297';
flush privileges;

CREATE DATABASE SHOPBAN_QUANAO;

USE SHOPBAN_QUANAO;

CREATE TABLE THUONGHIEU (
	MA_THUONGHIEU INT AUTO_INCREMENT NOT NULL,
	TEN_THUONGHIEU VARCHAR(50) NOT NULL,
	PRIMARY KEY (MA_THUONGHIEU)
);

INSERT INTO THUONGHIEU (TEN_THUONGHIEU)
VALUES ('No brand'),
	   ('Abercrombie & Fitch'),
       ('Adidas'),
       ('Aeropostale'),
       ('Aj Morgan'),
       ('Aldo'),
       ('ĐAN CHÂU');
       
CREATE TABLE CHATLIEU (
	MA_CHATLIEU INT AUTO_INCREMENT NOT NULL,
    TEN_CHATLIEU VARCHAR(50) NOT NULL,
    PRIMARY KEY (MA_CHATLIEU)
);

INSERT INTO CHATLIEU (TEN_CHATLIEU)
VALUES ('Dây'),
	   ('Lông cừu'),
       ('Len đan'),
       ('Len acrylic'),
       ('Cashmere'),
       ('Cotton');
       
CREATE TABLE LOAI_SP0 (
	MA_LOAI0 INT AUTO_INCREMENT NOT NULL,
    TEN_LOAI0 VARCHAR(50) NOT NULL,
    PRIMARY KEY (MA_LOAI0)
);

INSERT INTO LOAI_SP0 (TEN_LOAI0)
VALUES ('Quần áo nam'),
	   ('Quần áo nữ');
       
CREATE TABLE LOAI_SP1 (
	MA_LOAI1 INT AUTO_INCREMENT NOT NULL,
    TEN_LOAI1 VARCHAR(50) NOT NULL,
    MA_LOAI0 INT NOT NULL,
    PRIMARY KEY (MA_LOAI1),
    FOREIGN KEY (MA_LOAI0) REFERENCES LOAI_SP0(MA_LOAI0)
);

INSERT INTO LOAI_SP1 (TEN_LOAI1, MA_LOAI0)
VALUES ('Áo thun', 1),
	   ('Áo sơ mi', 1),
       ('Áo', 2),
	   ('Chân váy', 2);

CREATE TABLE LOAI_SP2 (
	MA_LOAI2 INT AUTO_INCREMENT NOT NULL,
    TEN_LOAI2 VARCHAR(50) NOT NULL,
	MA_LOAI1 INT NOT NULL,
    PRIMARY KEY (MA_LOAI2),
    FOREIGN KEY (MA_LOAI1) REFERENCES LOAI_SP1(MA_LOAI1)
);

INSERT INTO LOAI_SP2 (TEN_LOAI2, MA_LOAI1)
VALUES ('Áo len', 1),
	   ('Áo ngắn tay có cổ', 1),
       ('Dài tay', 2),
	   ('Ngắn tay', 2),
       ('Áo Croptop', 3),
	   ('Áo sơ mi', 3),
       ('Chân váy xoè', 4),
	   ('Chân váy ngắn', 4);
       
CREATE TABLE SANPHAM (
	MA_SANPHAM INT NOT NULL,
    TEN_SANPHAM VARCHAR(250) NOT NULL,
    MA_LOAI2 INT NOT NULL,
    MA_THUONGHIEU INT NOT NULL,
    MA_CHATLIEU INT NOT NULL,
    -- KHOILUONG INT DEFAULT 0,
    MOTA TEXT NULL,
    GIABAN INT NOT NULL DEFAULT 0,
    KHUYENMAI TINYINT DEFAULT 0,
	HINHANH VARCHAR(1000) NOT NULL,
    -- SOLUONGTON INT DEFAULT 0,
    PRIMARY KEY (MA_SANPHAM),
    FOREIGN KEY (MA_LOAI2) REFERENCES LOAI_SP2 (MA_LOAI2),
    FOREIGN KEY (MA_THUONGHIEU) REFERENCES THUONGHIEU (MA_THUONGHIEU),
    FOREIGN KEY (MA_CHATLIEU) REFERENCES CHATLIEU (MA_CHATLIEU)
);
ALTER TABLE sanpham DROP column SOLUONGTON;
ALTER TABLE sanpham ADD column `LIKE` INT default 0;
ALTER TABLE sanpham ADD column DABAN INT default 0;
ALTER TABLE sanpham drop column `LIKE`;

create table LIKESANPHAM (
	MA_SANPHAM INT,
    MA_KHACHHANG INT,
    primary key (MA_SANPHAM, MA_KHACHHANG),
    FOREIGN KEY (MA_KHACHHANG) REFERENCES KHACHHANG (MA_KHACHHANG),
    FOREIGN KEY (MA_SANPHAM) REFERENCES SANPHAM (MA_SANPHAM)
);
alter table LIKESANPHAM drop foreign key likesanpham_ibfk_2;
alter table likesanpham add foreign key (MA_SANPHAM) REFERENCES SANPHAM (MA_SANPHAM)
							on delete cascade;

create table PHANLOAISANPHAM (
	MA_SANPHAM INT NOT NULL,
    MAUSAC varchar(20) NOT NULL,
    SIZE varchar(10) NOT NULL,
    SOLUONGTON INT DEFAULT 0,
    primary key (MA_SANPHAM, MAUSAC, SIZE)
);
ALTER TABLE PHANLOAISANPHAM ADD foreign key (MA_SANPHAM) references SANPHAM (MA_SANPHAM);
alter table phanloaisanpham drop foreign key phanloaisanpham_ibfk_1;
ALTER TABLE PHANLOAISANPHAM ADD foreign key (MA_SANPHAM)
			references SANPHAM (MA_SANPHAM) on delete cascade;
            
select * from phanloaisanpham;
select * from likesanpham;
select * from loai_sp2;
update sanpham set giaban = 150000 where ma_sanpham = 1;
INSERT INTO SANPHAM (MA_SANPHAM, TEN_SANPHAM, MA_LOAI2, MA_THUONGHIEU, MA_CHATLIEU, MOTA, GIABAN, KHUYENMAI, HINHANH)
VALUES--   (1, 'Áo Sơ Mi Nam Cổ Tàu Dài Tay Ikemen SMT01', 3, 1, 6, 'Áo Sơ Mi Nam Cổ Tàu Dài Tay Ikemen :
-- 🔰  HƯỚNG DẪN CÁCH ĐẶT HÀNG:
-- ⏩  Cách chọn size: Shop có bảng size mẫu. Bạn NÊN INBOX, cung cấp chiều cao, cân nặng để SHOP TƯ VẤN SIZE
-- ⏩ Cách đặt hàng: Nếu bạn muốn mua 2 sản phẩm khác nhau hoặc 2 size khác nhau
-- -	Bạn chọn từng sản phẩm rồi thêm vào giỏ hàng
-- -	Khi giỏ hàng đã có đầy đủ các sản phẩm cần mua, bạn vào giỏ hàng tiến hành đặt hàng.
-- ⏩ Shop luôn sẵn sàng trả lời inbox để tư vấn.

-- THÔNG TIN SẢN PHẨM sơ mi nam cổ tàu:
-- -> Chất lụa trơn, mềm mịn mỏng không nhăn, không xù, không bai, không phai màu. Mếch cổ và tay làm bằng chất liệu cao cấp, không sợ bong tróc. 
-- -> Form body Hàn Quốc ôm trọn bờ vai mặc cực trẻ trung và phong cách, phù hợp mọi hoàn cảnh kể cả đi chơi và đi làm. 
-- -> Xuất Xứ : Việt Nam
-- -> Màu: Trắng, Đen, Xanh coban, Đỏ Đô, Xanh dương nhạt
-- -> Sản phẩm có các size như sau:
-- 👉SIZE M: Cân nặng 48-55kg, Cao 1m50 - 1m62, " Áo Dài giữa cổ sau đến lai bầu 68cm, Vai 38cm, Vòng ngực 88cm, Chiết eo 76cm, Dài tay 54cm" 
-- 👉SIZE L: Can nặng 55- 60kg, Cao 1m60 - 1m68, " Áo Dài giữa cổ sau đến lai bầu 70cm, Vai 40cm, Vòng Ngực 92cm, Chiết eo 80cm, Dài tay 56cm" 
-- 👉SIZE XL: cân nặng 60 - 68kg, Cao 1m65 - 1m72, " Áo Dài giữa cổ sau xuống lai bầu 72cm, Vai 42cm, Vòng ngực 96cm, Chiết eo 84cm, Dài tay 58cm" 
-- 👉SIZE XXL: Cân nặng 65 -74kg Cao 1m7. - 1m80, Áo Dài giữa cổ sau xuống lai bầu 74cm, Vai 46cm, Vòng Ngực 100cm, Chiết eo 90cm, Dài tay 60cm" 
-- SIZEXXXL : Cân nặng 72 -84kg
-- ->Hàng có sẵn, đủ size: M, L, XL, XXL, 3XL
-- =>CHÚNG TÔI CAM KẾT 
-- 👉 Cam kết chất lượng và mẫu mã sản phẩm giống với hình ảnh.
-- 👉 Hoàn tiền nếu sản phẩm không giống với mô tả. 
-- 👉 Được kiểm tra hàng trước khi thanh toán. 
-- 👉 Cam kết được đổi trả hàng trong vòng 7 ngày.', 150, 47, '/images/be88e9f1b18ee5b8a07d132752544dcf.jpg,/images/f25b2f5e5798c6290cda1d2f7f514ee8.jpg,/images/f58b1e860a91c1955da13f785646ff11.jpg,/images/f622fdf611f6148d604aee5f9418e34e.jpg,/images/538802932ade0df4c8d7948aa2f65141.jpg'),
(2, 'Áo sơ mi nam trơn dài tay công sở , dáng ôm body Hàn Quốc', 3, 1, 6, '1. GIỚI THIỆU SẢN PHẨM
    Áo Sơ Mi Nam dài tay dáng ôm body , chống nhăn cao cấp  chính là gợi ý tuyệt vời cho nam giới mỗi khi lựa chọn trang phục mỗi ngày. Với những mẫu áo sơ mi nam thiết kế đơn giản và toát lên vẻ lịch lãm tinh tế, mang đến phong cách thời trang trẻ trung, năng động chắc chắn sẽ là lựa chọn hoàn hảo cho chàng trai hiện đại, nam tính. Những chiếc áo sơ mi dài tay dáng dù kết hợp với quần âu, quần jeans khi đi làm hay diện cùng quần ngố, quần short đi chơi đều NỔI BẬT, THOẢI MÁI và PHONG CÁCH. Với form dáng vừa vặn các chàng có thể tự tin khoe body cực chuẩn của mình. Hãy bổ sung ngay vào tủ đồ item này để diện thật chất nhé!

2. THÔNG TIN CHI TIẾT
- Chất liệu: 100% chất cotton lụa, thấm hút mồ hôi 
-Chất vải sờ mịn không bai, không nhăn, không xù
- Quy cách, tiêu chuẩn đường may tinh tế, tỉ mỉ trong từng chi tiết
- Kiểu dáng: Thiết kế đơn giản, dễ mặc, dễ phối đồ
- Form body Hàn Quốc mang lại phong cách trẻ trung, lịch lãm
- Chất lượng sản phẩm tốt, giá cả hợp lý

3. CHÍNH SÁCH BÁN HÀNG:
- Cam kết chất lượng và mẫu mã sản phẩm giống với hình ảnh.
- Hoàn tiền nếu sản phẩm không giống với mô tả.
- Ngoài ra IKEMEN SHOP tặng voucher hoặc hoàn xu cho các đơn hàng tương ứng đủ điều kiện.
- Rất mong nhận được ý kiến đóng góp của Quý khách hàng để chúng tôi cải thiện chất lượng dịch vụ tốt hơn.

 4. HƯỚNG DẪN CÁCH ĐẶT HÀNG
- Bước 1: Cách chọn size, shop có bảng size mẫu. Bạn NÊN INBOX, cung cấp chiều cao, cân nặng để SHOP TƯ VẤN SIZE
- Bước 2: Cách đặt hàng: Nếu bạn muốn mua 2 sản phẩm khác nhau hoặc 2 size khác nhau, để được freeship
- Bạn chọn từng sản phẩm rồi thêm vào giỏ hàng
- Khi giỏ hàng đã có đầy đủ các sản phẩm cần mua, bạn mới tiến hành ấn nút “ Thanh toán”
- Shop luôn sẵn sàng trả lời inbox để tư vấn.

5. HƯỚNG DẪN CHỌN SIZE ÁO SƠ MI NAM:
    (Size áo phụ thuộc vào chiều cao cân nặng và các yếu tố khác như vòng ngực, bụng, vai, bắp tay,... Do đó quý khách còn phân vân xin vui lòng nhắn tin trực tiếp để được hỗ trợ tốt nhất)
- Size M: Cân nặng từ 48-51kg, Chiều cao dưới 163cm
- Size L: Cân nặng từ 51-60kg, Chiều cao 163 - 168cm
- Size XL: Cân nặng từ 60-65kg, Chiều cao 165 - 170cm
- Size XXL: Cân nặng từ 64-72kg, Chiều cao 170 - 175cm
- Size 3XL: Cân nặng từ 72-80kg, Chiều cao 170 - 183cm
- Hàng có sẵn, đủ size:M, L, XL, XXL,3XL.', 150000, 0, '/images/677b37385a048e30c6dcf560c5f23fae.jpg,/images/f350384d912fa95541199b1ef10992a7.jpg,/images/d7cc742447c07a0944507154790b0d50.jpg,/images/bb2bbd97543266e5154f29c3bca4d5e1.jpg,/images/2e53f2232a0986c2bf94fb46d1a12bd4.jpg'),
(3, 'Áo croptop tay ngắn cổ tim-thun cotton', 5, 1, 6, '* Sản phẩm free size dưới 48 kg
* Chất liệu: thun cotton
* Sản phẩm y hình, bao đổi trả trong vòng 1 ngày nếu sản phẩm không đúng với mô tả
* Màu sắc: như hình. Khách đặt hàng vui lòng chọn phân loại màu để được đóng gói và giao hàng sớm nhất nhé

HƯỚNG DẪN MUA HÀNG: 
1- Khách chọn màu rùi ấn chọn số lượng=> Thêm vào giỏ hàng
2- Để chọn màu khác vui long lặp lại bước trên rồi cũng Thêm vào giỏ hàng
3- Vào giỏ hàng chọn mua những sản phẩm vừa thêm xong là đc nhé
Shop tư vấn 24/7 cho tất cả thắc mắc size cỡ theo chiều cao cân nặng ^^
Facebook: https://www.facebook.com/do.an.1848816
Hotline: 0888-900-550 ( call, sms, zalo)', 68000, 49, '/images/36fce04f4c75dfddfd4bd6091f358ac0.jpg,/images/2c5592756af5362a6941f20d05adb49d.jpg,/images/78a91f32d178908eb610ee62da8028ed.jpg,/images/089e99f4b4cb1605a2ca4e962ede6348.jpg,/images/e1d31839df38e084e950893523706ff6.jpg');
select * from loai_sp2;
select * from chatlieu;
delete from sanpham where ma_sanpham = 3;
insert into PHANLOAISANPHAM
values -- (1, 'Trắng', 'M', 100),
-- 	   (1, 'Trắng', 'L', 65),
--        (1, 'Trắng', 'XL', 354),
--        (1, 'Trắng', 'XXL', 354),
--        (1, 'Trắng', 'XXXL', 43),
--        (1, 'Đen', 'M', 45),
-- 	   (1, 'Đen', 'L', 63),
--        (1, 'Đen', 'XL', 13),
--        (1, 'Đen', 'XXL', 34),
--        (1, 'Đen', 'XXXL', 42),
       
       (2, 'Trắng', 'M', 46),
	   (2, 'Trắng', 'L', 48),
       (2, 'Trắng', 'XL', 14),
       (2, 'Trắng', 'XXL', 15),
       (2, 'Trắng', 'XXXL', 87),
       (2, 'Đen', 'M', 64),
	   (2, 'Đen', 'L', 65),
       (2, 'Đen', 'XL', 64),
       (2, 'Đen', 'XXL', 67),
       (2, 'Đen', 'XXXL', 67),
       (2, 'Xanh nước biển', 'M', 46),
	   (2, 'Xanh nước biển', 'L', 15),
       (2, 'Xanh nước biển', 'XL', 34),
       (2, 'Xanh nước biển', 'XXL', 78),
       (2, 'Xanh nước biển', 'XXXL', 45),
       (2, 'Xanh than', 'M', 64),
	   (2, 'Xanh than', 'L', 64),
       (2, 'Xanh than', 'XL', 78),
       (2, 'Xanh than', 'XXL', 45),
       (2, 'Xanh than', 'XXXL', 34),
       (2, 'Đỏ đô', 'M', 45),
	   (2, 'Đỏ đô', 'L', 78),
       (2, 'Đỏ đô', 'XL', 14),
       (2, 'Đỏ đô', 'XXL', 45),
       (2, 'Đỏ đô', 'XXXL', 15);

insert into PHANLOAISANPHAM
values (3, 'Đen', '1 size', 15),
	   (3, 'Trắng', '1 size', 65);


CREATE TABLE KHACHHANG (
	MA_KHACHHANG INT NOT NULL,
    TAIKHOAN VARCHAR(50) NOT NULL,
    MATKHAU VARCHAR(50) NOT NULL,
    TEN_KHACHHANG VARCHAR(100) NULL,
    DIENTHOAI VARCHAR(20) NULL,
    -- `TINH/THANHPHO` VARCHAR(100) NULL,
--     `QUAN/HUYEN` VARCHAR(100) NULL,
--     `PHUONG/XA` VARCHAR(100) NULL,
--     `SONHA/DUONG` VARCHAR(100) NULL,
    AVATAR VARCHAR(100) NULL,
    PRIMARY KEY (MA_KHACHHANG)
);
ALTER table khachhang DROP column `TINH/THANHPHO`;
ALTER table khachhang DROP column `QUAN/HUYEN`;
ALTER table khachhang DROP column `PHUONG/XA`;
ALTER table khachhang DROP column `SONHA/DUONG`;
ALTER table khachhang add column EMAIL varchar(100);

create TABLE DIACHIKHACHHANG (
	MA_KHACHHANG INT,
    TEN VARCHAR(100),
    DIENTHOAI VARCHAR(20),
    `TINH/THANHPHO` VARCHAR(100),
	`QUAN/HUYEN` VARCHAR(100),
    `PHUONG/XA` VARCHAR(100),
    `SONHA/DUONG` VARCHAR(100),
    MACDINH BIT default FALSE,
    PRIMARY KEY (MA_KHACHHANG, TEN, DIENTHOAI, `TINH/THANHPHO`, `QUAN/HUYEN`, `PHUONG/XA`, `SONHA/DUONG`),
    FOREIGN KEY (MA_KHACHHANG) REFERENCES KHACHHANG (MA_KHACHHANG)
);

INSERT INTO KHACHHANG (MA_KHACHHANG, TAIKHOAN, MATKHAU, TEN_KHACHHANG, DIENTHOAI, `TINH/THANHPHO`, `QUAN/HUYEN`, `PHUONG/XA`, `SONHA/DUONG`, AVATAR)
VALUES (1, 'caubinhphu', '1234', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

CREATE TABLE TRANGTHAI_DONHANG (
	MA_TRANGTHAI INT AUTO_INCREMENT NOT NULL,
    TEN_TRANGTHAI VARCHAR(50) NOT NULL,
    PRIMARY KEY (MA_TRANGTHAI)
);

INSERT INTO TRANGTHAI_DONHANG(TEN_TRANGTHAI)
VALUES ('Chờ xác nhận'),
	   ('Chờ lấy hàng'),
       ('Đang giao'),
       ('Đã giao'),
       ('Đã huỷ'),
       ('Trả hàng/Hoàn tiền');
drop table giohang;
CREATE TABLE GIOHANG (
	MA_KHACHHANG INT NOT NULL,
    MA_SANPHAM INT NOT NULL,
	SOLUONG INT DEFAULT 1,
    MAUSAC VARCHAR(20),
    SIZE VARCHAR(10),
    NGAYTHEM DATETIME,
    PRIMARY KEY (MA_KHACHHANG, MA_SANPHAM, MAUSAC, SIZE),
    FOREIGN KEY (MA_KHACHHANG) REFERENCES KHACHHANG (MA_KHACHHANG),
    FOREIGN KEY (MA_SANPHAM) REFERENCES SANPHAM (MA_SANPHAM) on delete cascade
);

select * from giohang;
INSERT INTO GIOHANG (MA_KHACHHANG, MA_SANPHAM)
VALUES (1, 1);

CREATE TABLE DONDATHANG (
	MA_DONDATHANG INT NOT NULL,
    MA_KHACHHANG INT NOT NULL,
    NGAY_DATHANG DATE,
    MA_TRANGTHAI INT NOT NULL,
    TEN_NGUOINHAN VARCHAR(100) NOT NULL,
    DIENTHOAI_NGUOINHAN VARCHAR(20) NOT NULL,
	`TINH/THANHPHO` VARCHAR(100) NOT NULL,
    `QUAN/HUYEN` VARCHAR(100) NOT NULL,
    `PHUONG/XA` VARCHAR(100) NOT NULL,
    `SONHA/DUONG` VARCHAR(100) NOT NULL,
    PHI_VANCHUYEN INT DEFAULT 0,
    NGAY_XUATHANG DATE,
    NGAY_GIAOHANG DATE,
    PRIMARY KEY (MA_DONDATHANG),
    FOREIGN KEY (MA_KHACHHANG) REFERENCES KHACHHANG (MA_KHACHHANG),
    FOREIGN KEY (MA_TRANGTHAI) REFERENCES TRANGTHAI_DONHANG (MA_TRANGTHAI)
);

CREATE TABLE CT_DONDATHANG (
	MA_DONDATHANG INT NOT NULL,
    MA_SANPHAM INT NOT NULL,
    SOLUONG INT DEFAULT 1,
    GIAGOC INT DEFAULT 0,
    KHUYENMAI INT DEFAULT 0,
    PRIMARY KEY (MA_DONDATHANG, MA_SANPHAM),
    FOREIGN KEY (MA_DONDATHANG) REFERENCES DONDATHANG (MA_DONDATHANG),
    FOREIGN KEY (MA_SANPHAM) REFERENCES SANPHAM (MA_SANPHAM)
);

select * from khachhang;

DELIMITER $$
create procedure sp_test()
begin
	select * from khachhang;
    select * from thuonghieu;
end $$
DELIMITER ;

call sp_test();

select * from khachhang;

select * from sanpham limit 10;

delimiter $$
create procedure SP_SELECT_SAMEPRODUCT(id int, ma_loai int, ma_chat int)
begin
	-- Lấy sản phẩm chính
	select ma_sanpham, ten_sanpham, giaban, `like` from sanpham where MA_SANPHAM = id;
    
    -- Lấy sản phẩm tương tự (cùng mã loại 2 và cùng mã chất liệu)
    select ma_sanpham, ten_sanpham, giaban, `like`
    from sanpham
    where MA_LOAI2 = ma_loai and MA_CHATLIEU = ma_chat and MA_SANPHAM != id;
end $$
delimiter ;

call SP_SELECT_SAMEPRODUCT(1, 3, 6);

delimiter $$
create procedure SP_SELECT_PRODUCT(id int)
begin
	-- Lấy sản phẩm chính
	select sp.ma_sanpham, sp.ten_sanpham, daban, sp.giaban, sp.khuyenmai, sp.mota, sp.hinhanh,
		   cl.ten_chatlieu, th.ten_thuonghieu, l0.ten_loai0, l1.ten_loai1, l2.ten_loai2
    from sanpham sp join thuonghieu th on sp.ma_thuonghieu = th.ma_thuonghieu
					join chatlieu cl on sp.ma_chatlieu = cl.ma_chatlieu
                    join loai_sp2 l2 on sp.ma_loai2 = l2.ma_loai2
                    join loai_sp1 l1 on l2.ma_loai1 = l1.ma_loai1
                    join loai_sp0 l0 on l1.ma_loai0 = l0.ma_loai0
    where sp.ma_sanpham = id;
    
    -- Lấy màu sắc
    select mausac
    from phanloaisanpham
    where ma_sanpham = id
    group by mausac;
    
    -- Lấy size
    select size
    from phanloaisanpham
    where ma_sanpham = id
    group by size;
    
    -- Lấy tổng số lượng sản phẩm
    select sum(soluongton) as sl
    from phanloaisanpham
    where ma_sanpham = id;
    
    -- Lấy tổng like
    select count(*) as `like`
    from likesanpham
    where ma_sanpham = id;
    
    -- check user current is liked
    if exists (select * from likesanpham
			   where ma_sanpham = id and ma_khachhang = idUser)
	then select true as isLike;
    else select false as isLike;
    end if;
    
    -- Lấy sản phẩm tương tự (cùng mã loại 2 và cùng mã chất liệu)
    select ma_sanpham, ten_sanpham, giaban, khuyenmai, daban
    from sanpham
    where MA_SANPHAM != id
		  and ma_loai2 = (select ma_loai2 from sanpham where ma_sanpham = id)
		  and ma_chatlieu = (select ma_chatlieu from sanpham where ma_sanpham = id);
end $$
delimiter ;

call SP_SELECT_PRODUCT(2, 1);

delimiter $$
create procedure SP_SELECT_MOUNT_PRODUCT (_id int, _color varchar(10), _size varchar(5))
begin
	if exists (select soluongton from phanloaisanpham
			   where ma_sanpham = _id and mausac = _color and size = _size)
    then select soluongton from phanloaisanpham
		 where ma_sanpham = _id and mausac = _color and size = _size;
    else select 0;
    end if;
end $$
delimiter ;

call SP_SELECT_MOUNT_PRODUCT (3, 'Trắng', '1 size');

insert into likesanpham (ma_sanpham, ma_khachhang)
values (1, 1);

delimiter $$
create procedure SP_ADDLIKE (_id int, _idUser int)
begin
	if exists (select * from sanpham where ma_sanpham = _id)
		and  exists (select * from khachhang where ma_khachhang = _idUser)
	then insert into likesanpham (ma_sanpham, ma_khachhang)
		 values (_id, _idUser);
	end if;
    
    -- Lấy tổng like
    select count(*) as `like`
    from likesanpham
    where ma_sanpham = id;
end $$
delimiter ;

call SP_ADDLIKE (2, 1);

delimiter $$
create procedure SP_DELETELIKE (_id int, _idUser int)
begin
	if exists (select * from sanpham where ma_sanpham = _id)
		and  exists (select * from khachhang where ma_khachhang = _idUser)
	then delete from likesanpham
		 where ma_sanpham = _id and ma_khachhang = _idUser;
	end if;
    
    -- Lấy tổng like
    select count(*) as `like`
    from likesanpham
    where ma_sanpham = id;
end $$
delimiter ;
call SP_DELETELIKE(2, 1);

delimiter $$
create procedure SP_SELECT_PRODUCT_SUGGESTION()
begin
	select ma_sanpham, ten_sanpham, giaban, khuyenmai, daban, ma_loai2, hinhanh, ma_chatlieu
    from sanpham
    limit 10;
end $$
delimiter ;
call SP_SELECT_PRODUCT_SUGGESTION();

delimiter $$
create procedure SP_SELECT_PRODUCT_ALL()
begin
	select ma_sanpham, ten_sanpham, giaban, khuyenmai, daban, ma_loai2, hinhanh, ma_chatlieu
    from sanpham;
end $$
delimiter ;
call SP_SELECT_PRODUCT_ALL();

delimiter $$
create procedure SP_SELECT_PRODUCT_STYLE(_style int)
begin
	select ma_sanpham, ten_sanpham, giaban, khuyenmai, daban, hinhanh, daban
    from sanpham sp join loai_sp2 l2 on sp.ma_loai2 = l2.ma_loai2
                    join loai_sp1 l1 on l2.ma_loai1 = l1.ma_loai1
    where l1.ma_loai0 = _style;
end $$
delimiter ;
call SP_SELECT_PRODUCT_STYLE(2);

select * from loai_sp2;

delimiter $$
create procedure SP_INSERT_CART(_idPro int, _ifUser int, _color varchar(20), _size varchar(10), _sl int, _time datetime)
spInsertCartLabel:begin
	-- Check
    if not exists (select * from khachhang where ma_khachhang = _idUser)
    then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'user not exists';
    end if;
    
    if not exists (select *
				   from sanpham sp join phanloaisanpham pl on sp.ma_sanpham = pl.ma_sanpham
                   where sp.ma_sanpham = _idPro and pl.mausac = _color and pl.size = _size)
    then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'product not exists';
	end if;
    
	if exists (select * from giohang
			   where ma_sanpham = _idPro and mausac = _color and size = _size)
	then
		update giohang
        set soluong = soluong + _sl
        where ma_sanpham = _idPro and mausac = _color and size = _size;
	else
		insert into giohang (ma_sanpham, ma_khachhang, mausac, size, soluong)
        values (_idPro, _idUser, _color, _size, _sl);
    end if;
end $$
delimiter ;
call SP_INSERT_CART(1, 1, 'Đen', 'M', 2);
call SP_INSERT_CART(1, 1, 'Đen', 'L', 1);
call SP_INSERT_CART(1, 1, 'Đen', 'XL', 2);
call SP_INSERT_CART(1, 1, 'Trắng', 'M', 2);
call SP_INSERT_CART(2, 1, 'Đen', 'M', 2);
call SP_INSERT_CART(2, 1, 'Đen', 'L', 1);
call SP_INSERT_CART(2, 1, 'Đen', 'XL', 1);
call SP_INSERT_CART(2, 1, 'Đen', 'XXL', 2);
call SP_INSERT_CART(3, 1, 'Trắng', '1 size', 1);
call SP_INSERT_CART(3, 1, 'Đen', '1 size', 1);

select * from giohang;

delimiter $$
create procedure SP_SELECT_CART(_idUser int)
begin
	-- Tổng số sản phẩm trong giỏ
    select count(*) as sl, ifnull(sum(soluong), 0) as slsp
    from giohang
    where ma_khachhang = 1;
    
    -- Lấy từng sản phẩm
    select gh.ma_sanpham, sp.ten_sanpham, mausac, size, soluong, hinhanh, giaban, khuyenmai, ma_khachhang
    from giohang gh join sanpham sp on gh.ma_sanpham = sp.ma_sanpham
	where ma_khachhang = _idUser
    order by ngaythem;
end $$
delimiter ;
call SP_SELECT_CART(1);

create table test (tg datetime);
select tg from test order by tg desc;
insert into test values (NOW());

delimiter $$
create procedure SP_DELETE_CART(_idPro int, _iduser int, _color varchar(20), _size varchar(10))
begin
	-- Check
    if not exists (select * from giohang
				   where ma_sanpham = _idPro and ma_khachhang = _idUser and mausac = _color and size = _size)
	then SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'cart not exists';
    else delete from giohang where ma_sanpham = _idPro and ma_khachhang = _idUser and mausac = _color and size = _size;
    end if;
end $$
delimiter ;
call SP_DELETE_CART(3, 1, 'den', '1 Size');
select * from giohang;

delimiter $$
create procedure SP_UPDATE_CART(_iduser int, _idPro int, _color varchar(20), _size varchar(10), _sl int)
begin
	-- Check
    if not exists (select * from giohang
				   where ma_sanpham = _idPro and ma_khachhang = _idUser and mausac = _color and size = _size)
	then SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'cart not exists';
    else update giohang
		 set soluong = _sl
		 where ma_sanpham = _idPro and ma_khachhang = _idUser and mausac = _color and size = _size;
    end if;
end $$
delimiter ;