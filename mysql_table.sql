#1.建立一資料表名為食物(food)，有編號、名稱、到期日、產地編號、價格、種類六個欄位，分別定義如下：id(char(5),PK), name(varchar(30)), expiredate(datetime), placeid(char(2)), price(int unsigned), catalog(varchar(20))
create table food(
id char(5) primary key,
name varchar(30) not null,
expiredate datetime not null,
placeid char(2) not null,
price int unsigned not null,
catalog varchar(20) not null
);

#2.建立一資料表名為產地(place)，有編號、名稱兩個欄位，分別定義如下：id(char(2),PK), name(varchar(20))

create table place(
id char(2) primary key,
name varchar(20) not null
);

#3.利用複製表格結構的方式複製food產生一個新的表格名為food1
create table food1 like food;

#4.利用food1新增、修改、重新命名和刪除一個欄位
alter table food1 add(a int);   
alter table  food1 modify a varchar(10);
alter table food1 change a b varchar(10);
alter table food1 drop b;

#5.將food1重新命名為food2
alter table food1 rename food2;

#6.刪除food2資料表
drop table food2;   