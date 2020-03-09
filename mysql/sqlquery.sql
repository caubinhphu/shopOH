alter database shopoh character set utf16 collate utf16_general_ci;

create table thuonghieu (
	ma_thuonghieu int auto_increment not null,
	ten_thuonghieu varchar(50) not null,
	primary key (ma_thuonghieu)
);
alter table thuonghieu convert to character set utf16 collate utf16_general_ci;

insert into thuonghieu (ten_thuonghieu)
values ('No brand'),
	     ('Abercrombie & Fitch'),
       ('Adidas'),
       ('Aeropostale'),
       ('Aj Morgan'),
       ('Aldo'),
       ('Đan Châu');

create table chatlieu (
	ma_chatlieu int auto_increment not null,
  ten_chatlieu varchar(50) not null,
  primary key (ma_chatlieu)
);
alter table chatlieu convert to character set utf16 collate utf16_general_ci;

insert into chatlieu (ten_chatlieu)
values ('Dây'),
	     ('Lông cừu'),
       ('Len đan'),
       ('Len acrylic'),
       ('Cashmere'),
       ('Cotton');
       
create table loai_sp0 (
	ma_loai0 int auto_increment not null,
  ten_loai0 varchar(50) not null,
  primary key (ma_loai0)
);
alter table loai_sp0 convert to character set utf16 collate utf16_general_ci;

insert into loai_sp0 (ten_loai0)
values ('Quần áo nam'),
	     ('Quần áo nữ');
       
create table loai_sp1 (
	ma_loai1 int auto_increment not null,
  ten_loai1 varchar(50) not null,
  ma_loai0 int not null,
  primary key (ma_loai1),
  foreign key (ma_loai0) references loai_sp0(ma_loai0)
);
alter table loai_sp1 convert to character set utf16 collate utf16_general_ci;

insert into loai_sp1 (ten_loai1, ma_loai0)
values ('Áo thun', 1),
	     ('Áo sơ mi', 1),
       ('Áo', 2),
	     ('Chân váy', 2);

create table loai_sp2 (
	ma_loai2 int auto_increment not null,
  ten_loai2 varchar(50) not null,
	ma_loai1 int not null,
  primary key (ma_loai2),
  foreign key (ma_loai1) references loai_sp1(ma_loai1)
);
alter table loai_sp2 convert to character set utf16 collate utf16_general_ci;

insert into loai_sp2 (ten_loai2, ma_loai1)
values ('Áo len', 1),
	     ('Áo ngắn tay có cổ', 1),
       ('Dài tay', 2),
	     ('Ngắn tay', 2),
       ('Áo croptop', 3),
	     ('Áo sơ mi', 3),
       ('Chân váy xoè', 4),
	     ('Chân váy ngắn', 4);
       
create table sanpham (
	ma_sanpham varchar(50) not null,
  ten_sanpham varchar(250) not null,
  ma_loai2 int not null,
  ma_thuonghieu int not null,
  ma_chatlieu int not null,
  mota text null,
  giaban int not null default 0,
  khuyenmai tinyint default 0,
	hinhanh varchar(1000) not null,
  daban int default 0,
  primary key (ma_sanpham),
  foreign key (ma_loai2) references loai_sp2 (ma_loai2),
  foreign key (ma_thuonghieu) references thuonghieu (ma_thuonghieu),
  foreign key (ma_chatlieu) references chatlieu (ma_chatlieu)
);
alter table sanpham convert to character set utf16 collate utf16_general_ci;

update sanpham
set hinhanh = '/images/products/36fce04f4c75dfddfd4bd6091f358ac0.jpg,/images/products/2c5592756af5362a6941f20d05adb49d.jpg,/images/products/78a91f32d178908eb610ee62da8028ed.jpg,/images/products/089e99f4b4cb1605a2ca4e962ede6348.jpg,/images/products/e1d31839df38e084e950893523706ff6.jpg'
where ma_sanpham = '3';

insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh)
values ('1', 'áo sơ mi nam cổ tàu dài tay ikemen smt01', 3, 1, 6, 'áo sơ mi nam cổ tàu dài tay ikemen :
  ⏺  hướng dẫn cách đặt hàng:
  ⏩  cách chọn size: shop có bảng size mẫu. bạn nên inbox, cung cấp chiều cao, cân nặng để shop tư vấn size
  ⏩  cách đặt hàng: nếu bạn muốn mua 2 sản phẩm khác nhau hoặc 2 size khác nhau
  -	bạn chọn từng sản phẩm rồi thêm vào giỏ hàng
  -	khi giỏ hàng đã có đầy đủ các sản phẩm cần mua, bạn vào giỏ hàng tiến hành đặt hàng.
  ⏩ shop luôn sẵn sàng trả lời inbox để tư vấn.

  thông tin sản phẩm sơ mi nam cổ tàu:
  -> chất lụa trơn, mềm mịn mỏng không nhăn, không xù, không bai, không phai màu. mếch cổ và tay làm bằng chất liệu cao cấp, không sợ bong tróc. 
  -> form body hàn quốc ôm trọn bờ vai mặc cực trẻ trung và phong cách, phù hợp mọi hoàn cảnh kể cả đi chơi và đi làm. 
  -> xuất xứ : việt nam
  -> màu: trắng, đen, xanh coban, đỏ đô, xanh dương nhạt
  -> sản phẩm có các size như sau:
  ⏩ size m: cân nặng 48-55kg, cao 1m50 - 1m62, "áo dài giữa cổ sau đến lai bầu 68cm, vai 38cm, vòng ngực 88cm, chiết eo 76cm, dài tay 54cm" 
  ⏩ size l: cân nặng 55- 60kg, cao 1m60 - 1m68, "áo dài giữa cổ sau đến lai bầu 70cm, vai 40cm, vòng ngực 92cm, chiết eo 80cm, dài tay 56cm" 
  ⏩ size xl: cân nặng 60 - 68kg, cao 1m65 - 1m72, "áo dài giữa cổ sau xuống lai bầu 72cm, vai 42cm, vòng ngực 96cm, chiết eo 84cm, dài tay 58cm" 
  ⏩ size xxl: cân nặng 65 -74kg cao 1m7. - 1m80, áo dài giữa cổ sau xuống lai bầu 74cm, vai 46cm, vòng ngực 100cm, chiết eo 90cm, dài tay 60cm" 
  ⏩ size xxxl : cân nặng 72 -84kg
  -> hàng có sẵn, đủ size: m, l, xl, xxl, 3xl
  => chúng tôi cam kết 
  ⏩ cam kết chất lượng và mẫu mã sản phẩm giống với hình ảnh.
  ⏩ hoàn tiền nếu sản phẩm không giống với mô tả. 
  ⏩ được kiểm tra hàng trước khi thanh toán. 
  ⏩ cam kết được đổi trả hàng trong vòng 7 ngày.',
  150000, 47, '/images/be88e9f1b18ee5b8a07d132752544dcf.jpg,/images/f25b2f5e5798c6290cda1d2f7f514ee8.jpg,/images/f58b1e860a91c1955da13f785646ff11.jpg,/images/f622fdf611f6148d604aee5f9418e34e.jpg,/images/538802932ade0df4c8d7948aa2f65141.jpg'),
    
    ('2', 'áo sơ mi nam trơn dài tay công sở , dáng ôm body hàn quốc', 3, 1, 6,
  '1. giới thiệu sản phẩm
  áo sơ mi nam dài tay dáng ôm body , chống nhăn cao cấp  chính là gợi ý tuyệt vời cho nam giới mỗi khi lựa chọn trang phục mỗi ngày. với những mẫu áo sơ mi nam thiết kế đơn giản và toát lên vẻ lịch lãm tinh tế, mang đến phong cách thời trang trẻ trung, năng động chắc chắn sẽ là lựa chọn hoàn hảo cho chàng trai hiện đại, nam tính. những chiếc áo sơ mi dài tay dáng dù kết hợp với quần âu, quần jeans khi đi làm hay diện cùng quần ngố, quần short đi chơi đều nổi bật, thoải mái và phong cách. với form dáng vừa vặn các chàng có thể tự tin khoe body cực chuẩn của mình. hãy bổ sung ngay vào tủ đồ item này để diện thật chất nhé!

  2. thông tin chi tiết
  - chất liệu: 100% chất cotton lụa, thấm hút mồ hôi 
  -chất vải sờ mịn không bai, không nhăn, không xù
  - quy cách, tiêu chuẩn đường may tinh tế, tỉ mỉ trong từng chi tiết
  - kiểu dáng: thiết kế đơn giản, dễ mặc, dễ phối đồ
  - form body hàn quốc mang lại phong cách trẻ trung, lịch lãm
  - chất lượng sản phẩm tốt, giá cả hợp lý

  3. chính sách bán hàng:
  - cam kết chất lượng và mẫu mã sản phẩm giống với hình ảnh.
  - hoàn tiền nếu sản phẩm không giống với mô tả.
  - ngoài ra ikemen shop tặng voucher hoặc hoàn xu cho các đơn hàng tương ứng đủ điều kiện.
  - rất mong nhận được ý kiến đóng góp của quý khách hàng để chúng tôi cải thiện chất lượng dịch vụ tốt hơn.

  4. hướng dẫn cách đặt hàng
  - bước 1: cách chọn size, shop có bảng size mẫu. bạn nên inbox, cung cấp chiều cao, cân nặng để shop tư vấn size
  - bước 2: cách đặt hàng: nếu bạn muốn mua 2 sản phẩm khác nhau hoặc 2 size khác nhau, để được freeship
  - bạn chọn từng sản phẩm rồi thêm vào giỏ hàng
  - khi giỏ hàng đã có đầy đủ các sản phẩm cần mua, bạn mới tiến hành ấn nút “ thanh toán”
  - shop luôn sẵn sàng trả lời inbox để tư vấn.

  5. hướng dẫn chọn size áo sơ mi nam:
      (size áo phụ thuộc vào chiều cao cân nặng và các yếu tố khác như vòng ngực, bụng, vai, bắp tay,... do đó quý khách còn phân vân xin vui lòng nhắn tin trực tiếp để được hỗ trợ tốt nhất)
  - size m: cân nặng từ 48-51kg, chiều cao dưới 163cm
  - size l: cân nặng từ 51-60kg, chiều cao 163 - 168cm
  - size xl: cân nặng từ 60-65kg, chiều cao 165 - 170cm
  - size xxl: cân nặng từ 64-72kg, chiều cao 170 - 175cm
  - size 3xl: cân nặng từ 72-80kg, chiều cao 170 - 183cm
  - hàng có sẵn, đủ size:m, l, xl, xxl,3xl.',
  150000, 0, '/images/677b37385a048e30c6dcf560c5f23fae.jpg,/images/f350384d912fa95541199b1ef10992a7.jpg,/images/d7cc742447c07a0944507154790b0d50.jpg,/images/bb2bbd97543266e5154f29c3bca4d5e1.jpg,/images/2e53f2232a0986c2bf94fb46d1a12bd4.jpg'),

    ('3', 'áo croptop tay ngắn cổ tim-thun cotton', 5, 1, 6,
  '* sản phẩm free size dưới 48 kg
  * chất liệu: thun cotton
  * sản phẩm y hình, bao đổi trả trong vòng 1 ngày nếu sản phẩm không đúng với mô tả
  * màu sắc: như hình. khách đặt hàng vui lòng chọn phân loại màu để được đóng gói và giao hàng sớm nhất nhé

  hướng dẫn mua hàng: 
  1- khách chọn màu rùi ấn chọn số lượng=> thêm vào giỏ hàng
  2- để chọn màu khác vui long lặp lại bước trên rồi cũng thêm vào giỏ hàng
  3- vào giỏ hàng chọn mua những sản phẩm vừa thêm xong là đc nhé
  shop tư vấn 24/7 cho tất cả thắc mắc size cỡ theo chiều cao cân nặng ^^
  facebook: https://www.facebook.com/do.an.1848816
  hotline: 0888-900-550 ( call, sms, zalo)',
  68000, 49, '/images/36fce04f4c75dfddfd4bd6091f358ac0.jpg,/images/2c5592756af5362a6941f20d05adb49d.jpg,/images/78a91f32d178908eb610ee62da8028ed.jpg,/images/089e99f4b4cb1605a2ca4e962ede6348.jpg,/images/e1d31839df38e084e950893523706ff6.jpg');

create table phanloaisanpham (
	ma_sanpham varchar(50) not null,
  mausac varchar(30) not null,
  size varchar(20) not null,
  soluongton int default 0,
  primary key (ma_sanpham, mausac, size),
  foreign key (ma_sanpham) references sanpham (ma_sanpham) on delete cascade
);
alter table phanloaisanpham convert to character set utf16 collate utf16_general_ci;

insert into phanloaisanpham (ma_sanpham, mausac, size, soluongton)
values ('1', 'TRẮNG', 'M', 100),
      ('1', 'TRẮNG', 'L', 65),
      ('1', 'TRẮNG', 'XL', 354),
      ('1', 'TRẮNG', 'XXL', 354),
      ('1', 'TRẮNG', 'XXXL', 43),
      ('1', 'ĐEN', 'M', 45),
      ('1', 'ĐEN', 'L', 63),
      ('1', 'ĐEN', 'XL', 13),
      ('1', 'ĐEN', 'XXL', 34),
      ('1', 'ĐEN', 'XXXL', 42),
       
      ('2', 'TRẮNG', 'M', 46),
	    ('2', 'TRẮNG', 'L', 48),
      ('2', 'TRẮNG', 'XL', 14),
      ('2', 'TRẮNG', 'XXL', 15),
      ('2', 'TRẮNG', 'XXXL', 87),
      ('2', 'ĐEN', 'M', 64),
	    ('2', 'ĐEN', 'L', 65),
      ('2', 'ĐEN', 'XL', 64),
      ('2', 'ĐEN', 'XXL', 67),
      ('2', 'ĐEN', 'XXXL', 67),
      ('2', 'XANH NƯỚC BIỂN', 'M', 46),
	    ('2', 'XANH NƯỚC BIỂN', 'L', 15),
      ('2', 'XANH NƯỚC BIỂN', 'XL', 34),
      ('2', 'XANH NƯỚC BIỂN', 'XXL', 78),
      ('2', 'XANH NƯỚC BIỂN', 'XXXL', 45),
      ('2', 'XANH THAN', 'M', 64),
	    ('2', 'XANH THAN', 'L', 64),
      ('2', 'XANH THAN', 'XL', 78),
      ('2', 'XANH THAN', 'XXL', 45),
      ('2', 'XANH THAN', 'XXXL', 34),
      ('2', 'ĐỎ ĐÔ', 'M', 45),
	    ('2', 'ĐỎ ĐÔ', 'L', 78),
      ('2', 'ĐỎ ĐÔ', 'XL', 14),
      ('2', 'ĐỎ ĐÔ', 'XXL', 45),
      ('2', 'ĐỎ ĐÔ', 'XXXL', 15),
      
      ('3', 'ĐEN', '1 SIZE', 15),
      ('3', 'TRẮNG', '1 SIZE', 65);


create table khachhang (
	ma_khachhang varchar(50) not null,
  taikhoan varchar(50) not null,
  matkhau varchar(100) not null,
  ten_khachhang varchar(100) null,
  email varchar(100),
  dienthoai varchar(20) null,
  avatar varchar(100) null,
  primary key (ma_khachhang)
);
alter table khachhang convert to character set utf16 collate utf16_general_ci;

insert into khachhang (ma_khachhang, taikhoan, matkhau, ten_khachhang, email, dienthoai, avatar)
values ('1', 'caubinhphu', '1234', null, 'abc@gmail.com', null, null);

create table diachikhachhang (
	ma_khachhang varchar(50),
  ten varchar(100),
  dienthoai varchar(20),
  `tinh/thanhpho` varchar(100),
	`quan/huyen` varchar(100),
  `phuong/xa` varchar(100),
  `sonha/duong` varchar(100),
  macdinh bit default false,
  primary key (ma_khachhang, ten, dienthoai, `tinh/thanhpho`, `quan/huyen`, `phuong/xa`, `sonha/duong`),
  foreign key (ma_khachhang) references khachhang (ma_khachhang) on delete cascade
);
alter table diachikhachhang convert to character set utf16 collate utf16_general_ci;

create table likesanpham (
	ma_sanpham  varchar(50),
  ma_khachhang varchar(50),
  primary key (ma_sanpham, ma_khachhang),
  foreign key (ma_khachhang) references khachhang (ma_khachhang) on delete cascade,
  foreign key (ma_sanpham) references sanpham (ma_sanpham) on delete cascade
);


-- ----------- chưa tạo bảng -------------------------- --
create table trangthai_donhang (
	ma_trangthai int auto_increment not null,
  ten_trangthai varchar(50) not null,
  primary key (ma_trangthai)
);

insert into trangthai_donhang(ten_trangthai)
values ('Chờ xác nhận'),
	    ('Chờ lấy hàng'),
      ('Đang giao'),
      ('Đã giao'),
      ('Đã huỷ'),
      ('Trả hàng/Hoàn tiền');

create table dondathang (
	ma_dondathang int not null,
  ma_khachhang varchar(50) not null,
  ngay_dathang date,
  ma_trangthai int not null,
  ten_nguoinhan varchar(100) not null,
  dienthoai_nguoinhan varchar(20) not null,
	`tinh/thanhpho` varchar(100) not null,
  `quan/huyen` varchar(100) not null,
  `phuong/xa` varchar(100) not null,
  `sonha/duong` varchar(100) not null,
  phi_vanchuyen int default 0,
  ngay_xuathang date,
  ngay_giaohang date,
  primary key (ma_dondathang),
  foreign key (ma_khachhang) references khachhang (ma_khachhang),
  foreign key (ma_trangthai) references trangthai_donhang (ma_trangthai)
);

create table ct_dondathang (
	ma_dondathang int not null,
  ma_sanpham varchar(50) not null,
  soluong int default 1,
  giagoc int default 0,
  khuyenmai int default 0,
  primary key (ma_dondathang, ma_sanpham),
  foreign key (ma_dondathang) references dondathang (ma_dondathang),
  foreign key (ma_sanpham) references sanpham (ma_sanpham)
);
-- ---------------------------------------------------- --

create table giohang (
	ma_khachhang varchar(50) not null,
  ma_sanpham varchar(50) not null,
	soluong int default 1,
  mausac varchar(30),
  size varchar(20),
  ngaythem datetime,
  primary key (ma_khachhang, ma_sanpham, mausac, size),
  foreign key (ma_khachhang) references khachhang (ma_khachhang) on delete cascade,
  foreign key (ma_sanpham) references sanpham (ma_sanpham) on delete cascade
);

-- insert into giohang(ma_khachhang, ma_sanpham, soluong, mausac, size, ngaythem)
-- values ('1', '1', 2, 'ĐEN', 'M', null);

-- -------------------procedure -------------------- --
-- lấy sản phẩm gợi ý index
delimiter $$
create procedure SP_SELECT_PRODUCT_SUGGESTION()
begin
	select ma_sanpham, ten_sanpham, giaban, khuyenmai, daban, ma_loai2, hinhanh, ma_chatlieu
  from sanpham
  limit 10;
end $$
delimiter ;
call SP_SELECT_PRODUCT_SUGGESTION();

-- lấy thông tin sản phẩm trong giỏ của khách hàng
delimiter $$
create procedure SP_SELECT_CART(_iduser varchar(50))
begin
	-- tổng số sản phẩm trong giỏ
    select count(*) as sl, ifnull(sum(soluong), 0) as slsp
    from giohang
    where ma_khachhang = _iduser;
    
  -- lấy từng sản phẩm
  select gh.ma_sanpham, sp.ten_sanpham, mausac, size, soluong, hinhanh, giaban, khuyenmai
  from giohang gh join sanpham sp on gh.ma_sanpham = sp.ma_sanpham
	where ma_khachhang = _iduser
  order by ngaythem desc;
end $$
delimiter ;
call sp_select_cart(1);

-- lấy sản phẩm chính kèm các sản phẩm cùng loại
delimiter $$
create procedure SP_SELECT_SAMEPRODUCT(_idpro varchar(50), _idcategory2 int, _idmaterial int)
begin
	-- lấy sản phẩm chính
	select ma_sanpham, ten_sanpham, giaban, daban, hinhanh, khuyenmai
  from sanpham
  where ma_sanpham = _idpro;
  
  -- lấy sản phẩm tương tự (cùng mã loại 2 và cùng mã chất liệu)
  select ma_sanpham, ten_sanpham, giaban, daban, khuyenmai, hinhanh
  from sanpham
  where ma_loai2 = _idcategory2 and ma_chatlieu = _idmaterial and ma_sanpham != _idpro
  limit 10;
end $$
delimiter ;

call SP_SELECT_SAMEPRODUCT(1, 3, 6);

-- lấy thông tin sản phẩm
delimiter $$
create procedure SP_SELECT_PRODUCT(_idpro varchar(50), _iduser varchar(50))
begin
	-- lấy thông tin sản phẩm
	select sp.ma_sanpham, sp.ten_sanpham, daban, sp.giaban, sp.khuyenmai, sp.mota, sp.hinhanh,
		    cl.ten_chatlieu, th.ten_thuonghieu, l0.ten_loai0, l1.ten_loai1, l2.ten_loai2
  from sanpham sp join thuonghieu th on sp.ma_thuonghieu = th.ma_thuonghieu
                  join chatlieu cl on sp.ma_chatlieu = cl.ma_chatlieu
                  join loai_sp2 l2 on sp.ma_loai2 = l2.ma_loai2
                  join loai_sp1 l1 on l2.ma_loai1 = l1.ma_loai1
                  join loai_sp0 l0 on l1.ma_loai0 = l0.ma_loai0
  where sp.ma_sanpham = _idpro;
    
    -- lấy màu sắc
    select mausac from phanloaisanpham
    where ma_sanpham = _idpro
    group by mausac;
    
    -- lấy size
    select size from phanloaisanpham
    where ma_sanpham = _idpro
    group by size;
    
    -- lấy tổng số lượng sản phẩm
    select ifnull(sum(soluongton), 0) as sl
    from phanloaisanpham
    where ma_sanpham = _idpro;
    
    -- lấy tổng like
    select count(*) as `like`
    from likesanpham
    where ma_sanpham = _idpro;
    
    -- check user current is liked
    if exists (select * from likesanpham where ma_sanpham = _idpro and ma_khachhang = _iduser)
      then select true as islike;
    else select false as islike;
    end if;
    
    -- lấy sản phẩm tương tự (cùng mã loại 2 và cùng mã chất liệu)
    select ma_sanpham, ten_sanpham, giaban, khuyenmai, daban, hinhanh
    from sanpham
    where ma_sanpham != _idpro
		  and ma_loai2 = (select ma_loai2 from sanpham where ma_sanpham = _idpro)
		  and ma_chatlieu = (select ma_chatlieu from sanpham where ma_sanpham = _idpro)
    limit 10;
end $$
delimiter ;

call sp_select_product('2', 1);

-- Lấy số lượng sản phẩm tồn kho theo màu và size
delimiter $$
create procedure SP_SELECT_MOUNT_PRODUCT (_idPro varchar(50), _color varchar(30), _size varchar(20))
begin
  select soluongton from phanloaisanpham
	where ma_sanpham = _idPro and mausac = _color and size = _size;
end $$
delimiter ;

call sp_select_mount_product (3, 'trắng', '1 size');

-- Add like và return tổng like của sản phẩm
delimiter $$
create procedure SP_ADDLIKE (_idpro varchar(50), _iduser varchar(50))
begin
  -- check exists product? => add like
	if exists (select * from sanpham where ma_sanpham = _idpro)
	  then insert into likesanpham (ma_sanpham, ma_khachhang)
		      values (_idpro, _iduser);
	end if;
    
  -- lấy tổng like
  select count(*) as `like`
  from likesanpham
  where ma_sanpham = _idpro;
end $$
delimiter ;

call sp_addlike (2, 1);

-- remove like và trả về  tổng like của sản phẩm
delimiter $$
create procedure SP_DELETELIKE (_idpro varchar(50), _iduser varchar(50))
begin
	if exists (select * from sanpham where ma_sanpham = _idpro)
	  then delete from likesanpham where ma_sanpham = _idpro and ma_khachhang = _iduser;
	end if;
    
  -- lấy tổng like
  select count(*) as `like`
  from likesanpham
  where ma_sanpham = _idpro;
end $$
delimiter ;
call sp_deletelike(2, 1);

-- get all product
delimiter $$
create procedure sp_select_product_all()
begin
	select ma_sanpham, ten_sanpham, giaban, khuyenmai, daban, ma_loai2, hinhanh, ma_chatlieu
    from sanpham;
end $$
delimiter ;
call sp_select_product_all();

-- get product on category level 0
delimiter $$
create procedure sp_select_product_style(_style int)
begin
	select ma_sanpham, ten_sanpham, giaban, khuyenmai, daban, hinhanh, daban
    from sanpham sp join loai_sp2 l2 on sp.ma_loai2 = l2.ma_loai2
                    join loai_sp1 l1 on l2.ma_loai1 = l1.ma_loai1
    where l1.ma_loai0 = _style;
end $$
delimiter ;
call sp_select_product_style(2);

select * from loai_sp2;

delimiter $$
create procedure SP_INSERT_CART(_idpro varchar(50), _iduser varchar(50), _color varchar(30), _size varchar(20), _sl int)
spinsertcartlabel:begin
	-- check
  if not exists (select * from sanpham sp join phanloaisanpham pl on sp.ma_sanpham = pl.ma_sanpham
                  where sp.ma_sanpham = _idpro and pl.mausac = _color and pl.size = _size)
    then signal sqlstate '45000' set message_text = 'product not exists';
	end if;
    
	if exists (select * from giohang
			      where ma_sanpham = _idpro and mausac = _color and size = _size and ma_khachhang = _iduser)
	then
		update giohang
    set soluong = soluong + _sl, ngaythem = NOW()
    where ma_sanpham = _idpro and mausac = _color and size = _size and ma_khachhang = _iduser;
	else
		insert into giohang (ma_sanpham, ma_khachhang, mausac, size, soluong, ngaythem)
    values (_idpro, _iduser, _color, _size, _sl, NOW());
  end if;
end $$
delimiter ;

call sp_insert_cart('1', '1', 'ĐEN', 'M', 2);
call sp_insert_cart('1', '1', 'ĐEN', 'L', 1);
call sp_insert_cart('1', '1', 'ĐEN', 'XL', 2);
call sp_insert_cart('1', '1', 'TRẮNG', 'M', 2);
call sp_insert_cart('2', '1', 'ĐEN', 'M', 2);
call sp_insert_cart('2', '1', 'ĐEN', 'L', 1);
call sp_insert_cart('2', '1', 'ĐEN', 'XL', 1);
call sp_insert_cart('2', '1', 'ĐEN', 'XXL', 2);
call sp_insert_cart('3', '1', 'TRẮNG', '1 SIZE', 1);
call sp_insert_cart('3', '1', 'ĐEN', '1 SIZE', 1);

delimiter $$
create procedure SP_DELETE_CART(_iduser varchar(50), _idpro varchar(50), _color varchar(30), _size varchar(20))
begin
	-- check cart exists
  if not exists (select * from giohang
                where ma_sanpham = _idpro and ma_khachhang = _iduser and mausac = _color and size = _size)
	  then signal sqlstate '45000' set message_text = 'cart not exists'; -- throw error
  else delete from giohang where ma_sanpham = _idpro and ma_khachhang = _iduser and mausac = _color and size = _size;
  end if;
end $$
delimiter ;
call sp_delete_cart('3', '1', 'ĐEN', '1 SIZE');

delimiter $$
create procedure SP_UPDATE_CART(_iduser varchar(50), _idpro varchar(50), _color varchar(30), _size varchar(20), _sl int)
begin
	-- check cart exists
  if not exists (select * from giohang
                where ma_sanpham = _idpro and ma_khachhang = _iduser and mausac = _color and size = _size)
	  then signal sqlstate '45000' set message_text = 'cart not exists'; -- throw error
  else update giohang
        set soluong = _sl
        where ma_sanpham = _idpro and ma_khachhang = _iduser and mausac = _color and size = _size;
  end if;
end $$
delimiter ;

delimiter $$
create procedure SP_GET_SUMPRICE_CART(_iduser varchar(50))
begin
  select sum(gh.soluong * sp.giaban * (1 - sp.khuyenmai / 100)) as tongtien
  from giohang gh join sanpham sp on gh.ma_sanpham = sp.ma_sanpham
  where gh.ma_khachhang = _iduser;
end $$
delimiter ;