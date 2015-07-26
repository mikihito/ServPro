


--drop role
drop role 
wspuser;


--drop view
drop view 
administrator_info;

--drop table
drop table customer;
drop table cust_fav;
drop table cust_belonggroup;
drop table register;
drop table category;
drop table category_havegroup;
drop table groups;
drop table groups_havecust;
drop table group_administrator;
drop table board;
drop table reply;
drop table items;
drop table item_category;
drop table maker;
drop table orders;
drop table order_details;








--create role
create role wspuser with login password 'hogehoge';



--create table

--顧客関係
create table customer(
cust_id 		text 		primary key,
cust_name 		text 		not null,
pass 			text 		not null,
img 			text 		default('AccountImg\\default.jpg'),	
cust_prof		text 		default('プロフィールを記入していません')
);

create table cust_fav(
cust_id 		text 		not null,
board_id 		integer		not null 	--primary key
);
create table cust_belonggroup(
cust_id 		text 		,
belong_group 	integer		
);

create table register(
	cust_id 		text 		not null,
	cust_name 		text 		not null,
	register_pass 	text 		not null,
	pass 			text 		not null,
	time 			timestamp	not null
);







--掲示板関係
create table category(
cate_id				integer 	primary key,
cate_name 			text 		not null
);

create table category_havegroup(
cate_id				integer 	,
group_id 			integer
);

create table groups(
group_id			serial 		primary key,
cate_id				integer 	not null,
group_name 			text 		not null,
img 				text 		not null,
group_about			text 		not null,
group_details		text
);

create table groups_havecust(
group_id 			integer 	,
belong_cust_id		text
);

create table  group_administrator(
	group_id 	integer 	primary key,
	cust_id 	text 		not null
);

create table board(
board_id		serial		primary key,
group_id		integer		not null,		
ask_cust_id		text		not null,
ask_cust_name	text		not null,
title 			text		not null,
ask_text		text		not null,			
img				text,
time			timestamp	not null,
fav_num			integer
);

create table reply(
reply_id		serial      primary key	,
board_id 		integer     not null,
rep_cust_id		text		not null,
rep_cust_name	text		not null,
reply_text		text		not null,
img				text,
time			timestamp	not null
);






--ショッピングサイト関係
create table items( 
item_id 		serial 		primary key,
cate_id 		integer		not null,
item_name		text 		not null,
item_price 		integer 	not null,	
stock			integer 	not null,
img 			text,	
maker_id 		integer,
author 			text,
item_details 	text,
time 			timestamp
);

create table item_category(
cate_id 		integer 	primary key,
cate_name 		text 		not null
);


create table maker(
maker_id 		serial 		primary key,
maker_name 		text 		not null
);

create table orders(
order_id		serial		primary key,
cust_id 		text 		not null,
total_price 	integer     not null,
time 			timestamp 	not null
);

create table order_details(
order_details_id	serial		primary key,
order_id 			integer 	not null,
item_id 			integer 	not null,
item_name 			text 		not null,
item_num			integer 	not null,
item_price 			integer 	not null,
time 				timestamp 	not null
);






--create view
create view administrator_info as
select ga.group_id,ga.group_name,cu.cust_id,cu.pass from 
(select gp.group_id,gp.group_name,ga.cust_id from groups gp 
inner join group_administrator ga using(group_id)
)  as ga  
inner join customer cu using(cust_id); 








--create role
create role wspuser with login password 'hogehoge';

--grant role
grant all on 
reply,
orders,
order_details,
board,
board_board_id_seq,
category_haveGroup,
cust_fav,
customer,
groups,
groups_group_id_seq,
groups_havecust,
item_category,
items,
items_item_id_seq,
maker,
maker_maker_id_seq,
order_details_order_details_id_seq,
orders_order_id_seq,
reply_reply_id_seq,
cust_belonggroup,
group_administrator,
administrator_info,
category,
register to wspuser;









--ダミーデータ

--顧客ダミー

insert into customer values('13fi000','電大太郎','password','img','電大太郎です。');
insert into customer values('13fi999','鯖花子','password','img','電大太郎です。');
	


--カテゴリーダミー
insert into category values(10,'TDU関連');
insert into category values(20,'学科');
insert into category values(30,'サークル');



--グループダミー

insert into group_administrator values(1,'13fi120');
insert into group_administrator values(2,'13fi120');
insert into group_administrator values(3,'13fi120');
insert into group_administrator values(4,'13fi120');
insert into group_administrator values(5,'13fi120');
insert into group_administrator values(6,'13fi120');
insert into group_administrator values(7,'13fi120');

insert into groups(group_id,cate_id,group_name,img,group_about) values(
1,10,'事務部','AccountImg/zimu.jpg','事務部です。'
);
insert into groups(group_id,cate_id,group_name,img,group_about) values(
2,10,'教員','AccountImg/kyouin.jpg','教員です。'
);


insert into groups(group_id,cate_id,group_name,img,group_about) values(
3,20,'建築学科','AccountImg/aka.jpg','建築学科は...'
);
insert into groups(group_id,cate_id,group_name,img,group_about,group_details) values(
4,20,'情報メディア学科','AccountImg/ika.jpg','現代社会における私達の生活は、コミュニケーションの形態から、<br>
	学び、遊びの形態までさまざまな情報技術によって形作られ、新たな<br>
	魅力を持った姿に変容しています。メディア学とコンピュータサイエンス<br>
	を融合し、デザイン、表現、技術などさまざまな観点から理解を深めることで、<br>
	次世代の技術を生み出していく人材を育成します。',

	'
	<br>
  <br>
  情報メディア学科2年
  <ul>
  	<li><a href="http://www.cue.im.dendai.ac.jp/~masuda/ji/gui/">GUIプログラミング</a></li>
  	<li><a href="http://www.mlab.im.dendai.ac.jp/~yamada/xml/">データ記述どXML</a></li>
  	<li><a href="https://www.mlab.im.dendai.ac.jp/~kakizaki/class/dsa/">データ構造とアルゴリズム</a></li>
  </ul>
  <br><br>

  情報メディア学科3年<br>
	<ul>
		<li><a href="http://www.cue.im.dendai.ac.jp/~masuda/ji/design/">ソフトウェア設計</a></li>
		<li><a href="https://www.mlab.im.dendai.ac.jp/~kakizaki/class/wsd/">サーバ設計論</a></li>
		<li><a href="https://www.mlab.im.dendai.ac.jp/~kakizaki/class/wsp/">サーバプログラミング演習</a></li>
	</ul>
	'
);
insert into groups(group_id,cate_id,group_name,img,group_about) values(
5,20,'ロボットメカトロニクス学科','AccountImg/rka.jpg','ロボットメカトロニクス学科は...'
);


insert into groups(group_id,cate_id,group_name,img,group_about) values(
6,30,'バスケットサークル','AccountImg/group1.jpg','ﾊﾞｽケットボールサークルです。'
);
insert into groups(group_id,cate_id,group_name,img,group_about) values(
7,30,'サッカーサークル','AccountImg/group2.jpg','サッカーサークルです。'
);




--掲示板ダミー













--商品ダミー
--教科書

insert into items(item_id,cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(1,10,'PostgreSQL入門',1800,50000,'AccountImg/text1.jpg',100,'田中',now(),'この参考書は...');
insert into items(item_id,cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(2,10,'デザインパターン入門',2800,50000,'AccountImg/text2.jpg',100,'田中',now(),'この参考書は...');
insert into items(item_id,cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(3,10,'優しいJava',3800,50000,'AccountImg/text3.jpg',100,'田中',now(),'この参考書は...');
insert into items(item_id,cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(4,10,'サーブレットJava',2200,50000,'AccountImg/text4.jpg',100,'田中',now(),'この参考書は...');
insert into items(item_id,cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(5,10,'画像処理',2500,50000,'AccountImg/text5.jpg',100,'田中',now(),'この参考書は...');









--HTML
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(100,'HTML入門',2000,2000,'AccountImg/items1_1.jpg',100,'田中',now(),'この参考書は...');
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(100,'CSS入門',2000,2000,'AccountImg/items1_2.jpg',100,'田中',now(),'この参考書はCSSを...');
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(100,'CSS応用',2000,2000,'AccountImg/items1_3.jpg',100,'田中',now(),'この参考書はCSSを...');
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(100,'HTMLとは',2000,2000,'AccountImg/items1_4.jpg',100,'田中',now(),'この参考書は...');
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(100,'CSSとは',2000,2000,'AccountImg/items1_5.jpg',100,'田中',now(),'この参考書はCSSを...');



--Java
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(110,'Javaとは',2000,2000,'AccountImg/items2_1.jpg',100,'田中',now(),'この参考書はJavaを...');
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(110,'Javaの発展',2100,2000,'AccountImg/items2_2.jpg',100,'井上',now(),'この参考書はJavaを...');
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(110,'Javaの応用',2100,2000,'AccountImg/items2_3.jpg',100,'井上',now(),'この参考書はJavaを...');
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(110,'Javaの進化',2100,2000,'AccountImg/items2_4.jpg',100,'井上',now(),'この参考書はJavaを...');


--JavaScript
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(120,'JavaScript',2100,2000,'AccountImg/items3_1.jpg',100,'井上',now(),'この参考書は...');


--JQuery
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(130,'JQuery',2100,2000,'AccountImg/items4_1.jpg',100,'井上',now(),'この参考書は...');

--JavaServlet
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(140,'JavaServlet',2100,2000,'AccountImg/items5_1.jpg',100,'井上',now(),'この参考書は...');



--Database
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(150,'JavaServlet',2100,2000,'AccountImg/items6_1.jpg',100,'井上',now(),'この参考書は...');


--Android
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(160,'Android',2100,2000,'AccountImg/items7_1.jpg',100,'井上',now(),'この参考書は...');



--Objecttive-C
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(170,'Objecttive-C',2100,2000,'AccountImg/items8_1.jpg',100,'井上',now(),'この参考書は...');



--Swift
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(180,'Swift',2100,2000,'AccountImg/items9_1.jpg',100,'井上',now(),'この参考書は...');




--C Language
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(190,'C言語',2100,2000,'AccountImg/items10_1.jpg',100,'井上',now(),'この参考書は...');






--Toeic
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(200,'TOEIC',2100,2000,'AccountImg/items11_1.jpg',100,'井上',now(),'この参考書は...');





--ITpassport
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(210,'ITパスポート',2100,2000,'AccountImg/items12_1.jpg',100,'井上',now(),'この参考書は...');



--FE

insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(220,'FE',2100,2000,'AccountImg/items13_1.jpg',100,'井上',now(),'この参考書は...');



--AP

insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(230,'AP',2100,2000,'AccountImg/items14_1.jpg',100,'井上',now(),'この参考書は...');




--IT Strategy
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(240,'ITストラテジスト',2100,2000,'AccountImg/items15_1.jpg',100,'井上',now(),'この参考書は...');



--Network
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(250,'ネットワークスペシャリスト',2100,2000,'AccountImg/items16_1.jpg',100,'井上',now(),'この参考書は...');




--system kansa
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(270,'システム監査',2100,2000,'AccountImg/items17_1.jpg',100,'井上',now(),'この参考書は...');




--LPIC
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(280,'LPIC',2100,2000,'AccountImg/items18_1.jpg',100,'井上',now(),'この参考書は...');


--CCENT,CCNA
insert into items(cate_id,item_name,item_price,stock,img,maker_id,author,time,item_details) 
	values(290,'CCENT',2100,2000,'AccountImg/items19_1.jpg',100,'井上',now(),'この参考書は...');




























--受注ダミー
--現時刻 

--10:posgre
--15:デザインパターン
--6:Java
--25:サーブレット
--10:画像処理

 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,1,'PostgreSQL入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,1,'PostgreSQL入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,1,'PostgreSQL入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,1,'PostgreSQL入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,1,'PostgreSQL入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,1,'PostgreSQL入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,1,'PostgreSQL入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,1,'PostgreSQL入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,1,'PostgreSQL入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,1,'PostgreSQL入門',1,2100,now()); 

 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,2,'デザインパターン入門',1,2100,now()); 

  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,3,'優しいJava',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,3,'優しいJava',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,3,'優しいJava',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,3,'優しいJava',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,3,'優しいJava',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,3,'優しいJava',1,2100,now()); 

  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,4,'サーブレットJava',1,2100,now()); 

  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,5,'画像処理',1,2100,now()); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,5,'画像処理',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,5,'画像処理',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,5,'画像処理',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,5,'画像処理',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,5,'画像処理',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,5,'画像処理',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,5,'画像処理',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,5,'画像処理',1,2100,now()); 
   insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(10000,5,'画像処理',1,2100,now()); 







--1分前
--6:posgre
--40:デザインパターン
--3:Java
--20:サーブレット
--1:画像処理

 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '1 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '1 minute'); 


 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '1 minute'); 


 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '1 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '1 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '1 minute'); 



 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '1 minute');



 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '1 minute'); 










--２分前
--5:posgre
--5:デザインパターン
--10:Java
--15:サーブレット
--5:画像処理


 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '2 minute'); 



 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '2 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '2 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '2 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '2 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '2 minute'); 
 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '2 minute'); 

 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '2 minute');

 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '2 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '2 minute'); 




--3分前
--60:posgre
--80:デザインパターン
--30:Java
--10:サーブレット
--20:画像処理


 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '3 minute'); 
 



 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '3 minute'); 


 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute');  
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute');  
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute');  
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute');  
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute');  
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute');  
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute');  
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute');  
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute');  
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute');  
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute');  
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute');  
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '3 minute'); 


 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '3 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '3 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '3 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '3 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '3 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '3 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '3 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '3 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '3 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '3 minute');


 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '3 minute'); 





--4分前
--49:posgre
--8:デザインパターン
--23:Java
--32:サーブレット
--18:画像処理


 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute');
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,1,'PostgreSQL入門',1,2000,current_timestamp - interval '4 minute'); 

 


 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,2,'デザインパターン入門',1,2100,current_timestamp - interval '4 minute'); 

 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
  insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,3,'優しいJava',1,2000,current_timestamp - interval '4 minute'); 



 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,4,'サーブレットJava',1,2000,current_timestamp - interval '4 minute');


 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 
 insert into order_details(order_id,item_id,item_name,item_num,item_price,time)
 values(1000,5,'画像処理',1,2000,current_timestamp - interval '4 minute'); 






