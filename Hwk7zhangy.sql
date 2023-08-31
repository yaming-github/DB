use librarydb;

-- 1. return the count(genre) of the specific isbn
drop FUNCTION if exists num_genres;
DELIMITER //

CREATE FUNCTION num_genres(isbn_p VARCHAR(50)) RETURNS INT DETERMINISTIC
BEGIN
DECLARE num INT;
select count(*) into num from book_genre where isbn = isbn_p;
RETURN num;
END; //

DELIMITER ;

SELECT NUM_GENRES('9780804190121');
SELECT NUM_GENRES('9780749460211');
SELECT NUM_GENRES('9780814416259');

-- 2. return all the genres of the specific isbn
drop PROCEDURE if exists all_genres;
DELIMITER //

CREATE PROCEDURE all_genres(isbn_p VARCHAR(50))
BEGIN
select genre from book_genre where isbn = isbn_p;
END; //

DELIMITER ;

call all_genres("9781601638618");
call all_genres("9780007287758");
call all_genres("9780007374038");

-- 3. We have 2 methods for this problem
-- First is using the cursor and set a HANDLER FOR NOT FOUND and thow the signal for no results
-- Second is to check if the argument genre is in the genre table and throw signal based on that
-- We prefer using the second method here because it's way easier
drop PROCEDURE if exists book_has_genre;
DELIMITER //

CREATE PROCEDURE book_has_genre(genre_p VARCHAR(50))
BEGIN
DECLARE row_not_found TINYINT DEFAULT FALSE;
DECLARE row_num INT DEFAULT 0;
DECLARE isbn, author, publisher_name varchar(80);
DECLARE page_count int;

DECLARE book_has_genre_c CURSOR FOR
select b.isbn, c.author, b.page_count, b.publisher_name from book_genre a join book b join book_author c on a.genre = genre_p and a.isbn = b.isbn and a.isbn = c.isbn;

DECLARE CONTINUE HANDLER FOR NOT FOUND
BEGIN
set row_not_found = True;
-- only when the row_num = 0, which means there is no such genre, we throw a signal!
if row_num = 0 then SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'genre not found'; end if;
END;

OPEN book_has_genre_c;

WHILE row_not_found = FALSE DO
FETCH book_has_genre_c INTO isbn, author, page_count, publisher_name;
SELECT isbn, author, page_count, publisher_name;
set row_num = row_num + 1;
END WHILE ;

CLOSE book_has_genre_c;

END; //

DELIMITER ;

drop PROCEDURE if exists book_has_genre;
DELIMITER //

CREATE PROCEDURE book_has_genre(genre_p VARCHAR(50))
BEGIN
if genre_p in (select distinct genre from book_genre) then
select b.isbn, c.author, b.page_count, b.publisher_name from book_genre a join book b join book_author c on a.genre = genre_p and a.isbn = b.isbn and a.isbn = c.isbn;
else SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'genre not found'; end if;
END; //

DELIMITER ;

call book_has_genre("20th Century");
call book_has_genre("Accounting");
call book_has_genre("Action");
-- a test for 'genre not found' signal!
-- call book_has_genre("Signal Test");


-- 4. a simple sql select clause
drop FUNCTION if exists book_length;
DELIMITER //

CREATE FUNCTION book_length(length_p INT) RETURNS INT DETERMINISTIC
BEGIN
DECLARE num INT;
select count(*) into num from book where page_count = length_p;
RETURN num;
END; //

DELIMITER ;

select book_length(254);
select book_length(408);
select book_length(340);

-- 5. a simple select clause with left join
drop PROCEDURE if exists check_books_by_author;
DELIMITER //

CREATE PROCEDURE check_books_by_author()
BEGIN
select books_written, a.name, b.num from author a left join (select author, count(*) as num from book_author group by author) b on a.name = b.author;
END; //

DELIMITER ;

call check_books_by_author;

-- 6. we first select books_written of both author 1 and 2 then compare and return using if else clause
drop FUNCTION if exists moreBooks;
DELIMITER //

CREATE FUNCTION moreBooks(author1 varchar(50), author2 varchar(50)) RETURNS INT DETERMINISTIC
BEGIN
DECLARE num1, num2 INT;
select books_written into num1 from author where name = author1;
select books_written into num2 from author where name = author2;
if num1 > num2 then return 1;
elseif num1 = num2 then return 0;
else return -1;
end if;
END; //

DELIMITER ;

select moreBooks("Agatha Christie", "Al Ewing");
select moreBooks("Alan Moore", "Alex Lake");
select moreBooks("Alvin Hall", "Andre Aciman");

-- 7. Note that we need to update the table in order in case there would be foreign key restriction
-- The order should be publisher, book, author, book_author
drop PROCEDURE if exists create_book;
DELIMITER //

CREATE PROCEDURE create_book(isbn_p char(13), title_p varchar(500), author_p varchar(500), description_p varchar(10000), page_count_p int, publisher_name_p varchar(80), publication_date_p date)
BEGIN
if publisher_name_p in (select distinct name from publisher) then UPDATE publisher SET books_published = books_published + 1 WHERE name = publisher_name_p;
else insert into publisher values (publisher_name_p, 1); end if;
insert into book (isbn, title, description, page_count, publisher_name, publication_date) values (isbn_p, title_p, description_p, page_count_p, publisher_name_p, publication_date_p);
if author_p in (select distinct name from author) then UPDATE author SET books_written = books_written + 1 WHERE name = author_p;
else insert into author values (author_p, 1); end if;
insert into book_author values (author_p, isbn_p);
SELECT * FROM publisher WHERE name = publisher_name_p;
SELECT * FROM book WHERE isbn = isbn_p;
SELECT * FROM author WHERE name = author_p;
SELECT * FROM book_author WHERE author = author_p;
END; //

DELIMITER ;

delete from book where isbn = '1482576155';
delete from book_author where isbn = '1482576155';
delete from book where isbn = '1234567899';
delete from book_author where isbn = '1234567899';
call create_book("1482576155", "Pride and Prejudice", "Jane Austen", "Classic novel on the plight and limitations for women in the nineteenth century", 254, "CreateSpace Independent Publishing Platform", "2013-02-19");
call create_book("1234567899", "title test", "author test", "desc test", 100, "publisher test", "2023-03-19");
delete from book where isbn = '1482576155';
delete from book_author where isbn = '1482576155';
delete from book where isbn = '1234567899';
delete from book_author where isbn = '1234567899';

-- 8. a simple select clause
drop PROCEDURE if exists checked_out_books;
DELIMITER //

CREATE PROCEDURE checked_out_books()
BEGIN
select a.isbn, title, group_concat(c.author), description, page_count, publisher_name, username, first_name, last_name
from book a join member b join book_author c on a.available = 0 and a.current_holder = b.username and a.isbn = c.isbn group by a.isbn;
END; //

DELIMITER ;

call checked_out_books;

-- 9. we only need to insert or update author before insert into book_author
-- use in clause to check if the author exists in the author table
drop TRIGGER if exists author_before_insert_book_author;
DELIMITER //

CREATE TRIGGER author_before_insert_book_author
BEFORE INSERT ON book_author
FOR EACH ROW
BEGIN
if NEW.author in (select distinct name from author) then UPDATE author SET books_written = books_written + 1 WHERE name = NEW.author;
else insert into author values (NEW.author, 1); end if;
END //

DELIMITER ;

delete from book where isbn = '1953649327';
delete from book_author where isbn = '1953649327';
insert into book values ('1953649327', 'Emma', 'Austen explores the concerns and difficulties of genteel women living in Georgian–Regency England. Emma is spoiled, headstrong, and self-satisfied', 408, 1, null, 'SeaWolf Press', '2020-10-31');
insert into book_author values ('Jane Austen', '1953649327');
select * from author where name = 'Jane Austen';
delete from book where isbn = '1953649327';
delete from book_author where isbn = '1953649327';

-- 10. similar to Q9
drop TRIGGER if exists publisher_before_book_insert;
DELIMITER //

CREATE TRIGGER publisher_before_book_insert
BEFORE INSERT ON book
FOR EACH ROW
BEGIN
if NEW.publisher_name in (select distinct name from publisher) then UPDATE publisher SET books_published = books_published + 1 WHERE name = NEW.publisher_name;
else insert into publisher values (NEW.publisher_name, 1); end if;
END //

DELIMITER ;

delete from book where isbn = '1955529868';
insert into book values ('1955529868', 'Sense and Sensibility', 'Sense and Sensibility is a novel by Jane Austen, initially published anonymously in 1811. It tells the story of the Dashwood sisters, Elinor and Marianne as they come of age.', 340, 1, null, 'SeaWolf Press', '2021-07-08');
select * from publisher where name = 'SeaWolf Press';
delete from book where isbn = '1955529868';

-- 11. take advantages of the 2 triggers above
drop PROCEDURE if exists create_books_simpler;
DELIMITER //

CREATE PROCEDURE create_books_simpler(isbn_p char(13), title_p varchar(500), author_p varchar(50), description_p varchar(10000), page_count_p int, publisher_name_p varchar(80), publication_date_p date)
BEGIN
insert into book (isbn, title, description, page_count, publisher_name, publication_date) values (isbn_p, title_p, description_p, page_count_p, publisher_name_p, publication_date_p);
insert into book_author values (author_p, isbn_p);
select * from publisher where name = publisher_name_p;
select * from book where isbn = isbn_p;
select * from author where name = author_p;
select * from book_author where author = author_p;
END; //

DELIMITER ;

delete from book where isbn = '1953649327';
delete from book where isbn = '1955529868';
call create_books_simpler('1953649327', 'Emma', 'Jane Austen', 'Austen explores the concerns and difficulties of genteel women living in Georgian–Regency England. Emma is spoiled, headstrong, and self-satisfied', 408, 'SeaWolf Press', '2020-10-31');
call create_books_simpler('1955529868', 'Sense and Sensibility', 'Jane Austen', 'Sense and Sensibility is a novel by Jane Austen, initially published anonymously in 1811. It tells the story of the Dashwood sisters, Elinor and Marianne as they come of age.', 340, 'SeaWolf Press', '2021-07-08');

-- 12.
PREPARE more_books_stmt FROM 'SELECT moreBooks(?, ?)';
set @author1 = 'Billy Connolly';
set @author2 = 'Barbara Allan';
EXECUTE more_books_stmt USING @author1, @author2;

-- 13.
PREPARE book_length_stmt FROM 'SELECT book_length(?)';
set @length_p = 400;
EXECUTE book_length_stmt USING @length_p;

-- 14. update the publisher table using join and base on the right table values
drop PROCEDURE if exists update_all_publishers;
DELIMITER //

CREATE PROCEDURE update_all_publishers()
BEGIN
update publisher a join (select publisher_name, count(*) as num from book group by publisher_name) b
set a.books_published = b.num
where a.name = b.publisher_name;
END; //

DELIMITER ;

call update_all_publishers;

-- 15. update the author table using join and base on the right table values
drop PROCEDURE if exists update_all_authors;
DELIMITER //

CREATE PROCEDURE update_all_authors()
BEGIN
update author a join (select author, count(*) as num from book_author group by author) b
set a.books_written = if(b.num is null, 0, b.num)
where a.name = b.author;
END; //

DELIMITER ;

call update_all_authors;
