-- Adminer 4.8.1 MySQL 8.0.33 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;

SET NAMES utf8mb4;

CREATE DATABASE `cms2015` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cms2015`;

DROP TABLE IF EXISTS `app_logs`;
CREATE TABLE `app_logs` (
                            `id` bigint NOT NULL AUTO_INCREMENT,
                            `action` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                            `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
                            `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                            `timestamp` datetime(6) NOT NULL,
                            PRIMARY KEY (`id`) USING BTREE,
                            KEY `app_logs_idx3` (`timestamp`) USING BTREE,
                            FULLTEXT KEY `app_logs_idx1` (`action`),
                            FULLTEXT KEY `app_logs_idx2` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
                            `id` bigint NOT NULL AUTO_INCREMENT,
                            `id_site` bigint NOT NULL,
                            `id_user_creator` bigint NOT NULL,
                            `id_last_user_editor` bigint NOT NULL,
                            `id_state` bigint DEFAULT NULL,
                            `id_template` bigint DEFAULT NULL,
                            `guid_parent_article` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                            `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                            `subtitle` text COLLATE utf8mb4_unicode_ci,
                            `abstract` text COLLATE utf8mb4_unicode_ci,
                            `description` mediumtext COLLATE utf8mb4_unicode_ci,
                            `created_at` datetime NOT NULL,
                            `update_at` datetime DEFAULT NULL,
                            `date_begin_pubblication` datetime DEFAULT NULL,
                            `date_end_pubblication` datetime DEFAULT NULL,
                            `on_index` tinyint NOT NULL,
                            `position` int DEFAULT NULL,
                            `description_filtered` mediumtext COLLATE utf8mb4_unicode_ci,
                            `state` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                            `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                            `guid` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                            `revision` int NOT NULL,
                            `id_category` bigint DEFAULT NULL,
                            `id_label` bigint DEFAULT NULL,
                            `id_redazione` bigint DEFAULT NULL,
                            `info_home_page` mediumtext COLLATE utf8mb4_unicode_ci,
                            `lock_owner` bigint DEFAULT NULL,
                            `lock_timestamp` datetime(6) DEFAULT NULL,
                            `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `articles_idx10` (`id_site`,`state`,`slug`,`revision`),
                            UNIQUE KEY `articles_state_idx` (`guid`,`revision`,`state`,`id_site`) USING BTREE,
                            KEY `articles_id_user_creator_users_id` (`id_user_creator`),
                            KEY `articles_id_state_states_id` (`id_state`),
                            KEY `articles_id_site_sites_id` (`id_site`),
                            KEY `articles_id_last_user_editor_users_id` (`id_last_user_editor`),
                            KEY `Reftemplate121` (`id_template`),
                            KEY `articles_idx2` (`date_begin_pubblication`),
                            KEY `articles_idx3` (`date_end_pubblication`),
                            KEY `articles_idx4` (`id_category`),
                            KEY `articles_idx_id_redazione` (`id_redazione`) USING BTREE,
                            KEY `idx_articles_updated_at` (`update_at`),
                            KEY `articles_id_state_idx` (`guid`,`revision`),
                            KEY `articles_idx1` (`guid`),
                            KEY `articles_idx5` (`state`),
                            KEY `articles_slug_idx` (`slug`),
                            FULLTEXT KEY `articles_full_idx_abstract` (`abstract`),
                            FULLTEXT KEY `articles_full_idx_title` (`title`),
                            FULLTEXT KEY `articles_full_idx_subtitle` (`subtitle`),
                            FULLTEXT KEY `articles_full_idx_desc` (`description`),
                            FULLTEXT KEY `total_full_text_idx` (`title`,`subtitle`,`abstract`,`description`),
                            CONSTRAINT `articles_fk_id_redazione` FOREIGN KEY (`id_redazione`) REFERENCES `redazioni` (`id`),
                            CONSTRAINT `Refsites201` FOREIGN KEY (`id_site`) REFERENCES `sites` (`id`),
                            CONSTRAINT `Reftemplate121` FOREIGN KEY (`id_template`) REFERENCES `templates` (`id`),
                            CONSTRAINT `Refusers181` FOREIGN KEY (`id_last_user_editor`) REFERENCES `users` (`id`),
                            CONSTRAINT `Refusers311` FOREIGN KEY (`id_user_creator`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `guid_articles`;
CREATE TABLE `guid_articles` (
                                 `guid` varchar(50) COLLATE utf8mb4_unicode_ci PRIMARY KEY,
                                 `temporary` boolean DEFAULT false
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `articles_comments`;
CREATE TABLE `articles_comments` (
                                     `id` bigint NOT NULL AUTO_INCREMENT,
                                     `inserted_at` datetime NOT NULL,
                                     `guid_article` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                     `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
                                     `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
                                     PRIMARY KEY (`id`),
                                     UNIQUE KEY `id` (`id`),
                                     KEY `inserted_at` (`inserted_at`),
                                     KEY `guid_article` (`guid_article`),
                                     KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `articles_custom_fields`;
CREATE TABLE `articles_custom_fields` (
                                          `id` bigint NOT NULL AUTO_INCREMENT,
                                          `id_article` bigint NOT NULL,
                                          `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                          `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                          `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
                                          `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                                          PRIMARY KEY (`id`) USING BTREE,
                                          UNIQUE KEY `articles_custom_fields_id_article_name` (`id_article`,`name`),
                                          KEY `id_article` (`id_article`) USING BTREE,
                                          KEY `idx_name` (`name`),
                                          FULLTEXT KEY `idx_value` (`value`),
                                          CONSTRAINT `articles_cf_id_article` FOREIGN KEY (`id_article`) REFERENCES `articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `articles_keywords`;
CREATE TABLE `articles_keywords` (
                                     `id` bigint NOT NULL AUTO_INCREMENT,
                                     `id_article` bigint NOT NULL,
                                     `id_keyword` bigint NOT NULL,
                                     `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                                     PRIMARY KEY (`id`),
                                     KEY `articles_keywords_id_keyword_keywords_id` (`id_keyword`) USING BTREE,
                                     KEY `articles_keywords_id_article_articles_id` (`id_article`) USING BTREE,
                                     CONSTRAINT `articles_keywords_fk1` FOREIGN KEY (`id_keyword`) REFERENCES `keywords` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                     CONSTRAINT `articles_keywords_id_article_articles_id` FOREIGN KEY (`id_article`) REFERENCES `articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `articles_resources`;
CREATE TABLE `articles_resources` (
                                      `id` bigint NOT NULL AUTO_INCREMENT,
                                      `id_article` bigint NOT NULL,
                                      `id_resource` bigint NOT NULL,
                                      `COD_EXT` text,
                                      `position` int DEFAULT NULL,
                                      PRIMARY KEY (`id`),
                                      KEY `article_resources_articles_fk` (`id_article`),
                                      KEY `article_resources_static_resources_fk` (`id_resource`),
                                      CONSTRAINT `article_resources_articles_fk` FOREIGN KEY (`id_article`) REFERENCES `articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                      CONSTRAINT `article_resources_static_resources_fk` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;


DROP TABLE IF EXISTS `blocks`;
CREATE TABLE `blocks` (
                          `id` bigint NOT NULL AUTO_INCREMENT,
                          `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                          `title` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
                          `html_code` text COLLATE utf8mb4_unicode_ci,
                          `id_site` bigint DEFAULT NULL,
                          `id_type_block` tinyint NOT NULL DEFAULT '1',
                          `default_block_helper_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                          `dynamic_block_class_name` longtext COLLATE utf8mb4_unicode_ci,
                          `is_visible` tinyint NOT NULL DEFAULT '0',
                          `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                          `id_redazione` bigint DEFAULT NULL,
                          PRIMARY KEY (`id`),
                          KEY `id_type_block` (`id_type_block`),
                          KEY `indice` (`id_site`,`is_visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `blocks_related_articles`;
CREATE TABLE `blocks_related_articles` (
                                           `id` bigint NOT NULL AUTO_INCREMENT,
                                           `id_block` bigint NOT NULL,
                                           `position` int DEFAULT NULL,
                                           `guid_article` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                           `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                                           PRIMARY KEY (`id`),
                                           UNIQUE KEY `id_UNIQUE` (`id`),
                                           KEY `id_block` (`id_block`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
                              `id` bigint NOT NULL AUTO_INCREMENT,
                              `id_parent` bigint NOT NULL,
                              `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                              `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
                              `position` int NOT NULL,
                              `temporary_content` tinyint NOT NULL DEFAULT '0',
                              `url` text COLLATE utf8mb4_unicode_ci,
                              `visibility` tinyint NOT NULL,
                              `id_site` bigint NOT NULL,
                              `guid_article` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                              `guid` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                              `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                              `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                              `template` varchar(255) COLLATE utf8mb4_unicode_ci NULL DEFAULT null,
                              PRIMARY KEY (`id`),
                              KEY `id_article` (`guid_article`),
                              KEY `categories_idx1` (`guid`),
                              KEY `categories_idx2` (`id_parent`),
                              KEY `indice` (`id_site`,`name`),
                              KEY `name` (`name`),
                              KEY `idx2` (`id`,`name`),
                              KEY `id_site` (`id_site`),
                              CONSTRAINT `categories_fk` FOREIGN KEY (`id_site`) REFERENCES `sites` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `ci_sessions`;
CREATE TABLE `ci_sessions` (
                               `id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
                               `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
                               `timestamp` int unsigned NOT NULL DEFAULT '0',
                               `data` mediumblob NOT NULL,
                               PRIMARY KEY (`id`),
                               KEY `ci_sessions_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `communications`;
CREATE TABLE `communications` (
                                  `id` bigint NOT NULL AUTO_INCREMENT,
                                  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                  `area` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                  `content` text COLLATE utf8mb4_unicode_ci,
                                  `visible` tinyint NOT NULL,
                                  PRIMARY KEY (`id`),
                                  KEY `indice` (`area`,`visible`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `custom_fields`;
CREATE TABLE `custom_fields` (
                                 `id` bigint NOT NULL AUTO_INCREMENT,
                                 `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `id_site` bigint NOT NULL,
                                 `display_label` text COLLATE utf8mb4_unicode_ci,
                                 `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                                 PRIMARY KEY (`id`),
                                 KEY `custom_fields_sites_fk` (`id_site`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `emails_queue`;
CREATE TABLE `emails_queue` (
                                `id` bigint NOT NULL AUTO_INCREMENT,
                                `guid_invio` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                `guid_reason` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `dataora_ultimo_tentativo` datetime(6) DEFAULT NULL,
                                `tentativi_falliti` int DEFAULT '0',
                                `dataora_invio` datetime(6) DEFAULT NULL,
                                `email_to` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
                                `email_from` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
                                `email_cc` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `email_ccn` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `soggetto` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
                                `corpo` text COLLATE utf8mb4_unicode_ci NOT NULL,
                                `dataora_creazione` datetime DEFAULT NULL,
                                PRIMARY KEY (`id`),
                                UNIQUE KEY `id` (`id`),
                                UNIQUE KEY `guid_invio` (`guid_invio`),
                                UNIQUE KEY `guid_reason` (`guid_reason`),
                                KEY `idx3` (`dataora_invio`,`tentativi_falliti`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `fsm`;
CREATE TABLE `fsm` (
                       `id` bigint NOT NULL AUTO_INCREMENT,
                       `code` varchar(50) NOT NULL,
                       `description` varchar(100) NOT NULL,
                       `items_table_name` varchar(50) NOT NULL,
                       `items_table_key_field` varchar(50) NOT NULL,
                       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;


DROP TABLE IF EXISTS `fsm_transitions`;
CREATE TABLE `fsm_transitions` (
                                   `id` bigint NOT NULL AUTO_INCREMENT,
                                   `id_fsm` bigint DEFAULT NULL,
                                   `state` varchar(50) NOT NULL,
                                   `input_signal` varchar(50) NOT NULL,
                                   `next_state` varchar(50) NOT NULL,
                                   `guard_class_name` varchar(100) DEFAULT NULL,
                                   `action_class_name` varchar(100) DEFAULT NULL,
                                   `initial` int NOT NULL DEFAULT '0',
                                   `final` int NOT NULL DEFAULT '0',
                                   PRIMARY KEY (`id`),
                                   KEY `id_fsm` (`id_fsm`),
                                   CONSTRAINT `fsm_transitions_fk1` FOREIGN KEY (`id_fsm`) REFERENCES `fsm` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;


DROP TABLE IF EXISTS `keywords`;
CREATE TABLE `keywords` (
                            `id` bigint NOT NULL AUTO_INCREMENT,
                            `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                            `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `labels`;
CREATE TABLE `labels` (
                          `id` bigint NOT NULL AUTO_INCREMENT,
                          `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                          `id_site` bigint NOT NULL,
                          `position` int NOT NULL DEFAULT '1',
                          `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                          PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
                            `id` bigint NOT NULL AUTO_INCREMENT,
                            `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                            PRIMARY KEY (`id`) USING BTREE,
                            UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `profiles_roles`;
CREATE TABLE `profiles_roles` (
                                  `id` bigint NOT NULL AUTO_INCREMENT,
                                  `id_profile` bigint NOT NULL,
                                  `id_role` bigint NOT NULL,
                                  PRIMARY KEY (`id`) USING BTREE,
                                  UNIQUE KEY `id` (`id`) USING BTREE,
                                  UNIQUE KEY `profiles_roles_idx1` (`id_profile`,`id_role`) USING BTREE,
                                  KEY `id_role` (`id_role`) USING BTREE,
                                  KEY `id_profile` (`id_profile`) USING BTREE,
                                  CONSTRAINT `profiles_roles_fk1` FOREIGN KEY (`id_profile`) REFERENCES `profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                                  CONSTRAINT `profiles_roles_fk2` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `redazioni`;
CREATE TABLE `redazioni` (
                             `id` bigint NOT NULL AUTO_INCREMENT,
                             `name` varchar(50) NOT NULL,
                             `description` text NOT NULL,
                             `id_site` bigint NOT NULL,
                             `guid` varchar(50) DEFAULT NULL,
                             `email` varchar(100) DEFAULT NULL,
                             `COD_EXT` text,
                             PRIMARY KEY (`id`),
                             KEY `id_site` (`id_site`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;


DROP TABLE IF EXISTS `redazioni_categories`;
CREATE TABLE `redazioni_categories` (
                                        `id` bigint NOT NULL AUTO_INCREMENT,
                                        `id_redazione` bigint NOT NULL,
                                        `id_category` bigint NOT NULL,
                                        `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                                        PRIMARY KEY (`id`),
                                        KEY `id_category` (`id_category`),
                                        KEY `id_redazione` (`id_redazione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `related_articles`;
CREATE TABLE `related_articles` (
                                    `id` bigint NOT NULL AUTO_INCREMENT,
                                    `id_article` bigint NOT NULL,
                                    `guid_article_rel` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `position` int DEFAULT NULL,
                                    `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE KEY `id` (`id`) USING BTREE,
                                    KEY `related_articles_idx1` (`guid_article_rel`,`id_article`) USING BTREE,
                                    KEY `id_article` (`id_article`),
                                    KEY `guid_article_rel` (`guid_article_rel`),
                                    CONSTRAINT `related_articles_fk_guid_article` FOREIGN KEY (`guid_article_rel`) REFERENCES `articles` (`guid`) ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `related_articles_fk_id_article` FOREIGN KEY (`id_article`) REFERENCES `articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
                             `id` bigint NOT NULL AUTO_INCREMENT,
                             `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                             `original_filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                             `folder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `link_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `caption` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                             `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
                             `visibility` tinyint NOT NULL,
                             `date_creation` date NOT NULL,
                             `filesize` int NOT NULL,
                             `res_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
                             `fileext` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `id_redazione` bigint DEFAULT NULL,
                             `copyright` tinyint NOT NULL,
                             `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                             PRIMARY KEY (`id`),
                             KEY `folder` (`folder`),
                             KEY `filename` (`filename`),
                             FULLTEXT KEY `idx_resources_fulltext` (`filename`,`caption`,`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `resources_rassegna`;
CREATE TABLE `resources_rassegna` (
                                      `id` bigint NOT NULL AUTO_INCREMENT,
                                      `tipologia` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `guid` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `descrizione` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `filepath` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `data_rassegna` date NOT NULL,
                                      PRIMARY KEY (`id`),
                                      UNIQUE KEY `tipologia_data_target` (`tipologia`,`data_rassegna`),
                                      KEY `data_rassegna` (`data_rassegna`),
                                      FULLTEXT KEY `tipologia` (`tipologia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `richieste_attivazione`;
CREATE TABLE `richieste_attivazione` (
                                         `id` bigint NOT NULL AUTO_INCREMENT,
                                         `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `guid_richiesta` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `cognomenome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
                                         `stato` tinyint NOT NULL,
                                         `dataora_richiesta` datetime(6) NOT NULL,
                                         `tipo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                         PRIMARY KEY (`id`),
                                         UNIQUE KEY `id` (`id`),
                                         UNIQUE KEY `guid_richiesta` (`guid_richiesta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
                         `id` bigint NOT NULL AUTO_INCREMENT,
                         `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                         `type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `sites`;
CREATE TABLE `sites` (
                         `id` bigint NOT NULL AUTO_INCREMENT,
                         `name` varchar(70) NOT NULL,
                         `private` tinyint NOT NULL,
                         `httpbase` varchar(100) NOT NULL,
                         `ftpbase` varchar(100) NOT NULL,
                         `urlimages` varchar(255) DEFAULT NULL,
                         `urldocuments` varchar(255) DEFAULT NULL,
                         `COD_EXT` text,
                         `console_httpbase` varchar(255) DEFAULT NULL,
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `id` (`id`),
                         KEY `id_2` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;


DROP TABLE IF EXISTS `templates`;
CREATE TABLE `templates` (
                             `id` bigint NOT NULL AUTO_INCREMENT,
                             `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                             `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                             `id_site` bigint NOT NULL,
                             `note` text COLLATE utf8mb4_unicode_ci,
                             `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                             `visibile_utente` tinyint(1) NOT NULL DEFAULT '1',
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `templates_blocks`;
CREATE TABLE `templates_blocks` (
                                    `id` bigint NOT NULL AUTO_INCREMENT,
                                    `id_template` bigint NOT NULL,
                                    `id_block` bigint NOT NULL,
                                    `block_helper_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                    `is_visible` tinyint NOT NULL DEFAULT '0',
                                    `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                                    PRIMARY KEY (`id`),
                                    UNIQUE KEY `id_UNIQUE` (`id`),
                                    KEY `id_block` (`id_block`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `typeblocks`;
CREATE TABLE `typeblocks` (
                              `id` bigint NOT NULL AUTO_INCREMENT,
                              `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                              PRIMARY KEY (`id`),
                              KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
                         `id` bigint NOT NULL AUTO_INCREMENT,
                         `id_redazione` bigint DEFAULT NULL,
                         `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
                         `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                         `cognomenome` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         `mail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         `telefono` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         `isDelete` tinyint NOT NULL,
                         `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                         `last_login` datetime(6) DEFAULT CURRENT_TIMESTAMP(6),
                         `last_pwd_updated` datetime(6) DEFAULT CURRENT_TIMESTAMP(6),
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `users_idx_username` (`username`),
                         KEY `users_id_group_groups_id` (`id_redazione`),
                         KEY `users_id_group_reda_id` (`id_redazione`),
                         CONSTRAINT `RefRedazioni` FOREIGN KEY (`id_redazione`) REFERENCES `redazioni` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `users_roles`;
CREATE TABLE `users_roles` (
                               `id` bigint NOT NULL AUTO_INCREMENT,
                               `id_user` bigint NOT NULL,
                               `id_role` bigint NOT NULL,
                               `id_site` bigint DEFAULT NULL,
                               `id_redazione` bigint DEFAULT NULL,
                               `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                               PRIMARY KEY (`id`),
                               KEY `id_user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `config`;
create table config (
                                `option` varchar(50) COLLATE utf8mb4_unicode_ci not null,
                                `value` json not null,
                                primary key (`option`)
) engine = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE DATABASE `fe_doppiavela` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fe_doppiavela`;

DROP TABLE IF EXISTS `bacheca_categorie_oggetti`;
CREATE TABLE `bacheca_categorie_oggetti` (
                                             `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                                             `descrizione` text COLLATE utf8mb4_unicode_ci NOT NULL,
                                             `ordine` bigint DEFAULT NULL,
                                             `attivo` char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no',
                                             `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                                             PRIMARY KEY (`id`),
                                             KEY `attivo` (`attivo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `bacheca_oggetti`;
CREATE TABLE `bacheca_oggetti` (
                                   `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                                   `perid` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '0',
                                   `guid` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                   `data_inserimento` datetime DEFAULT CURRENT_TIMESTAMP,
                                   `nominativo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '0',
                                   `id_categoria` bigint NOT NULL,
                                   `tipo` int NOT NULL,
                                   `descrizione` text COLLATE utf8mb4_unicode_ci NOT NULL,
                                   `contatto` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
                                   `citta` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
                                   `approvato` char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no',
                                   `datascadenza` datetime DEFAULT NULL,
                                   `finito` char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no',
                                   `prezzo` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
                                   `visite` bigint NOT NULL DEFAULT '0',
                                   `titolo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
                                   `perid_ultima_modifica` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                   `data_ultima_modifica` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                   `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                                   PRIMARY KEY (`id`),
                                   UNIQUE KEY `indice` (`tipo`,`approvato`,`datascadenza`,`finito`,`id`),
                                   FULLTEXT KEY `bacheca_oggetti_idx_nominativo` (`nominativo`),
                                   FULLTEXT KEY `bacheca_oggetti_idx1` (`descrizione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `commenti_utenti`;
CREATE TABLE `commenti_utenti` (
                                   `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                                   `perid` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '0',
                                   `guid_articolo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                   `commento` text COLLATE utf8mb4_unicode_ci NOT NULL,
                                   `nominativo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
                                   `data_commento` datetime DEFAULT CURRENT_TIMESTAMP,
                                   `COD_EXT` text COLLATE utf8mb4_unicode_ci,
                                   `is_cancellato_da_utente` int NOT NULL DEFAULT '0',
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `contenuti_proposti`;
CREATE TABLE `contenuti_proposti` (
                                      `id` bigint NOT NULL AUTO_INCREMENT,
                                      `id_tipo_contenuto` bigint NOT NULL,
                                      `perid` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `titolo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `testo` text COLLATE utf8mb4_unicode_ci,
                                      `approvato` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
                                      `guid_contenuto` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                      `guid_art_gen` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                      `nominativo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                      `data_inserimento` datetime(6) NOT NULL,
                                      PRIMARY KEY (`id`) USING BTREE,
                                      UNIQUE KEY `id` (`id`) USING BTREE,
                                      UNIQUE KEY `guid_articolo` (`guid_contenuto`) USING BTREE,
                                      UNIQUE KEY `guid_art_gen` (`guid_art_gen`),
                                      KEY `id_tipo_contenuto` (`id_tipo_contenuto`) USING BTREE,
                                      FULLTEXT KEY `contenuti_proposti_idx_nom_full` (`nominativo`),
                                      FULLTEXT KEY `contenuti_proposti_idx_testo_full` (`testo`),
                                      CONSTRAINT `proponi_contenuti_fk1` FOREIGN KEY (`id_tipo_contenuto`) REFERENCES `tipi_contenuti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `corsi`;
CREATE TABLE `corsi` (
                         `id` bigint NOT NULL AUTO_INCREMENT,
                         `numero` varchar(20) NOT NULL,
                         `id_citta` bigint DEFAULT NULL,
                         `id_tipo` bigint DEFAULT NULL,
                         `descrizione` text,
                         `COD_EXT` text,
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `id` (`id`),
                         UNIQUE KEY `corsi_idx1` (`numero`,`id_citta`,`id_tipo`),
                         KEY `id_citta` (`id_citta`),
                         KEY `id_tipologia` (`id_tipo`),
                         CONSTRAINT `corsi_fk1` FOREIGN KEY (`id_citta`) REFERENCES `corsi_citta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                         CONSTRAINT `corsi_fk2` FOREIGN KEY (`id_tipo`) REFERENCES `corsi_tipo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 PACK_KEYS=0;


DROP TABLE IF EXISTS `corsi_citta`;
CREATE TABLE `corsi_citta` (
                               `id` bigint NOT NULL AUTO_INCREMENT,
                               `descrizione` varchar(50) NOT NULL,
                               `COD_EXT` text,
                               PRIMARY KEY (`id`),
                               UNIQUE KEY `id` (`id`),
                               UNIQUE KEY `descrzione` (`descrizione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 PACK_KEYS=0;


DROP TABLE IF EXISTS `corsi_elenco_corsisti`;
CREATE TABLE `corsi_elenco_corsisti` (
                                         `id` bigint NOT NULL AUTO_INCREMENT,
                                         `id_corso` bigint NOT NULL,
                                         `perid` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
                                         `nominativo` varchar(255) DEFAULT NULL,
                                         `COD_EXT` text,
                                         PRIMARY KEY (`id`),
                                         UNIQUE KEY `id` (`id`),
                                         UNIQUE KEY `corsi_elenco_corsisti_idx1` (`perid`,`id_corso`),
                                         KEY `id_corso` (`id_corso`),
                                         CONSTRAINT `corsi_elenco_corsisti_fk1` FOREIGN KEY (`id_corso`) REFERENCES `corsi` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 PACK_KEYS=0;


DROP TABLE IF EXISTS `corsi_tipo`;
CREATE TABLE `corsi_tipo` (
                              `id` bigint NOT NULL AUTO_INCREMENT,
                              `descrizione` varchar(100) NOT NULL,
                              `ordine` int DEFAULT NULL,
                              `id_tipologia` bigint DEFAULT NULL,
                              `COD_EXT` tinytext,
                              PRIMARY KEY (`id`),
                              UNIQUE KEY `id` (`id`),
                              KEY `id_tipologia` (`id_tipologia`),
                              CONSTRAINT `corsi_tipo_fk1` FOREIGN KEY (`id_tipologia`) REFERENCES `corsi_tipologia` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 PACK_KEYS=0;


DROP TABLE IF EXISTS `corsi_tipologia`;
CREATE TABLE `corsi_tipologia` (
                                   `id` bigint NOT NULL AUTO_INCREMENT,
                                   `descrizione` varchar(80) NOT NULL,
                                   `COD_EXT` text,
                                   PRIMARY KEY (`id`),
                                   UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 PACK_KEYS=0;


DROP TABLE IF EXISTS `emails_queue`;
CREATE TABLE `emails_queue` (
                                `id` bigint NOT NULL AUTO_INCREMENT,
                                `guid_invio` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                `guid_reason` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `dataora_ultimo_tentativo` datetime(6) DEFAULT NULL,
                                `tentativi_falliti` int DEFAULT '0',
                                `dataora_invio` datetime(6) DEFAULT NULL,
                                `email_to` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
                                `email_from` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
                                `email_cc` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `email_ccn` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `soggetto` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
                                `corpo` text COLLATE utf8mb4_unicode_ci NOT NULL,
                                `dataora_creazione` datetime DEFAULT NULL,
                                PRIMARY KEY (`id`),
                                UNIQUE KEY `id` (`id`),
                                UNIQUE KEY `guid_invio` (`guid_invio`),
                                UNIQUE KEY `guid_reason` (`guid_reason`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `reparti_operativi`;
CREATE TABLE `reparti_operativi` (
                                     `COD_REP_OPER` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                     `REP_DESC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                     `COD_SEZ_OPER` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                     `SEZ_DESC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                     `SGL_PR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                     `REGIONE` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                     `COD_SPEC_OPER` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                     `DAT_INI_VAL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                     `DAT_FIN_VAL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                     `id` int NOT NULL AUTO_INCREMENT,
                                     `COMUNE_SEZ_OPER` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                     PRIMARY KEY (`id`),
                                     KEY `idx` (`COD_REP_OPER`) USING BTREE,
                                     KEY `idx2` (`COD_SEZ_OPER`) USING BTREE,
                                     KEY `cod_sez` (`COD_SEZ_OPER`),
                                     KEY `desc_sez` (`SEZ_DESC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `risorse_contenuti_proposti`;
CREATE TABLE `risorse_contenuti_proposti` (
                                              `id` bigint NOT NULL AUTO_INCREMENT,
                                              `guid_contenuto` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                              `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                              `filesize` int DEFAULT NULL,
                                              PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `sndg_domande`;
CREATE TABLE `sndg_domande` (
                                `id` bigint NOT NULL AUTO_INCREMENT,
                                `id_sondaggio` bigint unsigned NOT NULL DEFAULT '0',
                                `testo` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
                                `tipo_risposta` int NOT NULL DEFAULT '0',
                                `numero_domanda` int NOT NULL DEFAULT '0',
                                PRIMARY KEY (`id`),
                                KEY `FK_sndg_domande_sndg_sondaggi` (`id_sondaggio`),
                                CONSTRAINT `FK_sndg_domande_sndg_sondaggi` FOREIGN KEY (`id_sondaggio`) REFERENCES `sndg_sondaggi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `sndg_domande_opzioni`;
CREATE TABLE `sndg_domande_opzioni` (
                                        `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                                        `id_domanda` bigint NOT NULL,
                                        `testo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                        PRIMARY KEY (`id`),
                                        KEY `FK_sndg_domande_opzioni_sndg_domande` (`id_domanda`),
                                        CONSTRAINT `FK_sndg_domande_opzioni_sndg_domande` FOREIGN KEY (`id_domanda`) REFERENCES `sndg_domande` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `sndg_risposte`;
CREATE TABLE `sndg_risposte` (
                                 `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                                 `id_opzione` bigint unsigned NOT NULL DEFAULT '0',
                                 `risposta_valore` bigint NOT NULL DEFAULT '0',
                                 `risposta_testo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '0',
                                 `perid` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '0',
                                 PRIMARY KEY (`id`),
                                 KEY `FK_sndg_risposte_sndg_domande_opzioni` (`id_opzione`),
                                 FULLTEXT KEY `sndg_risposte_testo_fullidx` (`risposta_testo`),
                                 CONSTRAINT `FK_sndg_risposte_sndg_domande_opzioni` FOREIGN KEY (`id_opzione`) REFERENCES `sndg_domande_opzioni` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


DROP TABLE IF EXISTS `sndg_sondaggi`;
CREATE TABLE `sndg_sondaggi` (
                                 `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                                 `titolo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `attivo` tinyint DEFAULT '0',
                                 `data_inizio` datetime DEFAULT NULL,
                                 `data_fine` datetime DEFAULT NULL,
                                 `guid` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                 `votanti` int NOT NULL DEFAULT '0',
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `idx_guid_sondaggi` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `tipi_contenuti`;
CREATE TABLE `tipi_contenuti` (
                                  `id` bigint NOT NULL AUTO_INCREMENT,
                                  `macro_categoria` varchar(50) NOT NULL,
                                  `categoria` varchar(50) NOT NULL,
                                  `guid_redazione` varchar(50) NOT NULL,
                                  `guid_categoria` varchar(50) NOT NULL,
                                  PRIMARY KEY (`id`) USING BTREE,
                                  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='macro categoria, categoria, guid redazione, guid categoria';


DROP TABLE IF EXISTS `utenti`;
CREATE TABLE `utenti` (
                          `id` bigint NOT NULL AUTO_INCREMENT,
                          `perid` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
                          `is_delete` tinyint NOT NULL,
                          `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
                          `nome` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
                          `cognome` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
                          `password` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
                          `last_login` datetime DEFAULT NULL,
                          `last_password_update` datetime DEFAULT NULL,
                          `telefono_ufficio` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                          `interno_diretto` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                          `cellulare_servizio` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                          `cellulare_personale` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                          `telefono_abitazione` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                          `dettagli_personali` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
                          `fax` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                          `sito_web` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                          `guid` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                          `ufficio` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
                          `data_nascita` date DEFAULT NULL,
                          `ruolo` int DEFAULT NULL,
                          PRIMARY KEY (`id`) USING BTREE,
                          UNIQUE KEY `id` (`id`) USING BTREE,
                          UNIQUE KEY `email` (`email`) USING BTREE,
                          UNIQUE KEY `perid` (`perid`) USING BTREE,
                          FULLTEXT KEY `utenti_perid_idx` (`perid`),
                          FULLTEXT KEY `utenti_email_idx` (`email`),
                          FULLTEXT KEY `utenti_nome_idx` (`nome`),
                          FULLTEXT KEY `utenti_cognome_idx` (`cognome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
                         `id` bigint NOT NULL AUTO_INCREMENT,
                         `titolo` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '0',
                         `descrizione` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '0',
                         `filename` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '0',
                         `ultimo_aggiornamento` datetime NOT NULL,
                         PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


CREATE DATABASE `fe_poliziadistato` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fe_poliziadistato`;

DROP TABLE IF EXISTS `ci_comunicate`;
CREATE TABLE `ci_comunicate` (
                                 `id` int NOT NULL AUTO_INCREMENT,
                                 `nome` varchar(255) DEFAULT NULL,
                                 `cognome` varchar(255) DEFAULT NULL,
                                 `telefono` varchar(255) DEFAULT NULL,
                                 `email` varchar(255) DEFAULT NULL,
                                 `comune` varchar(255) DEFAULT NULL,
                                 `provincia` varchar(255) DEFAULT NULL,
                                 `categoria` varchar(255) DEFAULT NULL,
                                 `messaggio` text,
                                 `ip` varchar(18) DEFAULT NULL,
                                 `data` varchar(10) NOT NULL DEFAULT '',
                                 `ora` varchar(14) NOT NULL DEFAULT '',
                                 `copiato` enum('N','Y') DEFAULT 'N',
                                 `trpId` int unsigned DEFAULT '0',
                                 `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                 PRIMARY KEY (`id`),
                                 KEY `timestamp` (`ip`,`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `datistradale`;
CREATE TABLE `datistradale` (
                                `id` int NOT NULL AUTO_INCREMENT,
                                `data_ril` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `nome_file` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `inc_ril_a` int unsigned DEFAULT '0',
                                `inc_mort_a` int unsigned DEFAULT '0',
                                `inc_feri_a` int unsigned DEFAULT '0',
                                `inc_dann_a` int unsigned DEFAULT '0',
                                `per_mort_a` int unsigned DEFAULT '0',
                                `per_feri_a` int unsigned DEFAULT '0',
                                `inf_vele_a` int unsigned DEFAULT '0',
                                `inf_ecve_a` int unsigned DEFAULT '0',
                                `inf_casc_a` int unsigned DEFAULT '0',
                                `inf_cint_a` int unsigned DEFAULT '0',
                                `inf_alco_a` int unsigned DEFAULT '0',
                                `inf_stup_a` int unsigned DEFAULT '0',
                                `inf_com_a` int unsigned DEFAULT '0',
                                `att_socc_a` int unsigned DEFAULT '0',
                                `inc_ril` int unsigned DEFAULT '0',
                                `inc_mort` int unsigned DEFAULT '0',
                                `inc_feri` int unsigned DEFAULT '0',
                                `inc_dann` int unsigned DEFAULT '0',
                                `per_mort` int unsigned DEFAULT '0',
                                `per_feri` int unsigned DEFAULT '0',
                                `inf_vele` int unsigned DEFAULT '0',
                                `inf_ecve` int unsigned DEFAULT '0',
                                `inf_casc` int unsigned DEFAULT '0',
                                `inf_cint` int unsigned DEFAULT '0',
                                `inf_alco` int unsigned DEFAULT '0',
                                `inf_stup` int unsigned DEFAULT '0',
                                `inf_com` int unsigned DEFAULT '0',
                                `att_socc` int unsigned DEFAULT '0',
                                `pubblicato` int unsigned NOT NULL DEFAULT '0',
                                `data_agg` date NOT NULL DEFAULT '0000-00-00',
                                `tot_pattuglie_a` int DEFAULT '0',
                                `tot_pattuglie_ss` int DEFAULT '0',
                                `gare_a` int DEFAULT '0',
                                `gare_ss` int DEFAULT '0',
                                `luci_a` int DEFAULT '0',
                                `luci_ss` int DEFAULT '0',
                                `auricolare_a` int DEFAULT '0',
                                `auricolare_ss` int DEFAULT '0',
                                `sanzione_patente` int DEFAULT '0',
                                `sanzione_carta` int DEFAULT '0',
                                `sanzione_punti` int DEFAULT '0',
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;


CREATE DATABASE `fe_poliziamoderna` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fe_poliziamoderna`;

DROP TABLE IF EXISTS `emails_queue`;
CREATE TABLE `emails_queue` (
                                `id` bigint NOT NULL AUTO_INCREMENT,
                                `guid_invio` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                `guid_reason` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `dataora_ultimo_tentativo` datetime(6) DEFAULT NULL,
                                `tentativi_falliti` int DEFAULT '0',
                                `dataora_invio` datetime(6) DEFAULT NULL,
                                `email_to` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
                                `email_from` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
                                `email_cc` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `email_ccn` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                `soggetto` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
                                `corpo` text COLLATE utf8mb4_unicode_ci NOT NULL,
                                `dataora_creazione` datetime DEFAULT NULL,
                                PRIMARY KEY (`id`) USING BTREE,
                                UNIQUE KEY `id` (`id`) USING BTREE,
                                UNIQUE KEY `guid_invio` (`guid_invio`) USING BTREE,
                                UNIQUE KEY `guid_reason` (`guid_reason`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `tab_utenti`;
CREATE TABLE `tab_utenti` (
                              `userid` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
                              `password` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
                              `nome` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
                              `cognome` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
                              `email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
                              `cod_gruppo` int NOT NULL DEFAULT '0',
                              PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE DATABASE `fe_questure` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fe_questure`;

DROP TABLE IF EXISTS `cms_oggetti`;
CREATE TABLE `cms_oggetti` (
                               `id` bigint NOT NULL AUTO_INCREMENT,
                               `id_questura` bigint NOT NULL,
                               `data_creazione` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
                               `data_ultimo_aggiornamento` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
                               `data_furto` datetime DEFAULT NULL,
                               `data_ritrovamento` datetime DEFAULT NULL,
                               `id_categoria` bigint NOT NULL,
                               `titolo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                               `titolo_breve` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                               `descrizione` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
                               `note_interne` longtext COLLATE utf8mb4_unicode_ci,
                               `note_ritrovamento` longtext COLLATE utf8mb4_unicode_ci,
                               `contatto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                               `pubblicato` tinyint NOT NULL DEFAULT '0',
                               `bloccato` tinyint NOT NULL DEFAULT '0',
                               `riferimento` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                               `id_marca` int DEFAULT NULL,
                               `id_modello` int DEFAULT NULL,
                               `ritrovato` tinyint DEFAULT NULL,
                               `assicurato` tinyint DEFAULT NULL,
                               `valore_dichiarato` float(13,5) DEFAULT NULL,
                               `id_contatto` int DEFAULT NULL,
                               `id_proprietario` int DEFAULT NULL,
                               `guid_articolo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                               PRIMARY KEY (`id`) USING BTREE,
                               UNIQUE KEY `id` (`id`) USING BTREE,
                               KEY `id_categoria` (`id_categoria`) USING BTREE,
                               KEY `id_questura` (`id_questura`) USING BTREE,
                               KEY `pubblicato` (`pubblicato`) USING BTREE,
                               KEY `ritrovato` (`ritrovato`) USING BTREE,
                               FULLTEXT KEY `ricerche` (`descrizione`,`titolo`,`titolo_breve`),
                               FULLTEXT KEY `note_ritrovamento` (`note_ritrovamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `cms_orari`;
CREATE TABLE `cms_orari` (
                             `id` bigint NOT NULL AUTO_INCREMENT,
                             `lun_am` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `lun_pm` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `mar_am` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `mar_pm` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `mer_am` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `mer_pm` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `gio_am` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `gio_pm` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `ven_am` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `ven_pm` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `sab_am` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `sab_pm` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `dom_am` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `dom_pm` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `cod_ext` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             PRIMARY KEY (`id`) USING BTREE,
                             UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `cms_questure`;
CREATE TABLE `cms_questure` (
                                `id` bigint NOT NULL AUTO_INCREMENT,
                                `descrizione` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
                                `cms_code` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
                                `dati_trasparenza` JSON NULL,
                                `cod_ext` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                PRIMARY KEY (`id`) USING BTREE,
                                UNIQUE KEY `id` (`id`) USING BTREE,
                                UNIQUE KEY `cms_code` (`cms_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `cms_tipi_ufficio`;
CREATE TABLE `cms_tipi_ufficio` (
                                    `id` bigint NOT NULL AUTO_INCREMENT,
                                    `descrizione` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                    `cod_ext` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `cms_uffici`;
CREATE TABLE `cms_uffici` (
                              `id` bigint NOT NULL AUTO_INCREMENT,
                              `id_questura` bigint NOT NULL,
                              `id_tipo_ufficio` bigint NOT NULL,
                              `id_orario` bigint DEFAULT NULL,
                              `id_comune` bigint DEFAULT NULL,
                              `descrizione` varchar(255) DEFAULT NULL,
                              `position` int DEFAULT NULL,
                              `indirizzo` varchar(250) DEFAULT NULL,
                              `cap` varchar(5) DEFAULT NULL,
                              `telefono` varchar(50) DEFAULT NULL,
                              `fax` varchar(50) DEFAULT NULL,
                              `email` varchar(255) DEFAULT NULL,
                              `note` longtext,
                              `longitudine` double DEFAULT NULL,
                              `latitudine` double DEFAULT NULL,
                              `visibile` int DEFAULT NULL,
                              `testo_html` varchar(255) DEFAULT NULL,
                              `facebook` varchar(255) DEFAULT NULL,
                              `twitter` varchar(255) DEFAULT NULL,
                              PRIMARY KEY (`id`) USING BTREE,
                              UNIQUE KEY `id` (`id`) USING BTREE,
                              KEY `FK_cms_uffici_cms_questure` (`id_questura`),
                              KEY `FK_cms_uffici_cms_tipi_ufficio` (`id_tipo_ufficio`),
                              KEY `FK_cms_uffici_cms_orari` (`id_orario`),
                              KEY `FK_cms_uffici_cms_comuni` (`id_comune`),
                              CONSTRAINT `FK_cms_uffici_cms_orari` FOREIGN KEY (`id_orario`) REFERENCES `cms_orari` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                              CONSTRAINT `FK_cms_uffici_cms_questure` FOREIGN KEY (`id_questura`) REFERENCES `cms_questure` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                              CONSTRAINT `FK_cms_uffici_cms_tipi_ufficio` FOREIGN KEY (`id_tipo_ufficio`) REFERENCES `cms_tipi_ufficio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                              CONSTRAINT `FK_cms_uffici_tabcomuni` FOREIGN KEY (`id_comune`) REFERENCES `tabcomuni` (`comID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;


DROP TABLE IF EXISTS `oggetti_altrefoto`;
CREATE TABLE `oggetti_altrefoto` (
                                     `id_oggetto` bigint NOT NULL DEFAULT '0',
                                     `filename` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                     `position` int NOT NULL DEFAULT '1',
                                     `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                     `COD_EXT` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                     PRIMARY KEY (`id_oggetto`,`filename`),
                                     KEY `filename` (`filename`),
                                     KEY `id_oggetto` (`id_oggetto`),
                                     KEY `COD_EXT` (`COD_EXT`),
                                     CONSTRAINT `oggetti_altrefoto_ibfk_1` FOREIGN KEY (`id_oggetto`) REFERENCES `cms_oggetti` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `stradarioroma`;
CREATE TABLE `stradarioroma` (
                                 `ID` int NOT NULL AUTO_INCREMENT,
                                 `Nome Strada` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                 `Toponimia` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                 `Dalla via` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                 `Alla via` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                 `Dal civico` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                 `Al civico` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                 `Dal civico2` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                 `Al civico2` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                 `Competenza` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                 PRIMARY KEY (`ID`),
                                 FULLTEXT KEY `strada` (`Nome Strada`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `tabcategorieoggettirubati`;
CREATE TABLE `tabcategorieoggettirubati` (
                                             `catId` bigint NOT NULL DEFAULT '0',
                                             `catDescrizione` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                             PRIMARY KEY (`catId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `tabcomuni`;
CREATE TABLE `tabcomuni` (
                             `comID` bigint NOT NULL DEFAULT '0',
                             `comComune` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `comProvincia` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `comCodiceFiscale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `comCAP` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `comPrefisso` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `comDistanza` int DEFAULT NULL,
                             `comRegione` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             `comArea` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                             PRIMARY KEY (`comID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2023-07-07 07:30:30