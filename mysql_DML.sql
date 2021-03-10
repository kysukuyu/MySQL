#DML
#1.以不列舉欄位的方式新增一筆食物資料
insert  food values ( 'DK005' , '可樂' , curdate() , 'TW' , 35 , '飲料');
#2.以列舉欄位的方式新增一筆食物資料
insert food  (id , name , expiredate , placeid ,price , catalog)
           values ('DK012' , '奶茶' , curdate() , 'TW' , 50 ,'飲料'); 
     
#3.以不列舉欄位的方式新增多產地資料
insert food values ('DK022' , '烏龍茶' , curdate() , 'JP' , 65 ,'飲料');
insert food values ('DK036' , '鮮奶綠' , curdate() , 'TL' , 58 ,'飲料');
insert food values ('DK068' , '汽水' , curdate() , 'US' , 55 ,'飲料');

#4.修改一筆食物資料的價格
update food set price =30  where id ='DK005';
#5.按價格分250以下、251~500和501以上三種分別增加8%,5%和3%且價格無條件捨去成整數.
set sql_safe_updates = 0;
update food
set price =
	case
		when price < 250 then floor(price * 1.08)
		when price between 251 and 500 then floor(price * 1.05)
		else floor(price * 1.03)
	end;
select * from food;
set sql_safe_updates = 1;



#6.刪除一筆食物資料
delete from food where id = 'DK005';