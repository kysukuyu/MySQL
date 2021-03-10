#subquery
#1.查詢所有比'鳳梨酥'貴的食物名稱、日期日和價格
select name , expiredate , price from food where price > (select price from food where name = '鳳梨酥');
#2.查詢所有比'曲奇餅乾'便宜且種類是'點心'的食物名稱、日期日和價格
select name , expiredate , price  from food where catalog = '點心' having  price < (select price  from food where name = '曲奇餅乾' );

#3.查詢所有和'鳳梨酥'同一年到期的食物名稱、日期日和價格
select name , expiredate , price from food where expiredate = (select expiredate from food where name = '鳳梨酥');
#4.查詢所有比平均價格高的食物名稱、日期日和價格
select name , expiredate , price from food where price > (select avg(price) from food );
#5.查詢所有比平均價格低的'台灣'食物名稱、日期日和價格
select name , expiredate , price from food where placeid = 'TW' and price < (select avg(price) from food);
#6.查詢所有種類和'仙貝'相同且價格比'仙貝'便宜的食物名稱、日期日和價格
select name , expiredate , price from food where catalog = (select catalog from food where name = '仙貝') and
price < (select price from food where name = '仙貝');

#7.查詢所有產地和'仙貝'相同且到期日超過6個月以上的食物名稱、日期日和價格
select name , expiredate , price from food where placeid = (select placeid from food where name = '仙貝') and datediff(
expiredate , curdate()) >180;
                                                                                                                                    
#8.	查詢每個產地價格最低的食物名稱、日期日和價格
select name , expiredate , price from food as f where price in (select min(price) from food group by placeid having placeid = f.placeid);
#9.	查詢每個種類的食物價格最高者的食物名稱和價格 
select name , price from food as f where price in (select max(price) from food group by catalog having catalog = f.catalog);
#10.查詢所有種類不是'點心'但比種類是'點心'貴的食物名稱、種類和價格，並以價格做降冪排序
select name , catalog , price from food   where price > any (select price from food where catalog = '點心') and  catalog <> 
'點心'  order by price desc;

#11.查詢每個產地(顯示產地名稱)的食物價格最高者的食物名稱和價格
select f.name , f.price , p.name from food as f join place as p on f.placeid = p.id 
where price in (select max(price) from food group by f.placeid having placeid = f.placeid);