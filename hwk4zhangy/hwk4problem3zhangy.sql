CREATE
DATABASE IF NOT EXISTS `db_cleaning_company`;
USE
`db_cleaning_company`;

DROP TABLE IF EXISTS `t_client`;
CREATE TABLE `t_client`
(
    `name`        varchar(50) NOT NULL PRIMARY KEY,
    `type`        ENUM('domestic', 'commercial') NOT NULL DEFAULT 'domestic',
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_worker`;
CREATE TABLE `t_worker`
(
    `ssn`              char(9)     NOT NULL PRIMARY KEY,
    `is_administrator` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 1 for true false',
    `duty`             varchar(50) NOT NULL DEFAULT '',
    `create_time`      datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time`      datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_group`;
CREATE TABLE `t_group`
(
    `id`          int(11) NOT NULL PRIMARY KEY,
    `supervisor`  char(9)  NOT NULL DEFAULT '',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`supervisor`) REFERENCES `t_worker` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_group_members`;
CREATE TABLE `t_group_members`
(
    `group_id`    int(11) NOT NULL,
    `member`      char(9)  NOT NULL,
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`group_id`, `member`),
    FOREIGN KEY (`group_id`) REFERENCES `t_group` (`id`),
    FOREIGN KEY (`member`) REFERENCES `t_worker` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_equipment`;
CREATE TABLE `t_equipment`
(
    `name`        varchar(50) NOT NULL PRIMARY KEY,
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_job`;
CREATE TABLE `t_job`
(
    `id`                   int(11) NOT NULL PRIMARY KEY,
    `job_desc`             varchar(50) NOT NULL DEFAULT '',
    `client_name`          varchar(50) NOT NULL DEFAULT '',
    `administrative_staff` char(9)     NOT NULL DEFAULT '',
    `cleaning_hours`       int(11) NOT NULL DEFAULT 0,
    `group_id`             int(11) NOT NULL DEFAULT 0,
    `create_time`          datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time`          datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`client_name`) REFERENCES `t_client` (`name`),
    FOREIGN KEY (`administrative_staff`) REFERENCES `t_worker` (`ssn`),
    FOREIGN KEY (`group_id`) REFERENCES `t_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_job_equipment`;
CREATE TABLE `t_job_equipment`
(
    `job_id`      int(11) NOT NULL,
    `eq_name`     varchar(50) NOT NULL,
    `quantity`    int(11) NOT NULL DEFAULT 0,
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`job_id`, `eq_name`),
    FOREIGN KEY (`job_id`) REFERENCES `t_job` (`id`),
    FOREIGN KEY (`eq_name`) REFERENCES `t_equipment` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
