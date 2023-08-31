CREATE
DATABASE IF NOT EXISTS `db_regional_schools`;
USE
`db_regional_schools`;

DROP TABLE IF EXISTS `t_school`;
CREATE TABLE `t_school`
(
    `id`          int(11) NOT NULL PRIMARY KEY,
    `name`        varchar(50) NOT NULL DEFAULT '',
    `town`        varchar(50) NOT NULL DEFAULT '',
    `street`      varchar(50) NOT NULL DEFAULT '',
    `zipcode`     char(5)     NOT NULL DEFAULT '',
    `phone`       char(10)    NOT NULL DEFAULT '',
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_teacher`;
CREATE TABLE `t_teacher`
(
    `nin`            char(9)     NOT NULL PRIMARY KEY,
    `first_name`     varchar(50) NOT NULL DEFAULT '',
    `second_name`    varchar(50) NOT NULL DEFAULT '',
    `sex`            tinyint(4) NOT NULL DEFAULT 0 COMMENT '0-female, 1-male, etc.',
    `qualifications` varchar(50) NOT NULL DEFAULT '',
    `school_id`      int(11) NOT NULL DEFAULT 0,
    `create_time`    datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time`    datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`school_id`) REFERENCES `t_school` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_school_manager`;
CREATE TABLE `t_school_manager`
(
    `school_id`      int(11) NOT NULL PRIMARY KEY,
    `manage_nin`     char(9)  NOT NULL DEFAULT '',
    `date_of_manage` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `create_time`    datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time`    datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`school_id`) REFERENCES `t_school` (`id`),
    FOREIGN KEY (`manage_nin`) REFERENCES `t_teacher` (`nin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_pupil`;
CREATE TABLE `t_pupil`
(
    `id`          int(11) NOT NULL PRIMARY KEY,
    `first_name`  varchar(50) NOT NULL DEFAULT '',
    `second_name` varchar(50) NOT NULL DEFAULT '',
    `sex`         tinyint(4) NOT NULL DEFAULT 0 COMMENT '0-female, 1-male, etc.',
    `dob`         datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `school_id`   int(11) NOT NULL DEFAULT 0,
    `create_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`school_id`) REFERENCES `t_school` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_subject`;
CREATE TABLE `t_subject`
(
    `name`         varchar(50) NOT NULL PRIMARY KEY,
    `abbreviation` varchar(50) NOT NULL UNIQUE KEY,
    `level`        tinyint(4) NOT NULL DEFAULT 0,
    `create_time`  datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time`  datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_class`;
CREATE TABLE `t_class`
(
    `id`           int(11) NOT NULL,
    `subject_name` varchar(50) NOT NULL,
    `teacher_nin`  char(9)     NOT NULL DEFAULT '',
    `num_of_hours` int(11) NOT NULL DEFAULT 0,
    `create_time`  datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time`  datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`, `subject_name`),
    FOREIGN KEY (`subject_name`) REFERENCES `t_subject` (`name`),
    FOREIGN KEY (`teacher_nin`) REFERENCES `t_teacher` (`nin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `t_register`;
CREATE TABLE `t_register`
(
    `pupil_id`     int(11) NOT NULL,
    `class_id`     int(11) NOT NULL,
    `subject_name` varchar(50) NOT NULL,
    `create_time`  datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_time`  datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`pupil_id`, `class_id`, `subject_name`),
    FOREIGN KEY (`pupil_id`) REFERENCES `t_pupil` (`id`),
    FOREIGN KEY (`class_id`) REFERENCES `t_class` (`id`),
    FOREIGN KEY (`subject_name`) REFERENCES `t_subject` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
