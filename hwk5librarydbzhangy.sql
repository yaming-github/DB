use
librarydb;

--1.
select isbn, title, page_count, publisher_name
from book;

--2.
select count(*) as books_on_loan
from book
where available = 0;

select count(*) as books_on_loan
from book
where current_holder is not null;

select sum(available = 0) as books_on_loan
from book;

--3.
select count(distinct current_holder) as num_members
from book
where available = 0;

select count(distinct current_holder) as num_members
from book
where current_holder is not null;

--4.
create table books_on_loan
as (select *
    from book
    where available = 0);

create table books_on_loan
as (select *
    from book
    where current_holder is not null);

--5.
select isbn, title, description, page_count, publisher_name, author
from book
         natural join book_author;

select isbn, title, description, page_count, publisher_name, author
from book
         join book_author using (isbn);

select book.isbn, title, description, page_count, publisher_name, author
from book
         join book_author
where book.isbn = book_author.isbn;

--6.
select isbn, title, GROUP_CONCAT(genre) as grouped_list
from book
         natural join book_genre
group by isbn;

--7.
select title
from book
where page_count = (select max(page_count) from book);

--8.
select username, count(name) as num_clubs
from librarian
         left join reading_club on librarian.username = reading_club.librarian
group by username;

--9.
select *
from book
where page_count < 300
order by page_count desc;

--10.
select name, count(isbn) as num_books
from genre
         left join book_genre on genre.name = book_genre.genre
group by name
order by num_books desc;

--11.
select current_book_isbn,
       title,
       publisher_name,
       pub_num,
       group_concat(author) as authors,    -- a book may have multiple authors so we need an aggregate func here
       sum(num_books)       as num_books,  -- same from above
       min(first_name)      as first_name, -- a book may have multiple librarians so we need an aggregate func here
       min(last_name)       as last_name   -- same from above
from reading_club
         left join book
                   on reading_club.current_book_isbn = book.isbn
         left join (select publisher_name, count(*) as pub_num from book group by publisher_name) a
                   using (publisher_name)
         left join book_author
                   using (isbn)
         left join (select author, count(*) as num_books from book_author group by author) b
                   using (author)
         left join librarian
                   on reading_club.librarian = librarian.username
group by current_book_isbn;

--12.
select member_username
from reading_club_members
group by member_username
having count(distinct club_name) = (select count(*) from reading_club);

--13.
select first_name, last_name
from member
where username in
      (select member_username
       from reading_club_members
       group by member_username
       having count(distinct club_name) = (select count(*) from reading_club));

select first_name, last_name
from member
         left join
     (select member_username
      from reading_club_members
      group by member_username
      having count(distinct club_name) = (select count(*) from reading_club)) a
     on member.username = a.member_username
where a.member_username is not null;

--14.
-- according to https://en.wikipedia.org/wiki/21st_century, the 21st century began on 1 January 2001
select *
from book
where publication_date < '2001';

--15.
select a.club_name as club_name, a.member_username as pair_1, b.member_username as pair_2
from reading_club_members a
         join reading_club_members b
              on a.club_name = b.club_name and a.member_username < b.member_username
order by a.club_name;

--16.
select author, count(*) as num_books
from book_author
group by author
order by num_books desc;

--17.
select num_books
from (select author, count(*) as num_books
      from book_author
      group by author
      order by num_books desc) a limit 1;

select max(num_books)
from (select author, count(*) as num_books
      from book_author
      group by author) a;

--18.
select author, count(*) as num_books
from book_author
group by author
having num_books = (select max(num_books)
                    from (select author, count(*) as num_books
                          from book_author
                          group by author) a);

-- NOTE that window function is only available on MySql 8.0 and after
select author, num_books
from (select author, count(*) as num_books, rank() over (order by count(*) desc) as r
      from book_author
      group by author) a
where r = 1;
