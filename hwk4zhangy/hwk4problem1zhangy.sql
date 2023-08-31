CREATE
DATABASE IF NOT EXISTS `db_grocery_store`;
USE
`db_grocery_store`;

DROP TABLE IF EXISTS `t_store`;
CREATE TABLE `t_store`
(
    `chain_id`    int(11) NOT NULL PRIMARY KEY,
    `street_no`   int(11) NOT NULL DEFAULT 0,
    `street_name` varchar(50) NOT NULL DEFAULT '',
    `zipcode`     char(5)     NOT NULL DEFAULT '',
    `state`       char(2)     NOT NULL DEFAULT '',
    `open_time`   char(5)     NOT NULL DEFAULT '',
    `close_time`  char(5)     NOT NULL DEFAULT '',
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_staff`;
CREATE TABLE `t_staff`
(
    `staff_no`      int(11) NOT NULL PRIMARY KEY,
    `first_name`    varchar(50) NOT NULL DEFAULT '',
    `second_name`   varchar(50) NOT NULL DEFAULT '',
    `work_chain_id` int(11) NOT NULL DEFAULT 0,
    `create_time`   datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time`   datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`work_chain_id`) REFERENCES `t_store` (`chain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_store_manager`;
CREATE TABLE `t_store_manager`
(
    `chain_id`    int(11) NOT NULL PRIMARY KEY,
    `manager_no`  int(11) NOT NULL DEFAULT 0,
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`chain_id`) REFERENCES `t_store` (`chain_id`),
    FOREIGN KEY (`manager_no`) REFERENCES `t_staff` (`staff_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_customer`;
CREATE TABLE `t_customer`
(
    `ssn`           char(9)     NOT NULL PRIMARY KEY,
    `first_name`    varchar(50) NOT NULL DEFAULT '',
    `last_name`     varchar(50) NOT NULL DEFAULT '',
    `local_address` varchar(50) NOT NULL DEFAULT '',
    `create_time`   datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time`   datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_grocery_type`;
CREATE TABLE `t_grocery_type`
(
    `name`        varchar(50) NOT NULL PRIMARY KEY,
    `genre`       varchar(50) NOT NULL DEFAULT '',
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_store_food_quantity`;
CREATE TABLE `t_store_food_quantity`
(
    `chain_id`    int(11) NOT NULL,
    `name`        varchar(50) NOT NULL,
    `num_of_item` int(11) NOT NULL DEFAULT 0,
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`chain_id`, `name`),
    FOREIGN KEY (`chain_id`) REFERENCES `t_store` (`chain_id`),
    FOREIGN KEY (`name`) REFERENCES `t_grocery_type` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_credit_card`;
CREATE TABLE `t_credit_card`
(
    `card_num`    char(16) NOT NULL PRIMARY KEY,
    `type`        ENUM('VISA', 'AMEX', 'Mastercard') NOT NULL DEFAULT 'VISA',
    `expire_date` char(5)  NOT NULL DEFAULT '' COMMENT 'date like 05/23',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_register`;
CREATE TABLE `t_register`
(
    `ssn`         char(9)  NOT NULL,
    `card_num`    char(16) NOT NULL,
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`ssn`, `card_num`),
    FOREIGN KEY (`ssn`) REFERENCES `t_customer` (`ssn`),
    FOREIGN KEY (`card_num`) REFERENCES `t_credit_card` (`card_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order`
(
    `id`          int(11) NOT NULL PRIMARY KEY,
    `ssn`         char(9)  NOT NULL,
    `chain_id`    int(11) NOT NULL,
    `type_of_id`  ENUM('credit card', 'driving license', 'passport') NOT NULL DEFAULT 'credit card',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`ssn`) REFERENCES `t_customer` (`ssn`),
    FOREIGN KEY (`chain_id`) REFERENCES `t_store` (`chain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_order_food`;
CREATE TABLE `t_order_food`
(
    `order_id`    int(11) NOT NULL,
    `name`        varchar(50) NOT NULL,
    `num_of_item` int(11) NOT NULL DEFAULT 0,
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`order_id`, `name`),
    FOREIGN KEY (`order_id`) REFERENCES `t_order` (`id`),
    FOREIGN KEY (`name`) REFERENCES `t_grocery_type` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
