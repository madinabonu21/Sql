--create database M_database
--table 1 
use M_database

create table students (id int , students_name Varchar(60) , age int )

insert into students values (1, 'Dilnavoz', 20), (2,'Sabina' , 20),(3, 'Javohir' , 19), (4, 'Kamilla ', 18), (5, 'Shahzoda', 25), (6,'Asolat', 20), (7,'Feruza', 27) , (8, 'Kirill', 19), (9, 'Imron', 22), (10, 'Muhammad', 21)

select* from students



--table 2 
use M_database

create table customers (id int, customers_name Varchar(60), purchase_name Varchar (60) )

insert into customers values (1, 'Jennie', 'spoon'), (2,'Sabina' , 'book'),(3, 'Lisa' , 'bag'), (4, 'Kamilla ', 'pencil'), (5, 'Dilnavoz ', 'sticker'), (6,'Jimin', 'highlighter'), (7,'Feruza', 'sunglasses ') , (8, 'Kirill', 'notebook'), (9, 'Rose', 'pen'), (10, 'Muhammad', 'paperclips')

select* from customers


--table 3
use M_database

create table departure (Flight Varchar (10), Flight_time Time , Destination Varchar (100) ) 

insert into departure values ('9U 881', '19:40', 'Venice/Marco Polo'),('9U 175', '20:10', 'Moscow/Domodedov'),('RO 208', '06:00', 'Bucharest/Otopeni'),('9U 833', '06:00', 'London/Stansted'),('9U 893', '06:40', 'Milan/Malpensa'),('PS 898', '07:40', 'Kiev'),('DLH 1835', '8:50', 'Munich'),('D8 5006', '9:20', 'Birmingham'),('TK 1304', '10:35', 'Barcelona'),('QTR 3509', '11:20', 'Melilla')

select* from departure


--table 4
use M_database

create table Exam_results (Student_id int , group_name Varchar (10), Subject_name Varchar(20), score int )

insert into Exam_results values (10001, 'RI_01','History', 90), (10002, 'SST_02','Math', 60), (10003, 'RI_01','History', 95), (10004, 'BHA_11','Economics', 84),(10005, 'SST_02','Math', 92),(10006, 'RI_01','History', 64), (10007, 'SST_02','Math', 98),(10008, 'BHA_11','Economics', 76), (10009, 'BHA_11','Economics', 82),(10010, 'RI_01','History', 78),(10011, 'SST_02','Math', 80),(10012, 'BHA_11','Economics', 60)

select* from Exam_results



--table 5 
use M_database

create table Event_schedule (Participant_id int , Table_number int, Event_time Date)

insert into Event_schedule values (1,12,'2025-07-17'),(2,10,'2025-07-17'),(3,11,'2025-07-17'),(4,19,'2025-07-17'),(5,20,'2025-07-17'),(6,2,'2025-07-17'),(7,8,'2025-07-17'),(8,4,'2025-07-17'),(9,3,'2025-07-17'),(10,11,'2025-07-17'),(11,5,'2025-07-17')

select* from Event_schedule
