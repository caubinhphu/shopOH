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

create table PHANLOAISANPHAM (
	MA_SANPHAM INT NOT NULL,
    MAUSAC varchar(20) NOT NULL,
    SIZE varchar(10) NOT NULL,
    SOLUONGTON INT DEFAULT 0,
    primary key (MA_SANPHAM, MAUSAC, SIZE)
);
ALTER TABLE PHANLOAISANPHAM ADD foreign key (MA_SANPHAM) references SANPHAM (MA_SANPHAM);

INSERT INTO SANPHAM (MA_SANPHAM, TEN_SANPHAM, MA_LOAI2, MA_THUONGHIEU, MA_CHATLIEU, MOTA, GIABAN, KHUYENMAI, HINHANH)
VALUES (2, 'SƠ MI TRẮNG TAY DÀI', 3, 1, 6, '🌈🌈🌈SƠ MI NAM WHITE & BLACK
⛔️ ÁO BÊN Ý ĐẶT MAY NHÉ!!! chất lượng đẹp từng cái - BAO ĐỔI NẾU HÀNG KÉM CHẤT LƯỢNG.
⚡️⚡️⚡️ Giá lẻ: 170k
⚡️⚡️⚡️ Giá sỉ 5sp: 145k 
❣️ Shopee: shopee.vn/menshopgiare
❣️ Size: M - L XL - XXL
📞📞 CALL/ ZALO: 0987.96.4243', 200000, 46, 'HINHANH');

insert into PHANLOAISANPHAM
values (1, 'Trắng', 'S', 100),
	   (1, 'Trắng', 'M', 65),
       (1, 'Trắng', 'L', 14),
       (1, 'Đen', 'S', 354),
       (1, 'Đen', 'M', 354),
       (1, 'Đen', 'L', 43),
       (2, 'Trắng', 'S', 100),
	   (2, 'Trắng', 'M', 65),
       (2, 'Trắng', 'L', 14),
       (2, 'Xám', 'S', 354),
       (2, 'Xám', 'M', 354),
       (2, 'Xám', 'L', 43);

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

CREATE TABLE GIOHANG (
	MA_KHACHHANG INT NOT NULL,
    MA_SANPHAM INT NOT NULL,
	SOLUONG INT DEFAULT 1,
    PRIMARY KEY (MA_KHACHHANG, MA_SANPHAM),
    FOREIGN KEY (MA_KHACHHANG) REFERENCES KHACHHANG (MA_KHACHHANG),
    FOREIGN KEY (MA_SANPHAM) REFERENCES SANPHAM (MA_SANPHAM)
);

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

call SP_SELECT_MOUNT_PRODUCT (1, 'Trắng', 'M');

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