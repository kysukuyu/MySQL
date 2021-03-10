INSERT INTO food VALUES ('CK001', '曲奇餅乾', '2018/01/10', 'TL', 250, '點心');
INSERT INTO food VALUES ('CK002', '蘇打餅乾', '2017/10/12', 'TW', 80, '點心');
INSERT INTO food VALUES ('DK001', '高山茶', '2018/05/23', 'TW', 780, '飲料');
INSERT INTO food VALUES ('DK002', '綠茶', '2017/06/11', 'JP', 530, '飲料');
INSERT INTO food VALUES ('OL001', '苦茶油', '2019/03/16', 'TW', 360, '調味品');
INSERT INTO food VALUES ('OL002', '橄欖油', '2018/07/25', 'TL', 420, '調味品');
INSERT INTO food VALUES ('CK003', '仙貝', '2017/11/01', 'JP', 270, '點心');
INSERT INTO food VALUES ('SG001', '醬油', '2019/05/05', 'JP', 260, '調味品');
INSERT INTO food VALUES ('OL003', '葡萄子油', '2019/05/05', 'JP', 550, '調味品');
INSERT INTO food VALUES ('CK004', '鳳梨酥', '2017/10/12', 'TW', 340, '點心');
INSERT INTO food VALUES ('CK005', '太陽餅', '2017/08/27', 'TW', 150, '點心');
INSERT INTO food VALUES ('DK003', '紅茶', '2019/11/12', 'TL', 260, '飲料');
INSERT INTO food VALUES ('SG002', '醋', '2018/09/18', 'TW', 60, '調味品');


INSERT INTO place VALUES ('TW', '台灣');
INSERT INTO place VALUES ('JP', '日本');
INSERT INTO place VALUES ('TL', '泰國');
INSERT INTO place VALUES ('US', '美國');


#1.	查詢所有食物表格中所有欄位的資料
select*from food;
#2.	查詢所有食物名稱、到期日和價格
select name,expiredate,price from food;
#3.查詢所有食物名稱、到期日和價格，並將表頭重新命為'名稱'、'到期日'和'價格'
select name as'名稱' , expiredate as'到期日' , price as '價格' from food;
#4.查詢所有食物的種類有哪些？(重覆的資料只顯示一次)
select distinct catalog  from food;
#5.查詢所有食物名稱和種類，並串接成一個字串，中間以空白隔開，並將表頭重新命為'Food name & catalog'
--- WHERE子句
select concat(name , "   " , catalog)  as 'Food name & catalog' from food ;
#6.查詢所有食物價格超過400的食物名稱和價格
select name ,price from food where price > 400 ;
#7.查詢所有食物價格介於250~530之間的食物名稱和價格
select name, price from food where price between 250 and 530; 
#8.查詢所有食物價格不介於250~530之間的食物名稱和價格
select name, price from food where price not between 250 and 530;
#9.	查詢所有食物種類為'點心'的食物名稱和價格
select name , price from food where catalog ='點心';
#10.查詢所有食物種類為'點心'和'飲料'的食物名稱、價格和種類
select name , price , catalog from food where catalog = ('點心' and '飲料');
#11.查詢所有食物產地為'TW'和'JP'的食物名稱和價格
select name , price from food where placeid = ('TW' and 'JP');
#12.查詢所有食物名稱有'油'字的食物名稱、到期日和價格
select name , expiredate , price from food where name like '%油%';
#13.查詢所有食物到期日在今年底以前到期的食物名稱和價格
select	name , price  from	food where	expiredate <= concat(year (curdate()) , '12/31');

#14.查詢所有食物到期日在明年6月底以前到期的食物名稱和價格 
select name , price from food where expiredate <= concat(year (curdate())+1 , '6/30');
#15.查詢所有食物6個月內到期的食物名稱和價格
select name , price from food where datediff(expiredate, curdate()) <= 180;
--- ORDER BY子句
#16.查詢所有食物名稱、到期日和價格，並以價格做降冪排序
select name , expiredate ,price from food order by price DESC;
#17.查詢前三個價格最高的食物名稱、到期日和價格，並以價格做降冪排序
select name , expiredate ,price from food order by price DESC LIMIT 3;
#18.查詢種類為'點心'且價格低於等於250的食物名稱和價格，並以價格做升冪排序
 select name , price from food where catalog = '點心' and price <= 250 order by price ASC;
#19.顯示所有食物名稱、價格和增加5%且四捨五入為整數後的價格，新價格並將表頭命名為'New Price'
select name ,round(price*1.05 ) as 'new price' from food ;
#20.接續上題，再增加一個表頭命名為'Increase'，顯示New price減去price的值
select name ,price , round(price*1.05) as 'new price', round(price*1.05) - price as 'increase' from food ;

#21.顯示所有食物名稱、價格和整數後的價格，新價格並將表頭命名為'New Price'；按價格分250以下、251~500和501以上三種分別增加8%,5%和3%且價格無條件捨去成整數
select name ,price , case when price <=250 then floor(price*1.08) when price between 251 and 500 then floor(price*1.05) when price>500 then floor(price*1.03) end as 'new price' from food ;
#22.查詢所有食物名稱、種類、距離今天尚有幾天到期(正數表示)或已過期幾天(負數表示)和註記(有'已過期'或'未過期'兩種)，並將後兩者表頭分別命名為'Days of expired'和'expired or not'
SELECT name , catalog , DATEDIFF(expiredate, curdate()) AS 'Days of expired', 
		CASE 
		  WHEN DATEDIFF(expiredate, curdate()) < 0 THEN '已過期'
          WHEN DATEDIFF(expiredate, curdate()) > 0 THEN '未過期'
		  END AS 'expired or not'
FROM food;

#23.接續上題，並以過期天數做升冪排序

SELECT name , catalog , DATEDIFF(expiredate, curdate()) AS 'Days of expired', 
		CASE 
		  WHEN DATEDIFF(expiredate, curdate()) < 0 THEN '已過期'
          WHEN DATEDIFF(expiredate, curdate()) > 0 THEN '未過期'
		  END AS 'expired or not'
FROM food order by DATEDIFF(expiredate, curdate()) ASC;


--- GROUP BY & HAVING子句

#24.查詢所有食物最高、最低、加總和平均價格，表頭分別命名為'Max'、'Min'、'Sum'和'Avg'，結果皆以四捨五入的整數來顯示
select max(price) as 'max' , min(price) as 'Min', round(sum(price)) as 'sum' , round(avg(price)) as 'Avg' from food;
#25.接續上題，查詢每個種類
select catalog ,max(price) as 'max' , min(price) as 'Min', round(sum(price)) as 'sum' , round(avg(price)) as 'Avg' from food  group by catalog;
#26.接續上題，查詢每個種類且平均價格超過300，並以平均價格做降冪排序
select catalog ,max(price) as 'max' , min(price) as 'Min', round(sum(price)) as 'sum' , round(avg(price)) as 'Avg' from food  group by catalog
having avg(price) >300 order by avg(price) desc;
#27.顯示查詢每個種類的食物數量
select catalog,count(*)count from food group by catalog;
#28.查詢不同產地和每個種類的食物數量
select placeid,catalog,count(*)count from food group by placeid,catalog; 


