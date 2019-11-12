-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: 192.168.7.24    Database: site_info_client
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.16.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `_addresses`
--

USE clients_db;

DROP TABLE IF EXISTS `_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_addresses` (
  `id` int(11) NOT NULL,
  `street_meaning` int(11) NOT NULL COMMENT 'id улицы из справочника улиц',
  `dom` text NOT NULL COMMENT 'номер дома',
  `podezd` text NOT NULL COMMENT 'номер подъезда',
  `zhk` int(11) DEFAULT NULL COMMENT 'id ЖК'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='таблица адресов (улица, подъезд)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_addresses_obyects`
--

DROP TABLE IF EXISTS `_addresses_obyects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_addresses_obyects` (
  `id` int(11) DEFAULT NULL,
  `aid` int(11) DEFAULT NULL COMMENT 'id записи адреса',
  `oid` int(11) DEFAULT NULL COMMENT 'id записи объекта',
  `pids` text NOT NULL COMMENT 'массив id техников обслуживающих обьекты',
  `archive` int(11) NOT NULL DEFAULT '0' COMMENT 'удалено'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='таблица адресов и объектов по ним';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_anket`
--

DROP TABLE IF EXISTS `_anket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_anket` (
  `aid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id анкеты',
  `name` text NOT NULL COMMENT 'название анкеты',
  `is_form` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0-анкета, 1-форма',
  `archive` tinyint(4) DEFAULT '0' COMMENT '1 - удалено',
  `cid` int(11) DEFAULT NULL,
  `amo_crm_id` int(11) DEFAULT NULL,
  `pipeline_id` int(11) DEFAULT NULL COMMENT 'for amo',
  `status_id` int(11) DEFAULT NULL COMMENT 'for amo',
  `user_id` int(11) DEFAULT NULL COMMENT 'for amo',
  `personal_id` int(11) DEFAULT NULL COMMENT 'for amo',
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=51 COMMENT='таблица анкеты, содержит поля анкет ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_anket_fields`
--

DROP TABLE IF EXISTS `_anket_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_anket_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aid` int(11) NOT NULL COMMENT 'id анкеты',
  `name` text NOT NULL COMMENT 'название поля',
  `commentary` text,
  `custom_id` text COMMENT 'amo custom id',
  `custom_multy` tinyint(4) DEFAULT '0' COMMENT 'amo multiply',
  `custom_values` text COMMENT 'amo enum',
  `custom_type` int(11) DEFAULT '0' COMMENT 'amo custom type',
  `type` text NOT NULL COMMENT 'тип поля - text, phone, fio, calendar, enum',
  `autofill` tinyint(4) DEFAULT '0' COMMENT '1-автозаполнение (для fio, calendar, phone)',
  `order` int(11) NOT NULL COMMENT 'порядок поля в анкете',
  `for_task` int(11) DEFAULT '0' COMMENT 'для формы - поле в заявку',
  `for_tehnik` int(11) DEFAULT '0' COMMENT 'для формы - поле технику',
  `archive` tinyint(4) DEFAULT '0' COMMENT '1-deleted',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=122 COMMENT='таблица полей анкеты';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_anket_values`
--

DROP TABLE IF EXISTS `_anket_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_anket_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL COMMENT 'id компании',
  `tid` int(11) NOT NULL COMMENT 'id task в которой анкета',
  `oid` int(11) DEFAULT NULL COMMENT 'oid обьекта',
  `aid` int(11) NOT NULL COMMENT 'id анкеты',
  `fid` int(11) NOT NULL COMMENT 'id поля анкеты',
  `order` int(11) NOT NULL COMMENT 'порядок поля в анкете',
  `name` text NOT NULL COMMENT 'название поля в анкете',
  `val` text COMMENT 'значение поля в анкете',
  `archive` tinyint(4) DEFAULT '0' COMMENT '1-deleted',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13936 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=67 COMMENT='таблица значений заполненных полей анкет';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_atable1`
--

DROP TABLE IF EXISTS `_atable1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_atable1` (
  `id1` varchar(255) DEFAULT NULL,
  `id2` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_call`
--

DROP TABLE IF EXISTS `_call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_call` (
  `call_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID звонка',
  `callx` varchar(255) DEFAULT '0' COMMENT 'ID Infinity',
  `from` varchar(255) DEFAULT '0' COMMENT 'Номер клиента',
  `to` varchar(255) DEFAULT '0' COMMENT 'Номер компании',
  `transfer` varchar(255) DEFAULT '0' COMMENT 'Перенаправлен',
  `cid` int(11) DEFAULT '0' COMMENT 'Компания',
  `did` int(11) DEFAULT '0' COMMENT 'ID компании в Справочнике',
  `tid` int(11) DEFAULT '0' COMMENT 'ID заявки',
  `uid` int(11) DEFAULT '0' COMMENT 'ID пользователя',
  `status` tinyint(1) DEFAULT '0' COMMENT 'Статус',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата добавления',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор',
  UNIQUE KEY `call_id` (`call_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Звонки в компании';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_call_handler`
--

DROP TABLE IF EXISTS `_call_handler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_call_handler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uidX` text,
  `id_seanse` text,
  `id_call` text,
  `number` text,
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=127 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=39 COMMENT='таблица входящих вызовов для операторов с IP телефонами';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_call_history`
--

DROP TABLE IF EXISTS `_call_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_call_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` text,
  `extension` text,
  `id_call` text,
  `number` text,
  `state` text,
  `direction` text,
  `id_seanse` text,
  `dts` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=749793 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=78 COMMENT='история звонков';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_client`
--

DROP TABLE IF EXISTS `_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_client` (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'Компания',
  `did` int(11) DEFAULT '0' COMMENT 'ID в справочнике',
  `pid` int(11) DEFAULT '0' COMMENT 'Персонал',
  `lc_aec` int(11) DEFAULT NULL COMMENT 'АЕС',
  `lc_erc` int(11) DEFAULT NULL COMMENT 'ЕРЦ',
  `phone` varchar(255) DEFAULT NULL COMMENT 'Телефон',
  `name` varchar(255) DEFAULT NULL COMMENT 'ФИО',
  `info` varchar(255) DEFAULT NULL COMMENT 'Описание, должность, компания, коментарий',
  `city_meaning` int(11) DEFAULT '3' COMMENT 'Префикс населённого пункта',
  `city` varchar(255) DEFAULT 'Астана' COMMENT 'Населённого пункта',
  `street_meaning` varchar(255) DEFAULT NULL COMMENT 'Префикс улицы',
  `street` varchar(255) DEFAULT NULL COMMENT 'Улица',
  `street_old` varchar(255) DEFAULT NULL COMMENT 'Улица (старое)',
  `dom` varchar(20) DEFAULT NULL COMMENT 'Номер строения',
  `dom_old` varchar(20) DEFAULT NULL COMMENT 'Номер (старый)',
  `podezd` varchar(10) DEFAULT NULL COMMENT 'Подъезд',
  `podezd_kv` varchar(10) DEFAULT NULL COMMENT 'Квартиры подъезда',
  `kv` varchar(10) DEFAULT NULL COMMENT 'Квартира',
  `zhk` varchar(255) DEFAULT NULL COMMENT 'Жилой комплекс',
  `blocked` int(1) NOT NULL DEFAULT '0' COMMENT 'Блокировка',
  `archive` int(1) NOT NULL DEFAULT '0' COMMENT 'Удален',
  `neclient` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Гость',
  `category` tinyint(4) DEFAULT '0' COMMENT '0 - low, 1-middle, 2-high',
  `birthday` date DEFAULT NULL COMMENT 'День рождения клиента',
  `last_birthday_congrat` timestamp NULL DEFAULT NULL COMMENT 'Штамп времени, когда поздравили крайний раз',
  `happy_birthday` tinyint(4) DEFAULT '0' COMMENT 'Поздравлять клиента с днем рождения',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Добавлен',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Обновлен',
  `updated_by` varchar(255) DEFAULT NULL COMMENT 'Автор обновления',
  `uon_sync_need` tinyint(4) DEFAULT '1',
  `uon_id` int(11) DEFAULT '0',
  `mob_phone` varchar(11) DEFAULT NULL COMMENT 'Мобильный телефон',
  `level` int(1) unsigned zerofill NOT NULL DEFAULT '0' COMMENT 'Уровень доступа',
  `dom_phone` int(5) DEFAULT NULL COMMENT 'Номер SIP',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `UK__client_uid` (`uid`),
  KEY `dom_old` (`dom_old`),
  KEY `happy_birthday` (`happy_birthday`),
  KEY `IDX__client_archive` (`archive`),
  KEY `IDX__client_blocked` (`blocked`),
  KEY `IDX__client_cid` (`cid`),
  KEY `IDX__client_dom` (`dom`),
  KEY `IDX__client_name` (`name`),
  KEY `IDX__client_neclient` (`neclient`),
  KEY `IDX__client_phone` (`phone`),
  KEY `IDX__client_street` (`street`),
  KEY `street_old` (`street_old`)
) ENGINE=MyISAM AUTO_INCREMENT=376879 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=134;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_client2`
--

DROP TABLE IF EXISTS `_client2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_client2` (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'Компания',
  `did` int(11) DEFAULT '0' COMMENT 'ID в справочнике',
  `pid` int(11) DEFAULT '0' COMMENT 'Персонал',
  `lc_aec` int(11) DEFAULT NULL COMMENT 'АЕС',
  `lc_erc` int(11) DEFAULT NULL COMMENT 'ЕРЦ',
  `phone` varchar(255) DEFAULT NULL COMMENT 'Телефон',
  `name` varchar(255) DEFAULT NULL COMMENT 'ФИО',
  `info` varchar(255) DEFAULT NULL COMMENT 'Описание, должность, компания, коментарий',
  `city_meaning` int(11) DEFAULT '3' COMMENT 'Префикс населённого пункта',
  `city` varchar(255) DEFAULT 'Астана' COMMENT 'Населённого пункта',
  `street_meaning` varchar(255) DEFAULT NULL COMMENT 'Префикс улицы',
  `street` varchar(255) DEFAULT NULL COMMENT 'Улица',
  `street_old` varchar(255) DEFAULT NULL COMMENT 'Улица (старое)',
  `dom` varchar(10) DEFAULT NULL COMMENT 'Номер строения',
  `dom_old` varchar(10) DEFAULT NULL COMMENT 'Номер (старый)',
  `podezd` varchar(10) DEFAULT NULL COMMENT 'Подъезд',
  `podezd_kv` varchar(10) DEFAULT NULL COMMENT 'Квартиры подъезда',
  `kv` varchar(10) DEFAULT NULL COMMENT 'Квартира',
  `zhk` varchar(10) DEFAULT NULL COMMENT 'ЖК',
  `blocked` int(1) NOT NULL DEFAULT '0' COMMENT 'Блокировка',
  `archive` int(1) NOT NULL DEFAULT '0' COMMENT 'Удален',
  `neclient` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Гость',
  `category` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Категория',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Добавлен',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Обновлен',
  `updated_by` varchar(255) DEFAULT NULL COMMENT 'Обновлен',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `UK__client_uid` (`uid`),
  KEY `IDX__client_archive` (`archive`),
  KEY `IDX__client_blocked` (`blocked`),
  KEY `IDX__client_cid` (`cid`),
  KEY `IDX__client_dom` (`dom`),
  KEY `IDX__client_name` (`name`),
  KEY `IDX__client_neclient` (`neclient`),
  KEY `IDX__client_phone` (`phone`),
  KEY `IDX__client_street` (`street`)
) ENGINE=MyISAM AUTO_INCREMENT=16880 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=134;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_client_podezd`
--

DROP TABLE IF EXISTS `_client_podezd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_client_podezd` (
  `oid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'Компания',
  `pid` int(11) DEFAULT NULL COMMENT 'Сотрдник',
  `sendCopyTo` text COMMENT 'Копии кому',
  `jid` int(11) DEFAULT NULL COMMENT 'id ЖК',
  `name` varchar(255) DEFAULT NULL COMMENT 'Название',
  `city` varchar(255) DEFAULT NULL COMMENT 'Город',
  `dom_phone` varchar(50) DEFAULT NULL COMMENT 'Домофон',
  `street` varchar(255) DEFAULT NULL COMMENT 'Улица',
  `street_old` varchar(255) DEFAULT NULL COMMENT 'Улица (старое)',
  `dom` varchar(10) DEFAULT NULL COMMENT 'Номер',
  `dom_old` varchar(10) DEFAULT NULL COMMENT 'Номер (старый)',
  `podezd` smallint(6) DEFAULT NULL COMMENT 'Подъезд',
  `levels` smallint(6) DEFAULT NULL COMMENT 'Этажей',
  `min` smallint(6) DEFAULT '1' COMMENT 'Начало',
  `max` smallint(6) DEFAULT '2' COMMENT 'Конец',
  `val1` int(11) DEFAULT NULL,
  `objects` text COMMENT 'Перечень id объектов',
  `adapterip` text,
  `adapterport` int(11) DEFAULT NULL,
  `adapt_user` varchar(255) DEFAULT NULL,
  `adapt_pass` varchar(255) DEFAULT NULL,
  UNIQUE KEY `oid` (`oid`)
) ENGINE=MyISAM AUTO_INCREMENT=5517 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=66;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_comments`
--

DROP TABLE IF EXISTS `_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` varchar(255) DEFAULT NULL COMMENT 'Родитель',
  `cid` int(11) DEFAULT '0' COMMENT 'Компания',
  `did` varchar(255) DEFAULT '0' COMMENT 'Компания _data',
  `model` varchar(255) DEFAULT NULL COMMENT 'Модель',
  `model_id` int(11) DEFAULT NULL COMMENT 'ID Модели',
  `url` varchar(255) DEFAULT NULL COMMENT 'Ссылка',
  `title` varchar(255) DEFAULT NULL COMMENT 'Заголовок',
  `content` varchar(255) DEFAULT NULL COMMENT 'Комментарии',
  `data` varchar(255) DEFAULT NULL COMMENT 'Данные',
  `archive` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Удален',
  `status` tinyint(4) DEFAULT '0' COMMENT 'Статус',
  `type` varchar(255) DEFAULT NULL COMMENT 'Тип',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Создан',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Обновлен',
  `updated_by` varchar(255) DEFAULT NULL COMMENT 'Обновил',
  UNIQUE KEY `id` (`id`),
  KEY `IDX__comments_model_id` (`model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=96;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_company`
--

DROP TABLE IF EXISTS `_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_company` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `gid` int(11) DEFAULT NULL COMMENT 'ID группы биллинга, если компания входит в группу',
  `rid` int(11) DEFAULT NULL COMMENT 'ID группы вызова, если компания входит в группу',
  `name` varchar(255) DEFAULT NULL COMMENT 'Название',
  `descr` varchar(255) DEFAULT NULL COMMENT 'Описание',
  `color` varchar(7) DEFAULT '#da1b61' COMMENT 'Цвет',
  `showinstat` tinyint(4) DEFAULT '1' COMMENT 'Отображать в статистике',
  `bank` varchar(255) DEFAULT NULL COMMENT 'Банк',
  `settl` varchar(255) DEFAULT NULL COMMENT 'Рассчетный счет',
  `bik` varchar(255) DEFAULT NULL COMMENT 'БИК',
  `iin` varchar(255) DEFAULT NULL COMMENT 'ИИН',
  `email` varchar(50) DEFAULT NULL COMMENT 'Email',
  `fax` varchar(25) DEFAULT NULL COMMENT 'Факс',
  `street` varchar(255) DEFAULT NULL COMMENT 'Улица',
  `building` varchar(25) DEFAULT NULL COMMENT 'Дом',
  `block` varchar(25) DEFAULT NULL COMMENT 'Блок',
  `flat` varchar(25) DEFAULT NULL COMMENT 'Квартира',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Добавлен',
  `fullname` varchar(255) DEFAULT NULL COMMENT 'Полное название юр лица',
  `rekvizits` varchar(255) DEFAULT NULL,
  `minimalsumm` int(11) DEFAULT '0',
  `worktime` text COMMENT 'Режим работы',
  `tasktime` text COMMENT 'Режим выполнения заявок',
  `taskdelay` text COMMENT 'Срок выполнения заявок',
  `weekdays` text COMMENT 'Выходные',
  `makewaybill` int(11) DEFAULT '1' COMMENT 'Создавать накладную',
  `withoutclient` int(11) DEFAULT '0' COMMENT 'Разрешить формирование заявки без клиента',
  `withobjects` int(11) DEFAULT '0' COMMENT 'Работа с обьектаим',
  `withlifts` int(11) DEFAULT '0',
  `sametaskforcall` int(11) DEFAULT '0' COMMENT 'Искаьб заяки по номеру и показывать не закрытую ранее',
  `task_lbl` varchar(50) DEFAULT 'поломка' COMMENT 'Сообщение в заявке для техника',
  `defsort` tinyint(4) DEFAULT '0' COMMENT 'Сортировка (доступно ?)',
  `defmark` int(11) DEFAULT '0' COMMENT 'Моргать просроченными',
  `allow_happy_birthday` tinyint(4) DEFAULT '0' COMMENT 'Разрешить компании поздравлять с днем рождения',
  `happy_birthday` int(11) DEFAULT '0' COMMENT 'Поздравлять клиентов с днем рождения',
  `congrat_msg` text COMMENT 'Текст поздарвления',
  `congrat_hour` int(11) DEFAULT '11' COMMENT 'Время в которое производится поздравление',
  `client_have_address` int(11) DEFAULT '1' COMMENT 'Требовать ввод адреса у клиента',
  `menu_template` tinyint(4) DEFAULT '0' COMMENT 'Щаблон компании (0-нет, 1-домофон, 2-тур, 3-лифт, 4-КСК)',
  `archive` tinyint(4) DEFAULT '0' COMMENT 'Удалена',
  `uon_key` char(255) DEFAULT NULL,
  `uon_use` tinyint(4) DEFAULT '0',
  `amo_key` char(255) DEFAULT NULL,
  `amo_url` char(255) DEFAULT NULL,
  `amo_login` char(255) DEFAULT NULL,
  `amo_use` tinyint(4) DEFAULT '0',
  UNIQUE KEY `cid` (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=130;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_company_category_filter`
--

DROP TABLE IF EXISTS `_company_category_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_company_category_filter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `category_exclude` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=20 COMMENT='исключить категории заявок для компании';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_company_ccix`
--

DROP TABLE IF EXISTS `_company_ccix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_company_ccix` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cid` int(11) NOT NULL COMMENT 'Компания',
  `main` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Основной',
  `bid` int(11) NOT NULL COMMENT 'ID в биллинге',
  `pid` varchar(32) DEFAULT NULL COMMENT 'ID в Call Center X',
  `use_clients` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Использует таблицу клиентов',
  `use_auto_send` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Использует автоотправку',
  `use_sms_notice` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Испольовать для уведомления по sms',
  `phone` varchar(11) DEFAULT '0' COMMENT 'Телефон',
  `phone_x` int(11) NOT NULL DEFAULT '0' COMMENT 'Телефонный номер, по которой принимаются звонки',
  `whatsapp` varchar(11) DEFAULT NULL COMMENT 'WhatsApp',
  `processing` int(11) NOT NULL DEFAULT '0' COMMENT 'Обработать в справчонике',
  `mail` varchar(255) DEFAULT '0' COMMENT 'Mail',
  `telegram` varchar(255) DEFAULT NULL COMMENT 'Telegram',
  `matrix` varchar(255) DEFAULT NULL COMMENT 'Matrix',
  `smspool` varchar(255) DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `infinity_pid` (`pid`),
  KEY `infinity_bid` (`bid`),
  KEY `infinity_cid` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1260;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_company_contacts`
--

DROP TABLE IF EXISTS `_company_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_company_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL COMMENT 'ИД компаний',
  `prefix` int(11) NOT NULL DEFAULT '0' COMMENT 'Категория',
  `name` varchar(255) DEFAULT NULL COMMENT 'Контактное лицо',
  `type` int(11) DEFAULT NULL COMMENT 'Отдел',
  `descr` varchar(255) DEFAULT NULL COMMENT 'Описание',
  `contact` varchar(11) DEFAULT NULL COMMENT 'Номер',
  `contact_x` varchar(11) DEFAULT NULL COMMENT 'Номер в Infinity4',
  `archive` tinyint(4) DEFAULT '0' COMMENT 'Удален',
  UNIQUE KEY `id` (`id`),
  KEY `UK_company_contacts_cid` (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=33;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_company_days`
--

DROP TABLE IF EXISTS `_company_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_company_days` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` bigint(20) DEFAULT NULL COMMENT 'ID компаний',
  `status` int(2) DEFAULT NULL COMMENT 'Статус',
  `c_date` date DEFAULT NULL COMMENT 'Дата',
  `dstart` time DEFAULT '09:00:00' COMMENT 'Начало',
  `dend` time DEFAULT '19:00:00' COMMENT 'Конец',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=26;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_company_group`
--

DROP TABLE IF EXISTS `_company_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_company_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '0-группа биллинга, 1-группа вызова',
  `name` varchar(255) NOT NULL,
  `archive` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=47;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_company_old`
--

DROP TABLE IF EXISTS `_company_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_company_old` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) DEFAULT NULL COMMENT 'Название',
  `creared_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Добавлен',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор',
  UNIQUE KEY `cid` (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=51;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_company_stat_graph`
--

DROP TABLE IF EXISTS `_company_stat_graph`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_company_stat_graph` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `graph` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=112 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=24 COMMENT='отображение статистики';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_company_state`
--

DROP TABLE IF EXISTS `_company_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_company_state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'идентификатор состояния',
  `state` text COMMENT 'описание состояния',
  `sms_notice` tinyint(4) DEFAULT '0' COMMENT 'уведомлять SMS сообщением клиента при переходе в состояние',
  `sms_category` tinyint(4) DEFAULT '2' COMMENT 'категория, которую уведомлять при переходе в состояние',
  `sms_msg` text COMMENT 'текст SMS уведомления',
  `tech_msg` text COMMENT 'переводить в данное состояние при получении ответа от техника ОК + данный текст',
  `in_use` tinyint(4) DEFAULT '1' COMMENT 'Использовать?',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=194 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=106;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_company_state_macro`
--

DROP TABLE IF EXISTS `_company_state_macro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_company_state_macro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL COMMENT 'название',
  `desc` text COMMENT 'описание',
  `inner` tinyint(4) DEFAULT '0' COMMENT '0-sql (по task->tid), 1-php, внутреннее значение',
  `code` text NOT NULL COMMENT 'sql запрос или php код',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=129 COMMENT='таблица дополнительных параметров, включаемых в SMS ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_company_week`
--

DROP TABLE IF EXISTS `_company_week`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_company_week` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` varchar(255) DEFAULT NULL COMMENT 'ID компаний',
  `dday` int(1) DEFAULT NULL COMMENT 'День недели',
  `dstart` time DEFAULT '19:00:00' COMMENT 'Начало рабочего дня',
  `dend` time DEFAULT '19:00:00' COMMENT 'Конец рабочего дня',
  `dstatus` int(1) DEFAULT NULL COMMENT 'Статус',
  `ostatus` int(1) DEFAULT NULL COMMENT '1- без обеда, 0 - с обедом',
  `ostart` time DEFAULT NULL COMMENT 'Начало обеда',
  `oend` time DEFAULT NULL COMMENT 'Конец обеда',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=30;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_company_year`
--

DROP TABLE IF EXISTS `_company_year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_company_year` (
  `day_id` int(11) NOT NULL AUTO_INCREMENT,
  `c_day` int(2) DEFAULT NULL,
  `c_week` int(1) DEFAULT NULL,
  `c_month` int(2) DEFAULT NULL,
  `c_year` int(4) DEFAULT NULL,
  `c_date` date DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`day_id`)
) ENGINE=MyISAM AUTO_INCREMENT=374 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=28;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `_config_address_streets`
--

-- DROP TABLE IF EXISTS `_config_address_streets`;
/*!50001 DROP VIEW IF EXISTS `_config_address_streets`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `_config_address_streets` AS SELECT
 1 AS `id`,
 1 AS `pid`,
 1 AS `prefix`,
 1 AS `name`,
 1 AS `name_old`,
 1 AS `kz`,
 1 AS `en`,
 1 AS `descr`,
 1 AS `text`,
 1 AS `created_at`,
 1 AS `created_by`,
 1 AS `updated_at`,
 1 AS `updated_by`,
 1 AS `xid`,
 1 AS `oid`,
 1 AS `yid`,
 1 AS `gid`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `_config_prefix`
--

DROP TABLE IF EXISTS `_config_prefix`;
/*!50001 DROP VIEW IF EXISTS `_config_prefix`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `_config_prefix` AS SELECT
 1 AS `id`,
 1 AS `pid`,
 1 AS `prefix`,
 1 AS `name`,
 1 AS `type`,
 1 AS `regexp`,
 1 AS `icon`,
 1 AS `image`,
 1 AS `color`,
 1 AS `intval`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `_data_company`
--

DROP TABLE IF EXISTS `_data_company`;
/*!50001 DROP VIEW IF EXISTS `_data_company`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `_data_company` AS SELECT
 1 AS `cid`,
 1 AS `processing`,
 1 AS `region`,
 1 AS `archive`,
 1 AS `checked`,
 1 AS `isParent`,
 1 AS `rating`,
 1 AS `prefix`,
 1 AS `name`,
 1 AS `extension`,
 1 AS `legalName`,
 1 AS `fullName`,
 1 AS `descr`,
 1 AS `services`,
 1 AS `created_at`,
 1 AS `created_by`,
 1 AS `updated_at`,
 1 AS `updated_by`,
 1 AS `yid`,
 1 AS `gid`,
 1 AS `oid`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `_data_company_address`
--

DROP TABLE IF EXISTS `_data_company_address`;
/*!50001 DROP VIEW IF EXISTS `_data_company_address`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `_data_company_address` AS SELECT
 1 AS `id`,
 1 AS `cid`,
 1 AS `gid`,
 1 AS `yid`,
 1 AS `street`,
 1 AS `building`,
 1 AS `flat_prefix`,
 1 AS `flat`,
 1 AS `name`,
 1 AS `descr`,
 1 AS `text`,
 1 AS `lat`,
 1 AS `lon`,
 1 AS `oid`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `_data_company_contacts`
--

DROP TABLE IF EXISTS `_data_company_contacts`;
/*!50001 DROP VIEW IF EXISTS `_data_company_contacts`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `_data_company_contacts` AS SELECT
 1 AS `id`,
 1 AS `cid`,
 1 AS `prefix`,
 1 AS `name`,
 1 AS `type`,
 1 AS `descr`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `_data_company_objects`
--

DROP TABLE IF EXISTS `_data_company_objects`;
/*!50001 DROP VIEW IF EXISTS `_data_company_objects`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `_data_company_objects` AS SELECT
 1 AS `id`,
 1 AS `cid`,
 1 AS `street`,
 1 AS `building`,
 1 AS `name`,
 1 AS `descr`,
 1 AS `text`,
 1 AS `created_at`,
 1 AS `created_by`,
 1 AS `updated_at`,
 1 AS `updated_by`,
 1 AS `test`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `_data_company_week`
--

DROP TABLE IF EXISTS `_data_company_week`;
/*!50001 DROP VIEW IF EXISTS `_data_company_week`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `_data_company_week` AS SELECT
 1 AS `id`,
 1 AS `cid`,
 1 AS `prefix`,
 1 AS `dday`,
 1 AS `dstatus`,
 1 AS `dstart`,
 1 AS `dend`,
 1 AS `lunch`,
 1 AS `lunch_start`,
 1 AS `lunch_end`,
 1 AS `descr`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `_imports`
--

DROP TABLE IF EXISTS `_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_imports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `aid` int(11) DEFAULT NULL,
  `path` text,
  `type` int(11) DEFAULT NULL,
  `cols` text,
  `state` int(11) DEFAULT '0',
  `status` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` text,
  `archive` int(11) DEFAULT '0',
  `importedT` longtext,
  `importedE` longtext,
  `importedO` longtext,
  `importedC` longtext,
  `importedP` longtext,
  `errLines` longtext,
  `errTexts` longtext,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=124 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=18547;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_jk`
--

DROP TABLE IF EXISTS `_jk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_jk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `archive` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=116 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=36;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_lift`
--

DROP TABLE IF EXISTS `_lift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_lift` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT '0',
  `archive` int(11) DEFAULT '0',
  `f1` text COMMENT 'Предприятие-изготовитель (поставщик)',
  `f2` text COMMENT 'Тип лифта',
  `f3` text COMMENT 'Модель',
  `f4` text COMMENT 'Заводской номер',
  `f5` date DEFAULT NULL COMMENT 'Год и месяц изготовления',
  `f6` int(11) DEFAULT NULL COMMENT 'Допустимая температура в машинном помещении',
  `f7` int(11) DEFAULT NULL COMMENT 'Допустимая температура шахте',
  `f8` text COMMENT 'Окружающая среда',
  `f9` text COMMENT 'Нормативные документы',
  `f10` text COMMENT 'Назначенный срок эксплуатации, лет',
  `f11` int(11) DEFAULT NULL COMMENT 'Номинальная грузоподъемность, кг',
  `f12` int(11) DEFAULT NULL COMMENT 'Число пассажиров (макс)',
  `f13` int(11) DEFAULT NULL COMMENT 'Номинальная скорость движения кабины, м/с',
  `f14` int(11) DEFAULT NULL COMMENT 'Скорость движения кабины в режиме "Ревизия", м/с',
  `f15` text COMMENT 'Система управления',
  `f16` int(11) DEFAULT NULL COMMENT 'Число остановок',
  `f17` int(11) DEFAULT NULL COMMENT 'Число дверей шахты',
  `f18` int(11) DEFAULT NULL COMMENT 'Высота подъема, м',
  `f19` int(11) DEFAULT NULL COMMENT 'Электрические цепи Род тока На вводном устройстве лифта',
  `f20` int(11) DEFAULT NULL COMMENT 'Электрические цепи Напряжение На вводном устройстве лифта',
  `f21` int(11) DEFAULT NULL COMMENT 'Электрические цепи Частота На вводном устройстве лифта ',
  `f22` int(11) DEFAULT NULL COMMENT 'Электрические цепи Род тока привод лифта',
  `f23` int(11) DEFAULT NULL COMMENT 'Электрические цепи Напряжение привод лифта',
  `f24` int(11) DEFAULT NULL COMMENT 'Электрические цепи Частота привод лифта',
  `f25` int(11) DEFAULT NULL COMMENT 'Электрические цепи  Род тока Привод дверей',
  `f26` int(11) DEFAULT NULL COMMENT 'Электрические цепи  Напряжение Привод дверей',
  `f27` int(11) DEFAULT NULL COMMENT 'Электрические цепи  Частота Привод дверей',
  `f29` int(11) DEFAULT NULL COMMENT 'Электрические цепи Род тока  Цепь управления',
  `f30` int(11) DEFAULT NULL COMMENT 'Электрические цепи  Напряжение Цепь управления',
  `f31` int(11) DEFAULT NULL COMMENT 'Электрические цепи  Частота Цепь управления',
  `f32` int(11) DEFAULT NULL COMMENT 'Электрические цепи Род тока Цепь освещения для кабины',
  `f33` int(11) DEFAULT NULL COMMENT 'Электрические цепи Напряжение Цепь освещения для кабины',
  `f34` int(11) DEFAULT NULL COMMENT 'Электрические цепи  Частота  Цепь освещения для кабины',
  `f35` int(11) DEFAULT NULL COMMENT 'Электрические цепи Род тока Цепь освещения для шахты',
  `f36` int(11) DEFAULT NULL COMMENT 'Электрические цепи Напряжение Цепь освещения для шахты',
  `f37` int(11) DEFAULT NULL COMMENT 'Электрические цепи  Частота  Цепь освещения для шахты',
  `f38` int(11) DEFAULT NULL COMMENT 'Электрические цепи Род тока Цепь освещения для ремонтных работ',
  `f39` int(11) DEFAULT NULL COMMENT 'Электрические цепи Напряжение Цепь освещения для ремонтных работ',
  `f40` int(11) DEFAULT NULL COMMENT 'Электрические цепи Частота  Цепь освещения для ремонтных работ',
  `f41` int(11) DEFAULT NULL COMMENT 'Электрические цепи Род тока Цепь сигнализации',
  `f42` int(10) DEFAULT NULL COMMENT 'Электрические цепи Напряжение Цепь сигнализации',
  `f43` int(11) DEFAULT NULL COMMENT 'Электрические цепи Частота  Цепь сигнализации',
  `f44` int(11) DEFAULT NULL COMMENT 'Лебедка тип',
  `f45` text COMMENT 'Лебедка Заводской номер',
  `f46` int(11) DEFAULT NULL COMMENT 'Лебедка  Год изготовления',
  `f47` int(11) DEFAULT NULL COMMENT 'Лебедка Передаточное число',
  `f48` int(11) DEFAULT NULL COMMENT 'Лебедка Межосевое расстояние передачи, мм',
  `f49` int(11) DEFAULT NULL COMMENT 'Лебедка Номинальный крутящий момент на выходном валу, Нм',
  `f50` int(11) DEFAULT NULL COMMENT 'Лебедка Диаметр ведущего органа, мм',
  `f51` int(11) DEFAULT NULL COMMENT 'Лебедка Диаметр отводного блока, мм',
  `f52` int(11) DEFAULT NULL COMMENT 'Лебедка Масса, кг',
  `f53` int(11) DEFAULT NULL COMMENT 'Тормоз тип',
  `f54` int(11) DEFAULT NULL COMMENT 'Тормоз Диаметр тормозного шкива ',
  `f55` int(11) DEFAULT NULL COMMENT 'Тормоз Тормозной момент',
  `f56` int(11) DEFAULT NULL COMMENT 'Электродвигатели Лебедки Тип',
  `f57` int(11) DEFAULT NULL COMMENT 'Электродвигатели Лебедки Род тока',
  `f58` int(11) DEFAULT NULL COMMENT 'Электродвигатели Лебедки Напряжение, В',
  `f59` int(11) DEFAULT NULL COMMENT 'Электродвигатели Лебедки Номинальный ток, А',
  `f60` int(11) DEFAULT NULL COMMENT 'Электродвигатели Лебедки Частота, Гц',
  `f61` int(11) DEFAULT NULL COMMENT 'Электродвигатели Лебедки Мощность, кВт',
  `f62` int(11) DEFAULT NULL COMMENT 'Электродвигатели Лебедки Допустимый перегрев обмоток двигателя ',
  `f63` int(11) DEFAULT NULL COMMENT 'Электродвигатели Лебедки Частота вращения, об/мин',
  `f64` int(11) DEFAULT NULL COMMENT 'Электродвигатели Лебедки ПВ',
  `f65` int(11) DEFAULT NULL COMMENT 'Электродвигатели Лебедки Число включений в час',
  `f66` text COMMENT 'Электродвигатели Лебедки Исполнение ',
  `f67` int(11) DEFAULT NULL COMMENT 'Электродвигатели Лебедки Масса',
  `f68` int(11) DEFAULT NULL COMMENT 'Электродвигатели Привода дверей Тип',
  `f69` int(11) DEFAULT NULL COMMENT 'Электродвигатели Привода дверей Род тока',
  `f70` int(11) DEFAULT NULL COMMENT 'Электродвигатели Привода дверей Напряжение, В',
  `f71` int(11) DEFAULT NULL COMMENT 'Электродвигатели Привода дверей Номинальный ток, А',
  `f72` int(11) DEFAULT NULL COMMENT 'Электродвигатели Привода дверей Частота, Гц',
  `f73` int(11) DEFAULT NULL COMMENT 'Электродвигатели Привода дверей Мощность, кВт',
  `f74` int(11) DEFAULT NULL COMMENT 'Электродвигатели Привода дверей Допустимый перегрев обмоток двигателя ',
  `f75` int(11) DEFAULT NULL COMMENT 'Электродвигатели Привода дверей Частота вращения, об/мин',
  `f76` int(11) DEFAULT NULL COMMENT 'Электродвигатели Привода дверей ПВ',
  `f77` int(11) DEFAULT NULL COMMENT 'Электродвигатели Привода дверей Число включений в час',
  `f78` text COMMENT 'Электродвигатели Привода дверей Исполнение ',
  `f79` int(11) DEFAULT NULL COMMENT 'Электродвигатели Привода дверей Масса',
  `f80` int(11) DEFAULT NULL COMMENT 'Двери шахты Конструкция ',
  `f81` int(11) DEFAULT NULL COMMENT 'Двери шахты Размер дверного проема в свету ',
  `f82` int(11) DEFAULT NULL COMMENT 'Двери шахты Способ открывания/закрывания ',
  `f83` int(11) DEFAULT NULL COMMENT 'Кабина ширина',
  `f84` int(11) DEFAULT NULL COMMENT 'Кабина глубина',
  `f85` int(11) DEFAULT NULL COMMENT 'Кабина высота',
  `f86` int(11) DEFAULT NULL COMMENT 'Кабина Конструкция дверей ',
  `f87` int(11) DEFAULT NULL COMMENT 'Кабина Способ открывания или закрывания ',
  `f88` int(11) DEFAULT NULL COMMENT 'Кабина Привод дверей ',
  `f89` int(11) DEFAULT NULL COMMENT 'Кабина Вид кабины ',
  `f90` int(11) DEFAULT NULL COMMENT 'Кабина Масса',
  `f91` int(11) DEFAULT NULL COMMENT 'Противовес  Масса',
  `f92` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Кабины Вид ',
  `f93` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Кабины Тип',
  `f94` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Кабины Конструкция',
  `f95` text COMMENT 'Тяговые элементы Кабины Условное обозначение',
  `f96` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Кабины Диаметр, шаг, размеры, мм',
  `f97` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Кабины Количество элементов, шт.',
  `f98` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Кабины Длина одного элемента, включая длину, необходимую для крепления, м',
  `f99` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Кабины Разрывное усилие (разрушающая нагрузка), Н',
  `f100` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Кабины Коэффициент запаса прочности',
  `f101` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Противовеса Вид ',
  `f102` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Противовеса Тип',
  `f103` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Противовеса Конструкция',
  `f104` text COMMENT 'Тяговые элементы Противовеса Условное обозначение',
  `f105` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Противовеса Диаметр, шаг, размеры, мм',
  `f106` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Противовеса Количество элементов, шт.',
  `f107` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Противовеса лина одного элемента, включая длину, необходимую для крепления, м',
  `f108` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Противовеса Разрывное усилие (разрушающая нагрузка), Н',
  `f109` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Противовеса Коэффициент запаса прочности',
  `f110` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Ограничителя Вид ',
  `f111` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Ограничителя Тип',
  `f112` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Ограничителя Конструкция',
  `f113` text COMMENT 'Тяговые элементы Ограничителя Условное обозначение',
  `f114` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Ограничителя Диаметр, шаг, размеры, мм',
  `f115` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Ограничителя Количество элементов, шт.',
  `f116` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Ограничителя лина одного элемента, включая длину, необходимую для крепления, м',
  `f117` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Ограничителя Разрывное усилие (разрушающая нагрузка), Н',
  `f118` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Ограничителя Коэффициент запаса прочности',
  `f119` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Уравновешивающие элементы Вид ',
  `f120` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Уравновешивающие элементы Тип',
  `f121` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Уравновешивающие элементы Конструкция',
  `f122` text COMMENT 'Тяговые элементы Уравновешивающие элементы Условное обозначение',
  `f123` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Уравновешивающие элементы Диаметр, шаг, размеры, мм',
  `f124` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Уравновешивающие элементы Количество элементов, шт.',
  `f125` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Уравновешивающие элементыина одного элемента, включая длину, необходимую для крепления, м',
  `f126` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Уравновешивающие элементы Разрывное усилие (разрушающая нагрузка), Н',
  `f127` int(11) DEFAULT NULL COMMENT 'Тяговые элементы Уравновешивающие элементы Коэффициент запаса прочности',
  `f128` int(11) DEFAULT NULL COMMENT 'Ловители  Кабина Тип ',
  `f129` int(11) DEFAULT NULL COMMENT 'Ловители  Кабина Приводятся в действие',
  `f130` int(11) DEFAULT NULL COMMENT 'Ловители  Противовес Тип ',
  `f131` int(11) DEFAULT NULL COMMENT 'Ловители  Противовес Приводятся в действие',
  `f132` int(11) DEFAULT NULL COMMENT 'Ограничитель Кабина Тип ',
  `f133` text COMMENT 'Ограничитель Кабина Обозначение',
  `f134` int(11) DEFAULT NULL COMMENT 'Ограничитель Кабина Скорость Максимальная',
  `f135` int(11) DEFAULT NULL COMMENT 'Ограничитель Кабина Скорость Минимальная',
  `f136` int(11) DEFAULT NULL COMMENT 'Ограничитель Противовес Тип ',
  `f137` text COMMENT 'Ограничитель Противовес Обозначение',
  `f138` int(11) DEFAULT NULL COMMENT 'Ограничитель Противовес Скорость Максимальная',
  `f139` int(11) DEFAULT NULL COMMENT 'Ограничитель Противовес Скорость Минимальная',
  `f140` int(11) DEFAULT NULL COMMENT 'Буфер Кабина Тип',
  `f141` int(11) DEFAULT NULL COMMENT 'Буфер Кабина Высота ',
  `f142` int(11) DEFAULT NULL COMMENT 'Буфер Кабина Количество',
  `f143` int(11) DEFAULT NULL COMMENT 'Буфер Противовес Тип',
  `f144` int(11) DEFAULT NULL COMMENT 'Буфер Противовес Высота ',
  `f145` int(11) DEFAULT NULL COMMENT 'Буфер Противовес Количество',
  `f146` int(11) DEFAULT NULL COMMENT 'Контроль перехода кабиной крайней нижней этажной площадки',
  `f147` int(11) DEFAULT NULL COMMENT 'Контроль перехода кабиной крайней верхней этажной площадки',
  `f148` int(11) DEFAULT NULL COMMENT 'Контроля закрытия двери шахты',
  `f149` int(11) DEFAULT NULL COMMENT 'Контроля запирания автоматического замка двери шахты',
  `f150` int(11) DEFAULT NULL COMMENT 'Контроля закрытия створки двери шахты, не оборудованной замком',
  `f151` int(11) DEFAULT NULL COMMENT 'Контроля закрытия аварийной двери шахты',
  `f152` int(11) DEFAULT NULL COMMENT 'Контроля закрытия двери для обслуживания в шахте',
  `f153` int(11) DEFAULT NULL COMMENT 'Контроля закрытия смотрового люка в шахте',
  `f154` int(11) DEFAULT NULL COMMENT 'Контроля закрытия двери кабины',
  `f155` int(11) DEFAULT NULL COMMENT 'Контроля запирания замка аварийной двери или люка кабины',
  `f156` int(11) DEFAULT NULL COMMENT 'Контроля срабатывания ограничителя скорости кабины',
  `f157` int(11) DEFAULT NULL COMMENT 'Контроля возврата ограничителя скорости кабины в исходное положение',
  `f158` int(11) DEFAULT NULL COMMENT 'Для остановки лифта (выключатель, кнопка "Стоп")',
  `f159` int(11) DEFAULT NULL COMMENT 'Контроля срабатывания ловителей',
  `f160` int(11) DEFAULT NULL COMMENT 'Контроля обрыва или относительного перемещения тяговых элементов',
  `f161` int(11) DEFAULT NULL COMMENT 'Контроля обрыва или вытяжки каната ограничителя скорости',
  `f162` int(11) DEFAULT NULL COMMENT 'Контроля натяжения уравновешивающих канатов',
  `f163` int(11) DEFAULT NULL COMMENT 'Контроля срабатывания устройства',
  `f164` int(11) DEFAULT NULL COMMENT 'Контроля присоединения съемного устройства ',
  `f165` int(11) DEFAULT NULL COMMENT 'Контроля возвращения в исходное положение ',
  `f166` int(11) DEFAULT NULL COMMENT 'Отключения цепей управления из шахты',
  `f167` int(11) DEFAULT NULL COMMENT 'Отключения цепей управления из приямка',
  `f168` int(11) DEFAULT NULL COMMENT 'Отключения цепей управления из блочного помещения',
  `f169` int(11) DEFAULT NULL COMMENT 'Контроля положения площадки обслуживания',
  `f170` int(11) DEFAULT NULL COMMENT 'Контроля положения блокировочного устройства',
  `f171` text COMMENT 'Монтажный чертеж обозначение',
  `f172` int(11) DEFAULT NULL COMMENT 'Монтажный чертеж количество листов',
  `f173` text COMMENT 'Принципиальная электрическая схема обозначение',
  `f174` int(11) DEFAULT NULL COMMENT 'Принципиальная электрическая схема количество листов',
  `f175` text COMMENT 'Ведомость эксплуатационных документов обозначение',
  `f176` int(11) DEFAULT NULL COMMENT 'Ведомость эксплуатационных документов количество листов',
  `f177` text COMMENT ' перечнем элементов обозначение',
  `f178` int(11) DEFAULT NULL COMMENT ' перечнем элементов количество листов',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_mail_templates`
--

DROP TABLE IF EXISTS `_mail_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_mail_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL COMMENT 'компания',
  `hour` int(11) DEFAULT '0' COMMENT 'в каком часу',
  `day` int(11) DEFAULT '0' COMMENT 'по каким дням, 0 - каждый день',
  `daysback` int(11) NOT NULL DEFAULT '1' COMMENT 'сколько дней назад от текущей даты',
  `mail` text NOT NULL COMMENT 'кому',
  `copies` text COMMENT 'копии',
  `params` text COMMENT 'параметры',
  `last_rep` timestamp NULL DEFAULT NULL COMMENT 'штамп времени последнего построения',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='таблица хранит настройки рассылок экспорта по email';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_menu`
--

DROP TABLE IF EXISTS `_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(11) NOT NULL COMMENT 'ID родительского элемента',
  `cid` int(11) NOT NULL DEFAULT '2' COMMENT 'ID компании',
  `my` enum('0','1') DEFAULT NULL COMMENT 'Показывать только клиентам',
  `event` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Название',
  `tosend` varchar(255) DEFAULT NULL COMMENT 'Для отправления',
  `send` enum('0','1') DEFAULT NULL COMMENT 'Отправить',
  `sendBy` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 - whatsApp, 1 - sms, 2 - mail',
  `sendType` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Способ отправки персоналу: 0 - вручную (менеджеру), 1 - система по адресу, 2 - система на выбранный персонал',
  `sendTo` int(11) DEFAULT NULL COMMENT 'ID персонала',
  `sendCopyTo` text COMMENT 'ID персонала копии отправка',
  `use_sms_notice` tinyint(4) DEFAULT '0' COMMENT 'Уведомлять по SMS',
  `sms_message` text COMMENT 'Сообщение в SMS',
  `done_time` int(11) DEFAULT NULL COMMENT 'Время исполнения указанной операции',
  `objtype` int(11) DEFAULT '0' COMMENT 'Тип объекта',
  `style` enum('say','ans','do','call','task','list','check','anket') DEFAULT NULL COMMENT 'Тип',
  `phone` varchar(11) DEFAULT NULL COMMENT 'Телефон',
  `css` text COMMENT 'CSS',
  `aid` int(11) DEFAULT NULL COMMENT 'id анкеты (если тип - анкета)',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата добавления',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Дата обновления',
  `updated_by` varchar(255) DEFAULT NULL COMMENT 'Автор обновления',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK__menu_id` (`id`),
  KEY `IDX__menu_cid` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=3236 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=489;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_menu_events`
--

DROP TABLE IF EXISTS `_menu_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_menu_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=30;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_obyect`
--

DROP TABLE IF EXISTS `_obyect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_obyect` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL COMMENT 'Компания',
  `lid` int(11) DEFAULT NULL COMMENT 'Лифт (если есть)',
  `name` text NOT NULL,
  `aid` int(11) NOT NULL COMMENT 'Форма описатель',
  `type_id` int(11) NOT NULL COMMENT 'ID типа объекта',
  `owner` text COMMENT 'Владелец',
  `contacts` text COMMENT 'Контакты',
  `acc` text COMMENT 'Договор',
  `acc_date` text COMMENT 'Дата от',
  `acc_stop` text COMMENT 'Дата до',
  `acc_inf` int(11) DEFAULT '0' COMMENT 'Безсрочный',
  `archive` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` text,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` text,
  PRIMARY KEY (`oid`)
) ENGINE=MyISAM AUTO_INCREMENT=523 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=170;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_obyect_types`
--

DROP TABLE IF EXISTS `_obyect_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_obyect_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'тип ID',
  `cid` int(11) NOT NULL COMMENT 'ID компании',
  `desc` text COMMENT 'тип описание',
  `archive` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=41 COMMENT='типы объектов, таблица справочник';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_personal`
--

DROP TABLE IF EXISTS `_personal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_personal` (
  `pid` int(11) NOT NULL AUTO_INCREMENT COMMENT '0',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'ID компаний',
  `did` int(11) DEFAULT '0' COMMENT 'ID c _data',
  `name` varchar(255) NOT NULL COMMENT 'ФИО',
  `archive` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Удален',
  `descr` text COMMENT 'Описание',
  `email` varchar(50) DEFAULT NULL COMMENT 'Эл. почта',
  `phone` int(6) DEFAULT NULL COMMENT 'Телефон',
  `mobile` varchar(11) DEFAULT NULL COMMENT 'Мобильный',
  `whatsapp` varchar(11) DEFAULT NULL COMMENT 'Whatsapp',
  `telegram` varchar(11) DEFAULT NULL COMMENT 'Telegram',
  `matrix` varchar(11) DEFAULT NULL,
  `telegramchatid` varchar(255) DEFAULT NULL,
  `send_tasks` enum('да','нет') NOT NULL DEFAULT 'нет' COMMENT 'Отправлять заявки',
  `send_now` enum('да','нет') NOT NULL DEFAULT 'нет' COMMENT 'Отправить моментально',
  `work_mode` int(11) DEFAULT '0',
  `work_cal` text,
  `phone_x` int(4) DEFAULT NULL,
  `mobile_x` int(4) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Создан',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Обновлен',
  `updated_by` varchar(255) DEFAULT NULL COMMENT 'Обновил',
  `use_send_whatsapp` enum('да','нет') DEFAULT 'нет' COMMENT 'использовать WA для отправки',
  `use_send_mail` enum('да','нет') DEFAULT 'нет' COMMENT 'использовать почту для отправки',
  `use_send_telegram` enum('да','нет') DEFAULT 'нет' COMMENT 'использовать телеграм',
  `use_send_matrix` enum('да','нет') DEFAULT 'нет',
  `inn` text,
  `img_photo` text,
  `img_doc1` text,
  `img_doc2` text,
  `img_doc3` text,
  `img_photo_cap` text,
  `img_cap1` text,
  `img_cap2` text,
  `img_cap3` text,
  PRIMARY KEY (`pid`),
  UNIQUE KEY `combined` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=320 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=86;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_personal_state`
--

DROP TABLE IF EXISTS `_personal_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_personal_state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=13;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_product`
--

DROP TABLE IF EXISTS `_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL COMMENT 'id компании',
  `name` varchar(255) NOT NULL COMMENT 'наименование',
  `comment` varchar(255) DEFAULT NULL,
  `comment2` varchar(255) DEFAULT NULL,
  `boxing` varchar(50) DEFAULT NULL COMMENT 'упаковка',
  `volume` varchar(50) NOT NULL COMMENT 'обьем',
  `volume_type` varchar(50) NOT NULL COMMENT 'размерность обьема',
  `cost` varchar(50) NOT NULL COMMENT 'цена',
  `cost_from` varchar(50) NOT NULL,
  `nds` varchar(50) DEFAULT '''12''' COMMENT 'ставка НДС',
  `archive` tinyint(1) DEFAULT '0' COMMENT 'удалено',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'когда создано',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'кем создано',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'дата обновления',
  `updated_by` varchar(255) DEFAULT NULL COMMENT 'кем поправлено',
  `total` int(11) DEFAULT '0',
  `minimal` int(11) DEFAULT '0',
  `notices` int(11) DEFAULT '2',
  `total_at` timestamp NULL DEFAULT NULL,
  `total_by` varchar(255) DEFAULT NULL,
  `cost_at` timestamp NULL DEFAULT NULL,
  `cost_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=179 COMMENT='таблица для хранения продуктов организации';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_product_list`
--

DROP TABLE IF EXISTS `_product_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_product_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `tid` int(11) NOT NULL DEFAULT '0',
  `pid` int(11) NOT NULL DEFAULT '0',
  `pcount` int(11) NOT NULL DEFAULT '0',
  `pprice` int(11) NOT NULL DEFAULT '0',
  `future` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4227 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=26;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_product_list_changes`
--

DROP TABLE IF EXISTS `_product_list_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_product_list_changes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `lcount` int(11) NOT NULL,
  `pcount` int(11) NOT NULL,
  `change_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `change_by` text,
  `comment` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=637 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=69;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_product_price_changes`
--

DROP TABLE IF EXISTS `_product_price_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_product_price_changes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `cost` int(11) DEFAULT NULL,
  `old_cost` int(11) DEFAULT NULL,
  `dts` timestamp NULL DEFAULT NULL,
  `change_by` text,
  `change_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=39;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_products_astykzhan`
--

DROP TABLE IF EXISTS `_products_astykzhan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_products_astykzhan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `_name` text,
  `_price` text,
  `_tara` text,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `_name` (`_name`)
) ENGINE=MyISAM AUTO_INCREMENT=16453 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=111;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_products_proviant`
--

DROP TABLE IF EXISTS `_products_proviant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_products_proviant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `_name` text,
  `_price` text,
  `_tara` text,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `_name` (`_name`)
) ENGINE=MyISAM AUTO_INCREMENT=50457 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=95;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_receive`
--

DROP TABLE IF EXISTS `_receive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_receive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'ИД компании',
  `tid` int(11) NOT NULL DEFAULT '0' COMMENT 'ИД заявки',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT 'ИД персонала',
  `method` varchar(255) NOT NULL DEFAULT '0',
  `from` varchar(20) NOT NULL DEFAULT '0',
  `nick` varchar(255) DEFAULT NULL,
  `type` varchar(25) DEFAULT NULL,
  `text` text,
  `url` varchar(255) DEFAULT NULL,
  `data` text,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `combined` (`id`,`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=2136 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=168;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_send`
--

DROP TABLE IF EXISTS `_send`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_send` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'ИД компании',
  `tid` int(11) NOT NULL DEFAULT '0' COMMENT 'ИД заявки',
  `pid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'ИД персонала',
  `method` varchar(255) NOT NULL DEFAULT '0',
  `descr` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE KEY `combined` (`sid`,`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=2512 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=420;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_task`
--

DROP TABLE IF EXISTS `_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_task` (
  `tid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'Компания',
  `did` int(11) DEFAULT '0' COMMENT 'В справочнике',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'Клиент',
  `mid` int(11) NOT NULL DEFAULT '0' COMMENT 'Меню',
  `auto_send` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'АвтоОтправка',
  `auto_send_wa` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'АвтоОтправка Ватсап',
  `auto_send_tlg` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'АвтоОтправка Телеграмм',
  `auto_send_email` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'АвтоОтправка Email',
  `auto_send_sms` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'АвтоОтправка Sms',
  `phone` varchar(255) DEFAULT NULL COMMENT 'Входящий',
  `category` varchar(255) DEFAULT NULL COMMENT 'Категория',
  `task` text COMMENT 'Заявка',
  `descr` text COMMENT 'Описание',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Статус',
  `archive` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Удален',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Создан',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Обновлен',
  `updated_by` varchar(255) DEFAULT NULL COMMENT 'Обновил',
  `moneys` int(11) DEFAULT NULL COMMENT 'сумма завки перечн',
  `waspayed` tinyint(4) DEFAULT '0' COMMENT 'оплачено',
  `duration` int(11) DEFAULT '0' COMMENT 'длительность разговоров',
  `id_call_x` text COMMENT 'id_call полученный при открытии карточки компании',
  PRIMARY KEY (`tid`),
  UNIQUE KEY `UK__task_tid` (`tid`),
  KEY `task_archive` (`archive`),
  KEY `task_cid` (`cid`),
  KEY `task_did` (`did`),
  KEY `task_phone` (`phone`),
  KEY `task_uid` (`uid`),
  FULLTEXT KEY `id_call_x` (`id_call_x`)
) ENGINE=MyISAM AUTO_INCREMENT=239323 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=178;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_task_color`
--

DROP TABLE IF EXISTS `_task_color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_task_color` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL COMMENT 'компания',
  `hours` int(11) NOT NULL COMMENT 'не закрыта более часов',
  `blink` tinyint(4) DEFAULT '0' COMMENT 'мигание',
  `color` varchar(7) DEFAULT '#da2020' COMMENT 'цвет',
  `mailto` text COMMENT 'email куда уведомить',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=28 COMMENT='таблица с цветами для заявок не закрытых за разное время';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_task_column`
--

DROP TABLE IF EXISTS `_task_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_task_column` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `column` text NOT NULL,
  `caption` text COMMENT 'как назвать столбец/поле',
  `show` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1271 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=24 COMMENT='таблица хранит колонки зявок, доступные для компании';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_task_future`
--

DROP TABLE IF EXISTS `_task_future`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_task_future` (
  `tid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'Компания',
  `did` int(11) DEFAULT '0' COMMENT 'В справочнике',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'Клиент',
  `mid` int(11) NOT NULL DEFAULT '0' COMMENT 'Меню',
  `auto_send` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'АвтоОтправка',
  `phone` varchar(255) DEFAULT NULL COMMENT 'Входящий',
  `category` varchar(255) DEFAULT NULL COMMENT 'Категория',
  `task` text COMMENT 'Заявка',
  `descr` text COMMENT 'Описание',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Статус',
  `archive` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Удален',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Создан',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Обновлен',
  `updated_by` varchar(255) DEFAULT NULL COMMENT 'Обновил',
  `moneys` int(11) DEFAULT NULL COMMENT 'сумма завки перечня',
  PRIMARY KEY (`tid`),
  UNIQUE KEY `UK__task_future_tid` (`tid`),
  KEY `task_future_archive` (`archive`),
  KEY `task_future_cid` (`cid`),
  KEY `task_future_did` (`did`),
  KEY `task_future_phone` (`phone`),
  KEY `task_future_uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=216 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=96;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_task_input`
--

DROP TABLE IF EXISTS `_task_input`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_task_input` (
  `tid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'Компания',
  `did` int(11) DEFAULT '0' COMMENT 'В справочнике',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'Клиент',
  `mid` int(11) NOT NULL DEFAULT '0' COMMENT 'Меню',
  `auto_send` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'АвтоОтправка',
  `phone` varchar(255) DEFAULT NULL COMMENT 'Входящий',
  `category` varchar(255) DEFAULT NULL COMMENT 'Категория',
  `task` text COMMENT 'Заявка',
  `descr` text COMMENT 'Описание',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Статус',
  `archive` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Удален',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Создан',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Обновлен',
  `updated_by` varchar(255) DEFAULT NULL COMMENT 'Обновил',
  `moneys` int(11) DEFAULT NULL COMMENT 'сумма завки перечня',
  PRIMARY KEY (`tid`),
  UNIQUE KEY `UK__task_input_tid` (`tid`),
  KEY `task_input_archive` (`archive`),
  KEY `task_input_cid` (`cid`),
  KEY `task_input_did` (`did`),
  KEY `task_input_phone` (`phone`),
  KEY `task_input_uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=100;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_task_voice_records`
--

DROP TABLE IF EXISTS `_task_voice_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_task_voice_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL,
  `session` text NOT NULL,
  `duration` int(11) NOT NULL DEFAULT '0',
  `proc` int(11) NOT NULL DEFAULT '2',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `tid` (`tid`),
  FULLTEXT KEY `session` (`session`)
) ENGINE=MyISAM AUTO_INCREMENT=186783 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=51 COMMENT='Таблица соответствия заявок записям разгорово (1 ко многим)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_user`
--

DROP TABLE IF EXISTS `_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(100) NOT NULL COMMENT 'Логин',
  `email` varchar(100) DEFAULT NULL COMMENT 'Email',
  `cidType` varchar(10) NOT NULL DEFAULT 'one' COMMENT 'Тип проверки',
  `cid` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Компания',
  `cids` varchar(2048) DEFAULT NULL COMMENT 'Компании',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Статус',
  `role` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Роль',
  `can_exit` tinyint(4) DEFAULT '1' COMMENT 'Разрешить выход',
  `homeUrl` varchar(255) DEFAULT NULL COMMENT 'Домашняя страница',
  `imgUrl` varchar(255) DEFAULT NULL COMMENT 'Фото',
  `menuType` tinyint(4) DEFAULT '0' COMMENT 'Тип меню',
  `color` varchar(7) NOT NULL DEFAULT '#da1b61' COMMENT 'Цвет',
  `name` varchar(255) DEFAULT NULL COMMENT 'ФИО',
  `position` varchar(255) DEFAULT NULL COMMENT 'Должность',
  `birthday` date DEFAULT NULL COMMENT 'День рождения',
  `web` varchar(255) DEFAULT NULL COMMENT 'Сайт',
  `phone` varchar(6) DEFAULT NULL COMMENT 'Телефон',
  `mobile` varchar(11) DEFAULT NULL COMMENT 'Мобильный',
  `phoneX` varchar(10) DEFAULT NULL COMMENT 'Номер в Инфинити',
  `loginX` varchar(255) DEFAULT NULL,
  `pwdX` varchar(255) DEFAULT NULL,
  `sippwdX` varchar(255) DEFAULT NULL,
  `uriX` varchar(255) DEFAULT NULL,
  `uidX` varchar(255) DEFAULT NULL,
  `stateX` varchar(255) DEFAULT NULL,
  `url_on_call` varchar(255) DEFAULT NULL COMMENT 'страница при вызове',
  `outside` tinyint(4) unsigned DEFAULT '0' COMMENT 'выносной ip телефон',
  `onelogin` tinyint(4) DEFAULT '0' COMMENT 'только 1 логин с 1 пк',
  `outwindow` tinyint(4) DEFAULT '0' COMMENT 'открывать в отдельном окне',
  `closeafter` tinyint(4) DEFAULT '1' COMMENT 'закрывать по завершению',
  `def_count` int(11) DEFAULT '20' COMMENT 'заявок в окне по умолчанию',
  `def_sort` varchar(50) DEFAULT 'tid' COMMENT 'сортировка по умолчанию',
  `refreshP` tinyint(4) DEFAULT '0',
  `online_at` int(11) DEFAULT NULL COMMENT 'Заходил',
  `created_by` varchar(100) DEFAULT NULL COMMENT 'Автор',
  `created_at` int(11) NOT NULL COMMENT 'Добавлен',
  `updated_by` varchar(100) DEFAULT NULL COMMENT 'Обновил',
  `updated_at` int(11) NOT NULL COMMENT 'Обновлен',
  `can` text COMMENT 'Действия',
  `auth_key` varchar(32) DEFAULT NULL COMMENT 'Токен Куки',
  `password_hash` varchar(255) NOT NULL COMMENT 'Хэш пароля',
  `email_confirm_token` varchar(255) DEFAULT NULL COMMENT 'Токен Сбросса Пароля на Email',
  `password_reset_token` varchar(255) DEFAULT NULL COMMENT 'Токен Сбросса Пароля',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK__user_id` (`id`),
  KEY `IDX__user_role` (`role`),
  KEY `idx_user_email` (`email`),
  KEY `idx_user_status` (`status`),
  KEY `idx_user_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1260;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_user_ksk`
--

DROP TABLE IF EXISTS `_user_ksk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_user_ksk` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cid` int(11) DEFAULT '0' COMMENT 'ID icКомпаний',
  `did` int(11) DEFAULT '0' COMMENT 'ID dКомпаний',
  `pid` int(11) DEFAULT '0' COMMENT 'ID Персонал',
  `role` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Роль',
  `region` tinyint(4) DEFAULT '0' COMMENT 'Регион',
  `username` varchar(255) NOT NULL COMMENT 'Имя пользователя',
  `name` varchar(50) DEFAULT NULL COMMENT 'ФИО',
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Статус',
  `email` varchar(255) NOT NULL COMMENT 'Email',
  `color` varchar(7) NOT NULL DEFAULT '#f8ff01' COMMENT 'Цвет',
  `img` varchar(255) DEFAULT NULL COMMENT 'Фото',
  `phone` varchar(6) DEFAULT NULL COMMENT 'Телефон',
  `mobile` varchar(11) DEFAULT NULL COMMENT 'Мобильный',
  `web` varchar(255) DEFAULT NULL COMMENT 'Сайт',
  `position` varchar(255) DEFAULT NULL COMMENT 'Должность',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор',
  `created_at` int(11) NOT NULL COMMENT 'Дата добавления',
  `updated_by` varchar(255) DEFAULT NULL COMMENT 'Автор обновления',
  `updated_at` int(11) NOT NULL COMMENT 'Дата обновления',
  `can` text COMMENT 'Действия',
  `auth_key` varchar(32) DEFAULT NULL COMMENT 'Токен Куки',
  `password_hash` varchar(255) NOT NULL COMMENT 'Хэш пароля',
  `email_confirm_token` varchar(255) DEFAULT NULL COMMENT 'Токен Сбросса Пароля на Email',
  `password_reset_token` varchar(255) DEFAULT NULL COMMENT 'Токен Сбросса Пароля',
  PRIMARY KEY (`id`),
  KEY `idx_user_email` (`email`),
  KEY `idx_user_status` (`status`),
  KEY `idx_user_username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=177;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_user_login_history`
--

DROP TABLE IF EXISTS `_user_login_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_user_login_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(11) DEFAULT NULL COMMENT 'ID пользователя',
  `username` varchar(255) DEFAULT NULL COMMENT 'Логин',
  `password` varchar(255) DEFAULT NULL COMMENT 'Пароль',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Статус',
  `ip` varchar(15) DEFAULT '0.0.0.0' COMMENT 'IP',
  `login_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата Входа',
  `logout_at` timestamp NULL DEFAULT NULL COMMENT 'Дата выхота',
  `referred` text,
  `agent` varchar(255) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21580 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=74;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_user_old`
--

DROP TABLE IF EXISTS `_user_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_user_old` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL COMMENT 'ID компаний',
  `username` varchar(255) NOT NULL,
  `role` varchar(25) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL,
  `email_confirm_token` varchar(255) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `auth_key` varchar(32) DEFAULT NULL,
  `created_at` int(11) NOT NULL COMMENT 'Дата добавления',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор ( логин оператора )',
  `updated_at` int(11) NOT NULL COMMENT 'Дата обновления',
  `updated_by` varchar(255) DEFAULT NULL COMMENT 'Автор обновления',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `idx_user_cid` (`cid`),
  KEY `idx_user_email` (`email`),
  KEY `idx_user_status` (`status`),
  KEY `idx_user_username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=144;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_usercan`
--

DROP TABLE IF EXISTS `_usercan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_usercan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL DEFAULT '0',
  `username` varchar(255) NOT NULL,
  `controller` varchar(255) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `rule` tinyint(1) NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `combined` (`cid`,`uid`),
  KEY `name_action` (`action`),
  KEY `name_controller` (`controller`)
) ENGINE=MyISAM AUTO_INCREMENT=954 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=45;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages_incoming`
--

DROP TABLE IF EXISTS `messages_incoming`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages_incoming` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID ',
  `wid` int(11) NOT NULL DEFAULT '0' COMMENT 'WhatsApp',
  `tid` int(11) NOT NULL DEFAULT '0' COMMENT 'Заявка',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'Компания',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT 'Сотрудник',
  `messenger` varchar(255) NOT NULL DEFAULT 'whatsapp' COMMENT 'Мессенджер',
  `status` tinyint(4) NOT NULL DEFAULT '9' COMMENT 'Статус',
  `proc` tinyint(4) NOT NULL DEFAULT '9' COMMENT 'Обработка',
  `text` text COMMENT 'Текст',
  `descr` text COMMENT 'Описание',
  `data` text COMMENT 'Данные',
  `type` varchar(255) DEFAULT NULL COMMENT 'Тип',
  `url` varchar(255) DEFAULT NULL COMMENT 'Файл',
  `attr` varchar(255) DEFAULT NULL COMMENT 'Атрибуты',
  `from` text COMMENT 'От кого',
  `to` varchar(255) DEFAULT NULL COMMENT 'Кому',
  `nick` varchar(255) DEFAULT NULL COMMENT 'Ник',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Создан',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор',
  PRIMARY KEY (`id`),
  UNIQUE KEY `combined` (`id`,`cid`),
  KEY `IDX_messages_incoming_tid` (`tid`)
) ENGINE=MyISAM AUTO_INCREMENT=90087 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=109;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages_outgoing`
--

DROP TABLE IF EXISTS `messages_outgoing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages_outgoing` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `wid` int(11) NOT NULL DEFAULT '0' COMMENT 'WhatsApp',
  `tid` int(11) NOT NULL DEFAULT '0' COMMENT 'Заявка',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'Компания',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT 'Сотрудник',
  `messenger` varchar(255) NOT NULL DEFAULT 'whatsapp' COMMENT 'Мессенджер',
  `status` tinyint(4) NOT NULL DEFAULT '9' COMMENT 'Статус',
  `proc` tinyint(4) NOT NULL DEFAULT '9' COMMENT 'Обработка',
  `text` text COMMENT 'Текст',
  `descr` text COMMENT 'Описание',
  `data` text COMMENT 'Данные',
  `type` varchar(255) DEFAULT NULL COMMENT 'Тип',
  `url` varchar(255) DEFAULT NULL COMMENT 'Файл',
  `from` varchar(255) DEFAULT NULL COMMENT 'От кого',
  `to` varchar(255) DEFAULT NULL COMMENT 'Кому',
  `nick` varchar(255) DEFAULT NULL COMMENT 'Ник',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Создан',
  `created_by` varchar(255) DEFAULT NULL COMMENT 'Автор',
  `updated_at` timestamp NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Обновлен',
  `updated_by` varchar(255) DEFAULT NULL COMMENT 'Обновил',
  PRIMARY KEY (`id`),
  UNIQUE KEY `combined` (`id`,`cid`),
  KEY `IDX_messages_outgoing_tid` (`tid`)
) ENGINE=MyISAM AUTO_INCREMENT=160623 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=451;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `tasks_address`
--

-- Dump completed on 2019-10-07  8:25:23