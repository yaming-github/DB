-- 2.a 3 databases are created by the script

/* 2.b

ap: `general_ledger_accounts`, `invoice_archive`, `invoice_line_items`, `invoices`,
`terms`, `vendor_contacts`, `vendors`

ex: `active_invoices`, `color_sample`, `customers`, `date_sample`,
`departments`, `employees`, `float_sample`, `null_sample`,
`paid_invoices`, `projects`, `string_sample`

om: `customers`, `items`, `order_details`, `orders`order_details
*/

-- 2.c select count(*) from om.order_details; 68 records
-- 2.d 114 records
-- 2.e 122 records
-- 2.f Yes. CONSTRAINT `invoices_fk_vendors` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`vendor_id`)
-- 2.g 2 foreign keys
-- 2.h customer_id, PRIMARY KEY (`customer_id`)

-- 2.i
-- use om;
select * from om.orders;

-- 2.j
-- use um;
select title, artist from om.items;

-- 5.a 11 tables

/* 5.b 
`Album`, `Artist`, `Customer`, `Employee`,
`Genre`, `Invoice`, `InvoiceLine`, `MediaType`,
`Playlist`, `PlaylistTrack`, `Track`
*/

-- 5.c 347 records
-- 5.d AlbumId, PRIMARY KEY (`AlbumId`)

-- 5.e
-- use Chinook;
select * from Chinook.Artist;

-- 5.f
-- use Chinook;
select FirstName, LastName, Title from Chinook.Employee;
