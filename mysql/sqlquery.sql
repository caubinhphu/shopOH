alter database SHOPOH character set utf16 collate utf16_general_ci;

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
  hinhanh varchar(50),
  primary key (ma_loai1),
  foreign key (ma_loai0) references loai_sp0(ma_loai0)
);
alter table loai_sp1 convert to character set utf16 collate utf16_general_ci;

insert into loai_sp1 (ten_loai1, ma_loai0)
values ('Áo thun', 1),
	     ('Áo sơ mi', 1),
       ('Áo', 2),
	     ('Chân váy', 2);

update loai_sp1
set hinhanh = 'https://robohash.org/quaeratdignissimosnesciunt.jpg?size=450x450&set=set1'
where ma_loai1 = 4;

alter table loai_sp1
change column hinhanh hinhanh varchar(100) after ma_loai0;

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
alter table sanpham add column ngaythem datetime;

update sanpham
set ngaythem = now()
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
  150000, 47, '/images/products/be88e9f1b18ee5b8a07d132752544dcf.jpg,/images/products/f25b2f5e5798c6290cda1d2f7f514ee8.jpg,/images/products/f58b1e860a91c1955da13f785646ff11.jpg,/images/products/f622fdf611f6148d604aee5f9418e34e.jpg,/images/products/538802932ade0df4c8d7948aa2f65141.jpg'),
    
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
  150000, 0, '/images/products/677b37385a048e30c6dcf560c5f23fae.jpg,/images/products/f350384d912fa95541199b1ef10992a7.jpg,/images/products/d7cc742447c07a0944507154790b0d50.jpg,/images/products/bb2bbd97543266e5154f29c3bca4d5e1.jpg,/images/products/2e53f2232a0986c2bf94fb46d1a12bd4.jpg'),

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
  68000, 49, '/images/products/36fce04f4c75dfddfd4bd6091f358ac0.jpg,/images/products/2c5592756af5362a6941f20d05adb49d.jpg,/images/products/78a91f32d178908eb610ee62da8028ed.jpg,/images/products/089e99f4b4cb1605a2ca4e962ede6348.jpg,/images/products/e1d31839df38e084e950893523706ff6.jpg');

insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem)
values ('efe0433b-e7eb-4a3e-b8cb-fff91a46832b', 'Cream - 18%', 8, 5, 2, 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 174820, 85, 'https://robohash.org/expeditarerumperferendis.jpg?size=450x450&set=set1', 69, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('d98777b1-2934-4d30-b7a0-1715d25a299b', 'Soup - Cream Of Potato / Leek', 2, 7, 1, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.

Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 80756, 5, 'https://robohash.org/ducimusrepellatdistinctio.png?size=450x450&set=set1', 20, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('7fbf5394-f883-4883-a6d4-690031c4ab2c', 'Butter Sweet', 3, 1, 1, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.

Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.

Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.

In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 248443, 24, 'https://robohash.org/adenimaut.png?size=450x450&set=set1', 46, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('e3e849b4-0b63-4324-952c-d47553a71115', 'Pastry - Key Limepoppy Seed Tea', 6, 1, 6, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.

Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.

Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.

Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 199449, 75, 'https://robohash.org/praesentiumiustoaut.png?size=450x450&set=set1', 73, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('3958f3de-dd52-4320-bf33-5bad859b8ab2', 'Oil - Sesame', 5, 2, 6, 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.', 275641, 27, 'https://robohash.org/doloressintsed.bmp?size=450x450&set=set1', 71, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('29391378-7bfa-4c6e-a81b-02074972dcd5', 'Pastry - Raisin Muffin - Mini', 2, 3, 6, 'Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.

Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.

Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 232794, 85, 'https://robohash.org/pariaturinciduntullam.bmp?size=450x450&set=set1', 35, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('840e3849-8154-4489-8ec4-1647dd24dedc', 'Cheese - Marble', 8, 7, 3, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.', 28196, 41, 'https://robohash.org/sednobissit.bmp?size=450x450&set=set1', 39, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('2e3a437d-d49b-499a-9c03-d8ea57bc0956', 'Gatorade - Cool Blue Raspberry', 1, 2, 2, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 93846, 36, 'https://robohash.org/quiaautemculpa.png?size=450x450&set=set1', 61, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('4b6fffc2-e977-413f-acc9-af20e1b0d41d', 'Pepper - Sorrano', 2, 1, 5, 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 269793, 35, 'https://robohash.org/aliasquiaassumenda.jpg?size=450x450&set=set1', 95, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('5194219f-80eb-49ad-9980-6269b5a50211', 'Mace Ground', 6, 2, 2, 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 207656, 92, 'https://robohash.org/fugautminus.png?size=450x450&set=set1', 28, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('d7b53657-241a-47b1-85d7-95edc0096353', 'Wine - Redchard Merritt', 1, 1, 1, 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 205732, 19, 'https://robohash.org/impeditmollitiainventore.jpg?size=450x450&set=set1', 10, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('630977e4-256f-4709-9ec2-d6db599d1c5b', 'Beans - Black Bean, Canned', 8, 2, 1, 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 136013, 2, 'https://robohash.org/corporisdoloresdistinctio.jpg?size=450x450&set=set1', 91, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('273fc3e7-374d-4493-8afc-e2ed85141417', 'Noodles - Cellophane, Thin', 2, 6, 2, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.

Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 174807, 46, 'https://robohash.org/molestiaesedquisquam.jpg?size=450x450&set=set1', 3, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('0b3b64b5-0b4a-4784-a825-9d0d4f8ea2b0', 'Flour - Fast / Rapid', 2, 4, 1, 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 83855, 53, 'https://robohash.org/voluptatemoptionon.bmp?size=450x450&set=set1', 11, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('a518d356-54aa-4475-bfcf-f19d982f27f4', 'Chicken - Leg, Fresh', 3, 6, 3, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.

Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.

Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.

In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 114259, 30, 'https://robohash.org/quiexpeditavitae.jpg?size=450x450&set=set1', 69, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('467924ac-5e27-4069-b89f-a1aba2b707ea', 'Beef - Top Sirloin', 7, 4, 5, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 25814, 30, 'https://robohash.org/voluptateipsumreprehenderit.jpg?size=450x450&set=set1', 44, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('5548239f-42dd-49a6-bec5-ee9442e7e3d6', 'Chef Hat 25cm', 1, 7, 2, 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.

Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.

Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.

Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.

Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 117899, 71, 'https://robohash.org/laborumquaeratincidunt.png?size=450x450&set=set1', 89, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('625c4f57-a717-4676-ad37-c2878e0bcf9b', 'Pastry - Mini French Pastries', 2, 5, 6, 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', 166726, 16, 'https://robohash.org/repellatsuntea.bmp?size=450x450&set=set1', 0, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('a8f60839-5f3c-4fd0-895a-5d0783ec7d1e', 'Brocolinni - Gaylan, Chinese', 8, 4, 6, 'In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.

Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 140500, 4, 'https://robohash.org/cupiditateadvoluptatem.png?size=450x450&set=set1', 50, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('d4579e17-40ee-4a34-b504-7886a0030895', 'Cheese - Brie,danish', 7, 6, 3, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.

Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 105850, 33, 'https://robohash.org/dolorumdebitiseaque.jpg?size=450x450&set=set1', 71, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('e916946c-76cb-430f-af6a-b5721072be2e', 'Chef Hat 20cm', 1, 4, 1, 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.

Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 126892, 88, 'https://robohash.org/nonadducimus.jpg?size=450x450&set=set1', 62, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('b46dbd5d-c718-45a5-a6cf-ec7cca63aa1f', 'Tart - Pecan Butter Squares', 1, 5, 6, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.

Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.', 38291, 84, 'https://robohash.org/inoccaecatidicta.bmp?size=450x450&set=set1', 58, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('b16075db-affa-4919-8fe4-bf4289d7005e', 'Apricots - Dried', 5, 2, 2, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.

In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 113190, 68, 'https://robohash.org/eaesseconsequatur.bmp?size=450x450&set=set1', 60, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('5f9816a5-2886-4877-8576-2ef4e77fd929', 'Rice - Wild', 8, 2, 6, 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.

Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 263564, 42, 'https://robohash.org/autbeataepariatur.bmp?size=450x450&set=set1', 64, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('a205acc7-69be-4b3b-a698-d0b7400826b4', 'Yeast Dry - Fleischman', 5, 1, 5, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 30893, 76, 'https://robohash.org/nullavoluptatemhic.jpg?size=450x450&set=set1', 68, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('8af8fa80-6b62-41f0-8e30-5947b84432bd', 'Juice - Clam, 46 Oz', 6, 5, 2, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.

Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.

Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', 111880, 40, 'https://robohash.org/consequaturestab.jpg?size=450x450&set=set1', 63, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('4dee8bdc-f3b7-4a37-a39e-ec2c6889e84d', 'Nut - Pecan, Pieces', 8, 3, 2, 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.

Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 126240, 30, 'https://robohash.org/etlaborumdeserunt.bmp?size=450x450&set=set1', 38, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('c6bd07d4-2de9-4372-9418-49e086bebd9b', 'Mousse - Mango', 4, 3, 1, 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.

Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 142631, 44, 'https://robohash.org/temporatotamdicta.jpg?size=450x450&set=set1', 51, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('ba2468bf-c3b7-4bbd-8b3c-50c7748da8ef', 'Creme De Cacao Mcguines', 7, 6, 2, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 181238, 77, 'https://robohash.org/voluptatemculpaoccaecati.jpg?size=450x450&set=set1', 45, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('e2b9482f-6374-4dc0-a1b6-8c771da9ede4', 'Oil - Shortening - All - Purpose', 2, 1, 6, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 98350, 67, 'https://robohash.org/temporibusfugitofficia.bmp?size=450x450&set=set1', 54, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('1d92faa5-6922-4c8b-a7c9-0ee0ba13d9ff', 'Mayonnaise', 2, 1, 6, 'In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.

Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.

Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 273663, 6, 'https://robohash.org/dolorererumtempora.png?size=450x450&set=set1', 42, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('fab46ddf-0625-47fe-89ff-82b6f16ee417', 'Chinese Foods - Plain Fried Rice', 7, 3, 2, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 169291, 52, 'https://robohash.org/estofficiisquos.bmp?size=450x450&set=set1', 80, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('b6ba19af-1aa8-4749-8f81-7ee89020531d', 'Amarula Cream', 6, 5, 4, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.

In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 100304, 44, 'https://robohash.org/praesentiumerrorquo.bmp?size=450x450&set=set1', 99, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('a4ee9432-d4db-42f1-b4ce-a9a3b8dda97e', 'Beef - Ground Medium', 8, 7, 2, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.

Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 27435, 98, 'https://robohash.org/illofugitquia.png?size=450x450&set=set1', 48, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('96ee263f-3fcb-4222-9e95-763529e0c17a', 'Bread Base - Gold Formel', 7, 5, 2, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.

Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.

Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.

Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 95920, 83, 'https://robohash.org/autetmagni.jpg?size=450x450&set=set1', 56, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('9a67196e-e501-4466-890f-0b8c3e63722d', 'Cleaner - Comet', 1, 4, 6, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.

Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.

Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 171623, 43, 'https://robohash.org/accusantiumsuntet.bmp?size=450x450&set=set1', 87, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('1909dca9-c9f8-4619-b5c6-f7d3ce6f600b', 'Sausage - Chorizo', 7, 7, 5, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 157769, 78, 'https://robohash.org/dolorequiaexplicabo.jpg?size=450x450&set=set1', 10, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('343a4f05-1b51-40b4-8a26-d96928629bfd', 'Sponge Cake Mix - Vanilla', 7, 7, 3, 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 279461, 31, 'https://robohash.org/isteinventoreexercitationem.png?size=450x450&set=set1', 89, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('7e57bf34-be0c-4ff4-bb30-a4dedcf2afa2', 'Bar Energy Chocchip', 2, 6, 3, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.', 151284, 20, 'https://robohash.org/architectovoluptatemut.bmp?size=450x450&set=set1', 53, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('29587625-fb75-4f8e-89ea-b964ad44a558', 'Yogurt - Assorted Pack', 8, 1, 4, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 110395, 13, 'https://robohash.org/quisvoluptasipsa.bmp?size=450x450&set=set1', 24, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('766ae0ae-379b-43cd-863a-a7cd75077df7', 'Container - Clear 16 Oz', 1, 6, 3, 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 297149, 74, 'https://robohash.org/estcumqueomnis.jpg?size=450x450&set=set1', 25, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('5a69a9e9-61df-474c-852b-7c63a4be51c8', 'Chicken - Leg / Back Attach', 6, 4, 1, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.', 113420, 92, 'https://robohash.org/utundeperferendis.bmp?size=450x450&set=set1', 45, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('5be6aed7-635d-4cf5-99c9-40f482920c24', 'Pepper - Chili Powder', 3, 2, 4, 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 234267, 30, 'https://robohash.org/delenitiidvoluptatibus.png?size=450x450&set=set1', 64, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('784139a0-aa0b-4a5a-92e0-3924e287037a', 'Sun - Dried Tomatoes', 2, 4, 4, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.

Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 288324, 29, 'https://robohash.org/minusetveniam.png?size=450x450&set=set1', 75, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('69e2e764-9936-461b-bad2-78532a772965', 'Olives - Morracan Dired', 4, 7, 3, 'Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.

Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.

Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 85757, 74, 'https://robohash.org/sedipsaplaceat.png?size=450x450&set=set1', 11, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('3970546c-3761-40b3-b294-2bde61e43ab4', 'Anchovy In Oil', 4, 4, 1, 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 24743, 7, 'https://robohash.org/deseruntrationedolor.jpg?size=450x450&set=set1', 95, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('18be8e22-8464-4ca9-ba3d-17e9e36dbbd1', 'Cheese Cloth No 100', 7, 3, 3, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 231288, 42, 'https://robohash.org/rerummolestiaedoloribus.png?size=450x450&set=set1', 69, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('be5bdc8a-642f-42f7-9722-480a06eafcfd', 'Puff Pastry - Sheets', 6, 6, 4, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.

Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 193724, 88, 'https://robohash.org/culpaquosint.bmp?size=450x450&set=set1', 54, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('2b5550fc-d1c0-46db-8053-9b8ba4a84af4', 'Squash - Butternut', 6, 1, 5, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 71235, 23, 'https://robohash.org/praesentiumfugaea.jpg?size=450x450&set=set1', 14, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('a2b64a84-5a92-4f43-b72e-c721906cf61b', 'Kellogs Cereal In A Cup', 4, 5, 5, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', 207508, 12, 'https://robohash.org/nihilremnesciunt.bmp?size=450x450&set=set1', 87, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('8eea69d8-431d-45b8-ab5f-682d7c4ee88e', 'Sauce - Bernaise, Mix', 7, 1, 6, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 55615, 70, 'https://robohash.org/insuntad.png?size=450x450&set=set1', 45, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('709229e3-39e0-4bee-ab36-9bb3a282cc9c', 'Bread - Multigrain, Loaf', 3, 4, 5, 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 172155, 77, 'https://robohash.org/quibeataeab.bmp?size=450x450&set=set1', 0, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('7d15e0d6-8d92-4728-bdc7-8b270ffe42ee', 'Cream - 18%', 4, 4, 4, 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.

Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 62305, 7, 'https://robohash.org/sitenimiure.png?size=450x450&set=set1', 85, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('29660332-2295-4af4-a973-37d9d0e65d49', 'Carbonated Water - Blackcherry', 5, 4, 3, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 198772, 7, 'https://robohash.org/rerumcorporisest.bmp?size=450x450&set=set1', 55, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('f491c5e7-746d-4e60-b9d2-384a55b6387e', 'Beef - Ox Tongue, Pickled', 7, 4, 3, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.

Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.

Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 176378, 19, 'https://robohash.org/blanditiisametnemo.bmp?size=450x450&set=set1', 4, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('1cef4f71-9b91-4655-9778-2f1cecc0c94d', 'Lobster - Canned Premium', 4, 2, 5, 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 175255, 54, 'https://robohash.org/quasivoluptasaut.png?size=450x450&set=set1', 89, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('c2b2326e-d283-455d-9001-3960451a9803', 'Salmon Steak - Cohoe 6 Oz', 5, 3, 3, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.

Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 67582, 28, 'https://robohash.org/dictasolutamolestias.jpg?size=450x450&set=set1', 71, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('3b14df00-a1a7-456a-81ff-814698648c0e', 'Wine - Red, Gallo, Merlot', 8, 5, 4, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.

In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', 99277, 28, 'https://robohash.org/magnamhicquis.bmp?size=450x450&set=set1', 22, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('943d22f9-a628-42cc-a600-a032136570e8', 'Appetizer - Lobster Phyllo Roll', 1, 4, 4, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 155127, 31, 'https://robohash.org/laboreetaccusantium.bmp?size=450x450&set=set1', 96, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('4e8cd916-e48f-435b-a88c-6ccae4a0cd5b', 'Pasta - Fusili Tri - Coloured', 2, 4, 6, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.

Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', 211099, 42, 'https://robohash.org/officiisperspiciatisut.bmp?size=450x450&set=set1', 42, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('4aa65dc6-807f-4640-abca-588b15921454', 'Mints - Striped Red', 7, 4, 1, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 152635, 50, 'https://robohash.org/sedpossimusvoluptatem.jpg?size=450x450&set=set1', 51, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('21aceef8-ea0e-4e14-9e45-a991c1696d4d', 'Wine - Black Tower Qr', 3, 7, 2, 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 53168, 26, 'https://robohash.org/quivoluptaset.png?size=450x450&set=set1', 32, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('74414abc-ffff-4525-82ba-b706889b71e0', 'Tequila Rose Cream Liquor', 1, 1, 6, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 142019, 48, 'https://robohash.org/utnisisuscipit.jpg?size=450x450&set=set1', 43, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('d28e421b-6b14-4824-ae08-aa6814caf4fe', 'Wine - Soave Folonari', 3, 5, 4, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 185289, 65, 'https://robohash.org/atfugaminima.bmp?size=450x450&set=set1', 26, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('d9cf5f2e-df0b-4012-a38f-2509146d183e', 'Mustard - Dijon', 4, 6, 4, 'In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.

Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.

Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 289887, 58, 'https://robohash.org/ipsumidatque.png?size=450x450&set=set1', 3, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('01be4996-3fa4-450a-9348-9e018ddeab66', 'Sambuca - Ramazzotti', 1, 2, 6, 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 139996, 96, 'https://robohash.org/voluptatemteneturvel.bmp?size=450x450&set=set1', 21, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('d2190ece-e785-4122-8c95-6907fe5e9048', 'Towel Dispenser', 4, 4, 2, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 251924, 27, 'https://robohash.org/quiliberoeos.bmp?size=450x450&set=set1', 12, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('70e75e55-38f3-4d21-99d9-780adf1de3e0', 'Mountain Dew', 1, 4, 6, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.

In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 124512, 62, 'https://robohash.org/deseruntmodierror.png?size=450x450&set=set1', 51, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('713495a5-3037-4151-9ce2-c38044c75719', 'Wine - Chateau Aqueria Tavel', 6, 6, 5, 'Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.

Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.', 283201, 86, 'https://robohash.org/veroiurelabore.png?size=450x450&set=set1', 1, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('c39bd49e-ef64-4043-a527-d07d4732d0db', 'Spice - Greek 1 Step', 5, 4, 1, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 126263, 12, 'https://robohash.org/exercitationemquifuga.bmp?size=450x450&set=set1', 24, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('9a4cc949-2022-4fde-ba42-20da90b5c864', 'Wine - Coteaux Du Tricastin Ac', 6, 7, 6, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 191368, 0, 'https://robohash.org/eosvelillum.bmp?size=450x450&set=set1', 64, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('098f45dc-475a-4840-b189-aca4bfd79d0b', 'Coffee Cup 8oz 5338cd', 3, 4, 3, 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.

Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.', 160022, 67, 'https://robohash.org/autemlaborumexcepturi.bmp?size=450x450&set=set1', 33, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('a446b64e-6987-4708-9c26-73d69ab782cc', 'Turkey Leg With Drum And Thigh', 5, 3, 4, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 56521, 74, 'https://robohash.org/voluptatummaximeeaque.jpg?size=450x450&set=set1', 8, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('6b3d2d38-6d11-4440-8f28-ffa2f1b5a00c', 'Sun - Dried Tomatoes', 6, 3, 1, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.

Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.

Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.

Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 253267, 31, 'https://robohash.org/perferendisquisquamexplicabo.png?size=450x450&set=set1', 55, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('6e10e8b4-1b89-4900-b8b0-9e9d42c04ed2', 'Trueblue - Blueberry Cranberry', 6, 1, 6, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.', 264621, 71, 'https://robohash.org/namestullam.bmp?size=450x450&set=set1', 64, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('37a48e70-b9d3-405a-b94f-6f974c7860ab', 'Tart Shells - Barquettes, Savory', 8, 7, 1, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 138370, 68, 'https://robohash.org/temporibusrepellendusassumenda.jpg?size=450x450&set=set1', 39, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('020cec33-b7d5-4ff6-8d49-6706443f7677', 'Chicken - Base, Ultimate', 8, 4, 2, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 49995, 8, 'https://robohash.org/iureomnisdebitis.png?size=450x450&set=set1', 35, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('99d17467-a725-4d51-bb0d-b8372c7554bd', 'Cookie Dough - Peanut Butter', 6, 1, 3, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.

Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.

Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 192180, 69, 'https://robohash.org/sitmolestiaenostrum.bmp?size=450x450&set=set1', 100, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('097dde91-cfba-481d-b134-4bea9629d825', 'Cheese - Augre Des Champs', 8, 3, 4, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 260942, 84, 'https://robohash.org/voluptatibusomniscorrupti.jpg?size=450x450&set=set1', 28, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('87aba194-82cc-4893-a445-e54d5c470d20', 'Beer - Corona', 5, 6, 6, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.

In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 199660, 5, 'https://robohash.org/enimrerumimpedit.png?size=450x450&set=set1', 78, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('09bfca2c-f05f-43d1-bb39-1e6437edf3fe', 'Chinese Foods - Pepper Beef', 7, 1, 1, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.', 286323, 6, 'https://robohash.org/doloribusquiaitaque.png?size=450x450&set=set1', 51, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('53948b41-1892-4de6-8e3f-930e0fff5df0', 'Onions - Pearl', 5, 4, 2, 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.

Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 113896, 69, 'https://robohash.org/ipsumvoluptasneque.png?size=450x450&set=set1', 23, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('7ce0932e-30d1-489f-92df-5db30f1329bd', 'Sauce - Bernaise, Mix', 5, 6, 1, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 63195, 32, 'https://robohash.org/itaquemodidistinctio.jpg?size=450x450&set=set1', 37, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('8e5c5633-f780-4f67-a9ab-66097fd954d9', 'Raspberries - Fresh', 7, 1, 3, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.

Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.

Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.

Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 76181, 85, 'https://robohash.org/voluptasautemqui.bmp?size=450x450&set=set1', 41, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('504963a4-dbfd-4305-a821-b81495f5866b', 'Pail - 4l White, With Handle', 1, 6, 1, 'In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.

Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.

Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 143193, 68, 'https://robohash.org/molestiaeliberoenim.jpg?size=450x450&set=set1', 80, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('a1e124d7-87bb-45c6-9a71-56a1eec90b62', 'Bread - Raisin Walnut Oval', 6, 6, 4, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.

Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 299215, 39, 'https://robohash.org/animiodiorepellat.bmp?size=450x450&set=set1', 39, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('6799f443-4ff1-4d5e-88e7-4810a37bbfe8', 'Coffee - Colombian, Portioned', 6, 7, 4, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.', 102566, 38, 'https://robohash.org/iurevitaequi.jpg?size=450x450&set=set1', 42, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('8277cce0-0ed5-4817-a125-8c4ba01fc612', 'Rootbeer', 1, 5, 6, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.

Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.

Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.

In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 175841, 12, 'https://robohash.org/porrovitaemolestias.jpg?size=450x450&set=set1', 95, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('3eb6982f-ce2a-4df0-915b-66b589290093', 'Squid - Tubes / Tenticles 10/20', 4, 4, 2, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.

Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.

In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 239258, 69, 'https://robohash.org/placeateumnobis.jpg?size=450x450&set=set1', 43, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('d6a06ed7-2587-463e-be03-79d87232ed5d', 'Hummus - Spread', 6, 1, 3, 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 199890, 67, 'https://robohash.org/quaeratdignissimosnesciunt.jpg?size=450x450&set=set1', 96, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('55a85770-0ffc-4e5e-b30e-8c2a0d74e1e8', 'Coffee - Egg Nog Capuccino', 1, 5, 5, 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 131739, 87, 'https://robohash.org/autemhicveniam.png?size=450x450&set=set1', 24, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('ccc14620-50f5-48e0-a633-dcc7c8a8ea25', 'Truffle Cups - Red', 1, 7, 5, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 255465, 13, 'https://robohash.org/avelodio.jpg?size=450x450&set=set1', 8, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('1278f214-f7fe-418f-a4be-33f658302472', 'Soap - Hand Soap', 4, 2, 3, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 198072, 73, 'https://robohash.org/hicsolutaaliquam.bmp?size=450x450&set=set1', 11, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('0758145f-2213-4c06-aa7a-f1bae66930da', 'Pastry - Cherry Danish - Mini', 2, 3, 6, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 68029, 100, 'https://robohash.org/exercitationemutdolores.bmp?size=450x450&set=set1', 46, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('924e3dac-79da-49b5-bf33-9c83973d1869', 'Quail - Eggs, Fresh', 6, 1, 1, 'In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.

Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.

Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 250575, 41, 'https://robohash.org/fugitofficiaplaceat.jpg?size=450x450&set=set1', 91, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('2e8f8e8f-8826-41f4-8b3a-e01f7550e031', 'Wine - Fino Tio Pepe Gonzalez', 6, 6, 3, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', 101148, 44, 'https://robohash.org/temporeomnisnihil.png?size=450x450&set=set1', 17, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('f6fde233-a3de-44bd-a559-4c9d26abb68c', 'Wood Chips - Regular', 7, 7, 6, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 39000, 78, 'https://robohash.org/quimagnamharum.jpg?size=450x450&set=set1', 100, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('873c7dc6-d2e2-49cc-99dd-2186a689257d', 'Sour Cream', 6, 4, 4, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 190302, 31, 'https://robohash.org/sedexqui.jpg?size=450x450&set=set1', 17, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('a7dd2836-a6ce-4035-be9d-1ebad989d749', 'Shrimp - 150 - 250', 6, 3, 2, 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.

In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 83012, 83, 'https://robohash.org/fugiatquaesint.jpg?size=450x450&set=set1', 0, now());
insert into sanpham (ma_sanpham, ten_sanpham, ma_loai2, ma_thuonghieu, ma_chatlieu, mota, giaban, khuyenmai, hinhanh, daban, ngaythem) values ('58c9dd4e-fb4a-409c-8430-aa6af4f67549', 'Guava', 3, 1, 2, 'Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.

Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.

Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 108613, 98, 'https://robohash.org/etisteillo.bmp?size=450x450&set=set1', 62, now());



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

insert into phanloaisanpham(ma_sanpham, mausac, size, soluongton)
select ma_sanpham, 'XANH', 'L', 44
from sanpham


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
alter table khachhang add column gioitinh varchar(10);
alter table khachhang add column ngaysinh date;
alter table khachhang
change column avatar avatar varchar(50) after dienthoai;


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
alter table diachikhachhang
change column macdinh macdinh boolean default false after `sonha/duong`;

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

drop procedure SP_SELECT_PRODUCT_SUGGESTION;
-- lấy sản phẩm gợi ý index
delimiter $$
create procedure SP_SELECT_PRODUCT_SUGGESTION()
begin
	select ma_sanpham, ten_sanpham, giaban, khuyenmai, daban, ma_loai2, hinhanh, ma_chatlieu
  from sanpham
  order by ngaythem desc
  limit 24;
end $$
delimiter ;
call SP_SELECT_PRODUCT_SUGGESTION();

drop procedure SP_SELECT_CART;
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
  order by gh.ngaythem desc;
end $$
delimiter ;
call sp_select_cart(1);

-- lấy sản phẩm chính kèm các sản phẩm cùng loại
drop procedure SP_SELECT_SAMEPRODUCT;
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
  order by daban desc;
end $$
delimiter ;

call SP_SELECT_SAMEPRODUCT(1, 3, 6);

drop procedure SP_SELECT_PRODUCT;
-- lấy thông tin sản phẩm
delimiter $$
create procedure SP_SELECT_PRODUCT(_idpro varchar(50), _iduser varchar(50))
begin
	-- lấy thông tin sản phẩm
	select sp.*, cl.ten_chatlieu, th.ten_thuonghieu, l0.ma_loai0, l0.ten_loai0, l1.ma_loai1, l1.ten_loai1,
        l2.ma_loai2, l2.ten_loai2
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

drop procedure sp_select_product_all;
-- get all product
delimiter $$
create procedure sp_select_product_all(_offset int, _linmit int)
begin
	select ma_sanpham, ten_sanpham, giaban, khuyenmai, daban, ma_loai2, hinhanh, ma_chatlieu
  from sanpham
  order by ngaythem desc
  limit _offset, _linmit;

  -- select sum product
  select count(ma_sanpham) as tong
  from sanpham;
end $$
delimiter ;
call sp_select_product_all();

drop procedure SP_SELECT_PRODUCT_STYLE;
-- get product on category level 0
delimiter $$
create procedure SP_SELECT_PRODUCT_STYLE(_style int, _offset int, _limit int)
begin
  -- Lấy danh sách sản phẩm
	select ma_sanpham, ten_sanpham, giaban, khuyenmai, daban, sp.hinhanh
  from sanpham sp join loai_sp2 l2 on sp.ma_loai2 = l2.ma_loai2
                  join loai_sp1 l1 on l2.ma_loai1 = l1.ma_loai1
  where l1.ma_loai0 = _style
  order by ngaythem desc
  limit _offset, _limit;

  -- Get sum product satisfy condition
  select count(ma_sanpham) as tong
  from sanpham sp join loai_sp2 l2 on sp.ma_loai2 = l2.ma_loai2
                  join loai_sp1 l1 on l2.ma_loai1 = l1.ma_loai1
  where l1.ma_loai0 = _style;
end $$
delimiter ;
call sp_select_product_style(2);

-- get filter list
delimiter $$
drop procedure SP_SELECT_FILTER_LIST
create procedure SP_SELECT_FILTER_LIST(_style int, _style1 int)
begin
    -- Lấy category1 list từ categody0
    select ma_loai1, ten_loai1, hinhanh
    from loai_sp1
    where ma_loai0 = _style;

    -- Lấy material thuộc category0
    select ma_chatlieu, ten_chatlieu
    from chatlieu;

    --  Lấy category2 từ category1
    select ma_loai2, ten_loai2
    from loai_sp2
    where ma_loai1 = _style1;
end $$
delimiter ;

select * from sanpham;

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

delimiter $$
drop procedure SP_SEARCH_STYLE;
create procedure SP_SEARCH_STYLE(
  _loai0 int, _loai1 varchar(255), _loai2 varchar(255), _material varchar(255),
  _minRange int, _maxRange int, _sortby varchar(50)
)
begin
  set @sql = concat(
    'select sp.ma_sanpham, sp.ten_sanpham, sp.giaban, sp.khuyenmai, sp.daban, sp.hinhanh, l1.ten_loai1, l0.ten_loai0
    from sanpham sp join chatlieu cl on sp.ma_chatlieu = cl.ma_chatlieu
                    join loai_sp2 l2 on sp.ma_loai2 = l2.ma_loai2
                    join loai_sp1 l1 on l2.ma_loai1 = l1.ma_loai1
                    join loai_sp0 l0 on l1.ma_loai0 = l0.ma_loai0
    where l0.ma_loai0 = ', _loai0, ' and (l1.ma_loai1 in (', _loai1, ') or \'', _loai1, '\' = \'-1\')',
      ' and (l2.ma_loai2 in (', _loai2, ') or \'', _loai2, '\' = \'-1\')',
      ' and (cl.ma_chatlieu in (', _material, ') or \'', _material, '\' = \'-1\')',
      ' and ((sp.giaban * (1 - sp.khuyenmai / 100)) >= ', _minRange, ' or ', _minRange, ' = 0)',
      ' and ((sp.giaban * (1 - sp.khuyenmai / 100)) <= ', _maxRange, ' or ', _maxRange, ' = 0)',
    ' order by ', _sortby, ';'
  );
  prepare stmt from @sql;
  execute stmt;
  deallocate prepare stmt;
end $$
delimiter ;

call SP_SEARCH_STYLE(1, '-1', '-1', '-1', 0, 0, '(sp.giaban * (1 - sp.khuyenmai / 100)) desc');


select ma_loai2 from sanpham;

delimiter $$
create procedure SP_SELECT_PRODCUT_FOR_SEARCH()
begin
  select sp.ma_sanpham, sp.ten_sanpham, sp.giaban, sp.khuyenmai, sp.daban, sp.hinhanh,
        th.ten_thuonghieu, cl.ten_chatlieu, l2.ten_loai2, l1.ten_loai1, l0.ten_loai0
  from sanpham sp join thuonghieu th on sp.ma_thuonghieu = th.ma_thuonghieu
                  join chatlieu cl on sp.ma_chatlieu = cl.ma_chatlieu
                  join loai_sp2 l2 on sp.ma_loai2 = l2.ma_loai2
                  join loai_sp1 l1 on l2.ma_loai1 = l1.ma_loai1
                  join loai_sp0 l0 on l1.ma_loai0 = l0.ma_loai0
  order by ngaythem desc;
end $$
delimiter ;

call SP_SELECT_PRODCUT_FOR_SEARCH();

drop procedure CHECK_ACCOUNT;
-- check account exists
delimiter $$
create procedure CHECK_ACCOUNT(_account varchar(50))
begin
  select * from khachhang where taikhoan = _account;
end $$
delimiter ;

call CHECK_ACCOUNT('\' or 1 = 1;--');
select * from khachhang where taikhoan = '1' or 1 = 1;--;


delimiter $$
create procedure CHECK_ACCOUNT_ID(_idUser varchar(50))
begin
  select * from khachhang where ma_khachhang = _idUser;
end $$
delimiter ;

update khachhang
set matkhau = '$2b$10$oz7iLbheWh2OURXtEz0EOOxwfZJDf/80OGy1I/ym8gqLFsb3/AoXe'
where taikhoan = 'caubinhphu'

select * from khachhang;

drop procedure MODIFY_LIKE;
delimiter $$
create procedure MODIFY_LIKE(_idpro varchar(50), _iduser varchar(50))
begin
  if exists (select * from likesanpham where ma_khachhang = _iduser and ma_sanpham = _idpro)
  then delete from likesanpham
        where ma_khachhang = _iduser and ma_sanpham = _idpro;
  else insert into likesanpham (ma_khachhang, ma_sanpham)
        values (_iduser, _idpro);
  end if;

  -- lấy tổng like
  select count(*) as `like`
  from likesanpham
  where ma_sanpham = _idpro;
end $$
delimiter ;

drop procedure ADD_USER;
delimiter $$
create procedure ADD_USER(_iduser varchar(50), _account varchar(50), _password varchar(100))
begin
  insert into khachhang (ma_khachhang, taikhoan, matkhau, avatar)
  values (_iduser, _account, _password, '/images/users/default-avatar.jpg');
end $$
delimiter ;

update khachhang
set avatar = '/images/users/default-avatar.jpg';

drop procedure UPDATE_PROFILE;
delimiter $$
create procedure UPDATE_PROFILE(_iduser varchar(50), _username varchar(100), _gender varchar(10), _birthday varchar(50), _phone varchar(20))
begin
  update khachhang
  set ten_khachhang = _username
  where ma_khachhang = _iduser;

  update khachhang
  set dienthoai = _phone
  where ma_khachhang = _iduser;

  if _gender != ''
    then update khachhang
        set gioitinh = _gender
        where ma_khachhang = _iduser;
  end if;

  if _birthday != ''
    then update khachhang
        set ngaysinh = _birthday
        where ma_khachhang = _iduser;
  end if;
end $$
delimiter ;

update khachhang
set ngaysinh = ''
where ma_khachhang = '1';

select * from khachhang;


drop procedure UPDATE_AVATAR;
delimiter $$
create procedure UPDATE_AVATAR(_iduser varchar(50), _avatar varchar(50))
begin
  select avatar from khachhang where ma_khachhang = _iduser;

  update khachhang
  set avatar = _avatar
  where ma_khachhang = _iduser;
end $$
delimiter ;

drop procedure UPDATE_PASSWORD;
delimiter $$
create procedure UPDATE_PASSWORD(_iduser varchar(50), _password varchar(100))
begin
  update khachhang
  set matkhau = _password
  where ma_khachhang = _iduser;
end $$
delimiter ;

select * from diachikhachhang;

drop procedure ADD_ADDRESS;
delimiter $$
create procedure ADD_ADDRESS(
  _iduser varchar(50), _ten varchar(100), _sdt varchar(20),
  _tinh varchar(100), _huyen varchar(100), _xa varchar(100), _duong varchar(100)
)
begin
  insert into diachikhachhang (
    ma_khachhang, ten, dienthoai, `tinh/thanhpho`, `quan/huyen`,`phuong/xa`, `sonha/duong`
  ) values (_iduser, _ten, _sdt, _tinh, _huyen, _xa, _duong);

  -- if user only have one address => set this address into default address
  if (select count(*) from diachikhachhang where ma_khachhang = _iduser) = 1
    then update diachikhachhang set macdinh = true where ma_khachhang = _iduser;
  end if;
end $$
delimiter ;

`tinh/thanhpho` varchar(100),
	`quan/huyen` varchar(100),
  `phuong/xa` varchar(100),
  `sonha/duong` varchar(100),
  macdinh bit default false,

call ADD_ADDRESS('1', 'asf', 'asdf', 'asdf', 'asdf', 'asdf', 'afasdfas');

delete from diachikhachhang;

drop procedure SELECT_ADDRESS;
delimiter $$
create procedure SELECT_ADDRESS(_iduser varchar(50))
begin
  select * from diachikhachhang where ma_khachhang = _iduser;
end $$
delimiter 