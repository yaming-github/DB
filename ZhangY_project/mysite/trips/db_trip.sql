CREATE
DATABASE IF NOT EXISTS `db_trip`;

USE
`db_trip`;

DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`
(
    `id`          int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `email`       varchar(64) NOT NULL UNIQUE KEY,
    `username`    varchar(64) NOT NULL UNIQUE KEY,
    `password`    varchar(64) NOT NULL DEFAULT '',
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_city`;
CREATE TABLE `t_city`
(
    `id`          int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name`        varchar(64) NOT NULL DEFAULT '',
    `state`       varchar(64) NOT NULL DEFAULT '',
    `country`     varchar(64) NOT NULL DEFAULT '',
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY (`name`, `state`, `country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_restaurant`;
CREATE TABLE `t_restaurant`
(
    `id`          int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `city_id`     int(11) NOT NULL DEFAULT 0,
    `name`        varchar(64) NOT NULL DEFAULT '',
    `address`     varchar(64) NOT NULL DEFAULT '',
    `cuisine`     varchar(64) NOT NULL DEFAULT '',
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`city_id`) REFERENCES `t_city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY (`city_id`, `address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_trip`;
CREATE TABLE `t_trip`
(
    `id`          int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name`        varchar(64) NOT NULL DEFAULT '',
    `owner`       varchar(64) NOT NULL DEFAULT '',
    `date_from`   datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `date_to`     datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`owner`) REFERENCES `t_user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_trip_company`;
CREATE TABLE `t_trip_company`
(
    `id`          int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `trip_id`     int(11) NOT NULL DEFAULT 0,
    `company`     varchar(64) NOT NULL DEFAULT '',
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`trip_id`) REFERENCES `t_trip` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`company`) REFERENCES `t_user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY (`trip_id`, `company`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_trip_city`;
CREATE TABLE `t_trip_city`
(
    `id`          int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `trip_id`     int(11) NOT NULL DEFAULT 0,
    `city_id`     int(11) NOT NULL DEFAULT 0,
    `date`        datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`trip_id`) REFERENCES `t_trip` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`city_id`) REFERENCES `t_city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE KEY (`trip_id`, `city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_trip_meal`;
CREATE TABLE `t_trip_meal`
(
    `id`            int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `trip_id`       int(11) NOT NULL DEFAULT 0,
    `restaurant_id` int(11) NOT NULL DEFAULT 0,
    `review`        varchar(64) NOT NULL DEFAULT '',
    `date`          datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `create_time`   datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time`   datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`trip_id`) REFERENCES `t_trip` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`restaurant_id`) REFERENCES `t_restaurant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_trip_images`;
CREATE TABLE `t_trip_images`
(
    `id`          int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `trip_id`     int(11) NOT NULL DEFAULT 0,
    `url`         varchar(256) NOT NULL DEFAULT '',
    `create_time` datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`trip_id`) REFERENCES `t_trip` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    KEY `idx_trip_id` (`trip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
