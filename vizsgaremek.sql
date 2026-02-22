-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2026. Feb 22. 21:48
-- Kiszolgáló verziója: 5.7.24
-- PHP verzió: 8.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `vizsgaremek`
--

DELIMITER $$
--
-- Eljárások
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCartItem` (IN `p_product_id` INT, IN `p_quantity` INT)   BEGIN
    INSERT INTO cart (product_id, quantity, created_at, modified_at)
    VALUES (p_product_id, p_quantity, NOW(), NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCategory` (IN `p_name` VARCHAR(100), IN `p_desc` VARCHAR(150))   BEGIN
    INSERT INTO category (name, `desc`, created_at, modified_at)
    VALUES (p_name, p_desc, NOW(), NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddUser` (IN `p_email` VARCHAR(50), IN `p_password` VARCHAR(14), IN `p_phone` INT)   BEGIN
    INSERT INTO users (email, password, phone)
    VALUES (p_email, p_password, p_phone);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCartItem` (IN `p_id` INT)   BEGIN
    DELETE FROM cart WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCategory` (IN `p_id` INT)   BEGIN
    UPDATE category
    SET deleted_at = NOW()
    WHERE id = p_id AND deleted_at IS NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCartItems` ()   BEGIN
    SELECT * FROM cart;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCategories` ()   BEGIN
    SELECT * FROM category
    WHERE deleted_at IS NULL
    ORDER BY created_at DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllUsers` ()   BEGIN
    SELECT * FROM users;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCategoryById` (IN `p_id` INT)   BEGIN
    SELECT * FROM category
    WHERE id = p_id AND deleted_at IS NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserById` (IN `p_id` INT)   BEGIN
    SELECT * FROM users WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `HardDeleteCategory` (IN `p_id` INT)   BEGIN
    DELETE FROM category WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCartItem` (IN `p_id` INT, IN `p_product_id` INT, IN `p_quantity` INT)   BEGIN
    UPDATE cart
    SET
        product_id = p_product_id,
        quantity = p_quantity,
        modified_at = NOW()
    WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCategory` (IN `p_id` INT, IN `p_name` VARCHAR(100), IN `p_desc` VARCHAR(150))   BEGIN
    UPDATE category
    SET
        name = p_name,
        `desc` = p_desc,
        modified_at = NOW()
    WHERE id = p_id AND deleted_at IS NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUser` (IN `p_id` INT, IN `p_email` VARCHAR(50), IN `p_password` VARCHAR(14), IN `p_phone` INT)   BEGIN
    UPDATE users
    SET
        email = p_email,
        password = p_password,
        phone = p_phone
    WHERE id = p_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `cart`
--

INSERT INTO `cart` (`id`, `product_id`, `quantity`, `created_at`, `modified_at`) VALUES
(2, 0, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 1, 2, '2026-01-08 12:56:18', '2026-01-08 12:56:18'),
(4, 2, 1, '2026-01-08 12:56:18', '2026-01-08 12:56:18'),
(5, 3, 5, '2026-01-08 12:56:18', '2026-01-08 12:56:18'),
(6, 4, 1, '2026-01-08 12:56:18', '2026-01-08 12:56:18'),
(7, 5, 3, '2026-01-08 12:56:18', '2026-01-08 12:56:18'),
(8, 1, 4, '2026-01-08 12:56:18', '2026-01-08 12:56:18'),
(9, 2, 2, '2026-01-08 12:56:18', '2026-01-08 12:56:18'),
(10, 3, 1, '2026-01-08 12:56:18', '2026-01-08 12:56:18'),
(11, 4, 6, '2026-01-08 12:56:18', '2026-01-08 12:56:18'),
(12, 5, 2, '2026-01-08 12:56:18', '2026-01-08 12:56:18');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `desc` varchar(150) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `category`
--

INSERT INTO `category` (`id`, `name`, `desc`, `created_at`, `modified_at`, `deleted_at`) VALUES
(1, 'Kormányborítás', '', '2026-01-08 12:55:04', '2026-01-08 12:55:04', '2026-01-08 12:55:04'),
(2, 'Üléshuzat', '', '2026-01-08 12:55:04', '2026-01-08 12:55:04', '2026-01-08 12:55:04'),
(3, 'Ajtó kárpit', '', '2026-01-08 12:55:04', '2026-01-08 12:55:04', '2026-01-08 12:55:04'),
(4, 'Pedál', '', '2026-01-08 12:55:04', '2026-01-08 12:55:04', '2026-01-08 12:55:04'),
(5, 'Műszerfal borítás', '', '2026-01-08 12:55:04', '2026-01-08 12:55:04', '2026-01-08 12:55:04'),
(6, 'Középkonzol', '', '2026-01-08 12:55:04', '2026-01-08 12:55:04', '2026-01-08 12:55:04'),
(7, 'Tetőkárpit', '', '2026-01-08 12:55:04', '2026-01-08 12:55:04', '2026-01-08 12:55:04'),
(8, 'Váltógomb', '', '2026-01-08 12:55:04', '2026-01-08 12:55:04', '2026-01-08 12:55:04'),
(9, 'Multimédiás eszököz', '', '2026-01-08 12:55:04', '2026-01-08 12:55:04', '2026-01-08 12:55:04'),
(10, 'Légfrissítő', '', '2026-01-08 12:55:04', '2026-01-08 12:55:04', '2026-01-08 12:55:04'),
(11, 'Csomagtér választó', '', '2026-01-12 10:34:59', '2026-01-12 10:35:42', '2026-01-12 10:35:42');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `customer`
--

CREATE TABLE `customer` (
  `id` int(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(14) NOT NULL,
  `phone` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `customer`
--

INSERT INTO `customer` (`id`, `email`, `password`, `phone`) VALUES
(1, 'anna.kiss@test.hu', 'password123', 2147483647),
(2, 'bela.nagy@test.hu', 'password123', 2147483647),
(3, 'csilla.toth@test.hu', 'password123', 2147483647),
(4, 'david.horvath@test.hu', 'password123', 2147483647),
(5, 'eva.szabo@test.hu', 'password123', 2147483647),
(6, 'ferenc.varga@test.hu', 'password123', 2147483647),
(7, 'gina.kovacs@test.hu', 'password123', 2147483647),
(8, 'istvan.balogh@test.hu', 'password123', 2147483647),
(9, 'julia.fekete@test.hu', 'password123', 2147483647),
(10, 'mark.papp@test.hu', 'password123', 2147483647);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `discount`
--

CREATE TABLE `discount` (
  `id` int(11) NOT NULL,
  `name` varchar(75) NOT NULL,
  `desc` varchar(200) NOT NULL,
  `discount_percent` decimal(10,0) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `discount`
--

INSERT INTO `discount` (`id`, `name`, `desc`, `discount_percent`, `active`, `created_at`, `modified_at`, `deleted_at`) VALUES
(1, 'Tavaszi akció', 'Tavaszi szezonális kedvezmény', '10', 1, '2026-01-08 12:59:26', '2026-01-08 12:59:26', '2026-01-08 12:59:26'),
(2, 'Nyári akció', 'Nyári leárazás', '15', 1, '2026-01-08 12:59:26', '2026-01-08 12:59:26', '2026-01-08 12:59:26'),
(3, 'Őszi akció', 'Őszi szezonális kedvezmény', '20', 1, '2026-01-08 12:59:26', '2026-01-08 12:59:26', '2026-01-08 12:59:26'),
(4, 'Téli akció', 'Téli kiárusítás', '25', 1, '2026-01-08 12:59:26', '2026-01-08 12:59:26', '2026-01-08 12:59:26'),
(5, 'Black Friday', 'Black Friday kedvezmény', '30', 1, '2026-01-08 12:59:26', '2026-01-08 12:59:26', '2026-01-08 12:59:26'),
(6, 'Cyber Monday', 'Cyber Monday online kedvezmény', '35', 0, '2026-01-08 12:59:26', '2026-01-08 12:59:26', '2026-01-08 12:59:26'),
(7, 'Hűségkedvezmény', 'Visszatérő vásárlóknak', '5', 1, '2026-01-08 12:59:26', '2026-01-08 12:59:26', '2026-01-08 12:59:26'),
(8, 'Új vásárló', 'Első vásárlás kedvezménye', '10', 1, '2026-01-08 12:59:26', '2026-01-08 12:59:26', '2026-01-08 12:59:26'),
(9, 'VIP', 'VIP ügyfeleknek szóló kedvezmény', '40', 0, '2026-01-08 12:59:26', '2026-01-08 12:59:26', '2026-01-08 12:59:26'),
(10, 'Lejárt akció', 'Már nem érvényes kedvezmény', '50', 0, '2026-01-08 12:59:26', '2026-01-08 12:59:26', '2026-01-08 12:59:26');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `model`
--

CREATE TABLE `model` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `model`
--

INSERT INTO `model` (`id`, `name`) VALUES
(1, 'Kia Ceed'),
(2, 'Audi A6'),
(3, 'BMW E46'),
(4, 'Toyota Corolla');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `order`
--

CREATE TABLE `order` (
  `id` int(10) NOT NULL,
  `customer_id` varchar(20) NOT NULL,
  `total` decimal(10,0) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `order`
--

INSERT INTO `order` (`id`, `customer_id`, `total`, `payment_id`, `created_at`, `modified_at`) VALUES
(1, '1', '12500', 1, '2026-01-08 13:00:46', '2026-01-08 13:00:46'),
(2, '2', '23990', 2, '2026-01-08 13:00:46', '2026-01-08 13:00:46'),
(3, '3', '8990', 1, '2026-01-08 13:00:46', '2026-01-08 13:00:46'),
(4, '4', '45900', 3, '2026-01-08 13:00:46', '2026-01-08 13:00:46'),
(5, '5', '15990', 2, '2026-01-08 13:00:46', '2026-01-08 13:00:46'),
(6, '6', '29990', 1, '2026-01-08 13:00:46', '2026-01-08 13:00:46'),
(7, '7', '7490', 1, '2026-01-08 13:00:46', '2026-01-08 13:00:46'),
(8, '8', '18990', 3, '2026-01-08 13:00:46', '2026-01-08 13:00:46'),
(9, '9', '32990', 2, '2026-01-08 13:00:46', '2026-01-08 13:00:46'),
(10, '10', '9990', 1, '2026-01-08 13:00:46', '2026-01-08 13:00:46');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `order_date` datetime(6) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `order_item`
--

CREATE TABLE `order_item` (
  `id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `orders_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `order_items`
--

CREATE TABLE `order_items` (
  `id` int(10) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `created_at`, `modified_at`) VALUES
(1, 1, 1, 2, '2026-01-08 13:02:22', '2026-01-08 13:02:22'),
(2, 1, 3, 1, '2026-01-08 13:02:22', '2026-01-08 13:02:22'),
(3, 2, 2, 4, '2026-01-08 13:02:22', '2026-01-08 13:02:22'),
(4, 2, 5, 1, '2026-01-08 13:02:22', '2026-01-08 13:02:22'),
(5, 3, 1, 3, '2026-01-08 13:02:22', '2026-01-08 13:02:22'),
(6, 4, 4, 2, '2026-01-08 13:02:22', '2026-01-08 13:02:22'),
(7, 5, 2, 5, '2026-01-08 13:02:22', '2026-01-08 13:02:22'),
(8, 6, 3, 1, '2026-01-08 13:02:22', '2026-01-08 13:02:22'),
(9, 7, 5, 2, '2026-01-08 13:02:22', '2026-01-08 13:02:22'),
(10, 8, 4, 3, '2026-01-08 13:02:22', '2026-01-08 13:02:22');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `payment`
--

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `provider` varchar(10) NOT NULL,
  `status` varchar(3) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `payment`
--

INSERT INTO `payment` (`id`, `order_id`, `amount`, `provider`, `status`, `created_at`, `modified_at`) VALUES
(1, 1, 12500, 'card', 'pai', '2026-01-08 13:03:30', '2026-01-08 13:03:30'),
(2, 2, 23990, 'cash', 'pai', '2026-01-08 13:03:30', '2026-01-08 13:03:30'),
(3, 3, 8990, 'card', 'pai', '2026-01-08 13:03:30', '2026-01-08 13:03:30'),
(4, 4, 45900, 'transfer', 'pen', '2026-01-08 13:03:30', '2026-01-08 13:03:30'),
(5, 5, 15990, 'card', 'pai', '2026-01-08 13:03:30', '2026-01-08 13:03:30'),
(6, 6, 29990, 'cash', 'fai', '2026-01-08 13:03:30', '2026-01-08 13:03:30'),
(7, 7, 7490, 'card', 'pai', '2026-01-08 13:03:30', '2026-01-08 13:03:30'),
(8, 8, 18990, 'transfer', 'pai', '2026-01-08 13:03:30', '2026-01-08 13:03:30'),
(9, 9, 32990, 'card', 'pen', '2026-01-08 13:03:30', '2026-01-08 13:03:30'),
(10, 10, 9990, 'cash', 'pai', '2026-01-08 13:03:30', '2026-01-08 13:03:30');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `product`
--

CREATE TABLE `product` (
  `id` int(10) NOT NULL,
  `name` varchar(200) NOT NULL,
  `desc` text NOT NULL,
  `category_id` int(11) NOT NULL,
  `discount_id` int(11) NOT NULL,
  `price` double DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `image_url` varchar(500) DEFAULT NULL,
  `model_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `product`
--

INSERT INTO `product` (`id`, `name`, `desc`, `category_id`, `discount_id`, `price`, `created_at`, `modified_at`, `deleted_at`, `image_url`, `model_id`) VALUES
(1, 'Alcantara üléshuzat', 'Prémium Alcantara ülésvédő huzat.', 1, 1, 60000, '2026-01-08 13:04:51', '2026-01-08 13:04:51', '2026-01-08 13:04:51', 'alcantara.jpg', NULL),
(2, 'Egyszerű csomagtér választó háló', 'Minden járműhöz lehet használni.', 1, 2, 1990, '2026-01-08 13:04:51', '2026-01-08 13:04:51', '2026-01-08 13:04:51', 'csomagter-halo.jpg', NULL),
(3, 'Multimédiás fejegység', 'Érintőkijelzős fejegység Bluetooth-tal, Android Auto-val és Apple CarPlay-yel.', 2, 3, 45990, '2026-01-08 13:04:51', '2026-01-08 13:04:51', '2026-01-08 13:04:51', 'multimedias-fejegyseg.jpg', NULL),
(4, 'Sport váltógomb (5 Fokozatú)', 'Bármilyen autóba illik aminek 5 fokozatú váltóje van.', 5, 4, 3990, '2026-01-08 13:04:51', '2026-01-08 13:04:51', '2026-01-08 13:04:51', 'sport-valtogomb.jpg', NULL),
(5, 'Areon cseresznye légfrissítő', 'Cseresznye illatú Areon legfrissítő', 3, 1, 1500, '2026-01-08 13:04:51', '2026-01-08 13:04:51', '2026-01-08 13:04:51', 'areon-legfrissito.jpg', NULL),
(6, 'Alumínium pedálszett', 'Ez a szett tartalmaz egy gázpedált egy fékpedált és egy kuplung pedál is.', 4, 5, 12990, '2026-01-08 13:04:51', '2026-01-08 13:04:51', '2026-01-08 13:04:51', 'aluminum-pedalszett.jpg', NULL),
(7, 'Világos műszerfal borítás', 'Ez egy műszerfal borítás amit személyre szabható és könnyen tisztítható', 6, 2, 8990, '2026-01-08 13:04:51', '2026-01-08 13:04:51', '2026-01-08 13:04:51', 'muszerfal-boritas.jpg', NULL),
(8, 'Audi A6 C7 Első ajtó kárpit szett', 'Ez egy kárpit szett ami csak is kizárólag Audi A6 C7 autó belsejére jó', 7, 0, 29990, '2026-01-08 13:04:51', '2026-01-08 13:04:51', '2026-01-08 13:04:51', 'audi-a6-karpit.jpg', NULL),
(9, 'Fém rácsos csomagtér választó', 'Csomagtér választó ami megvédi a csomagok előtt ülő utasok biztonságát. Ez a csomagtér választó kizárólag csak kombiban jó.', 8, 1, 6990, '2026-01-08 13:04:51', '2026-01-08 13:04:51', '2026-01-08 13:04:51', 'fem-racsos-csomagter.jpg', NULL),
(10, 'Multifunkcionális kormány borítás', 'Ez minden kormányhoz jó', 10, 0, 1900, '2026-01-08 13:04:51', '2026-01-12 10:39:51', '2026-01-08 13:04:51', 'kormany-boritas.jpg', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `shipment`
--

CREATE TABLE `shipment` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `status` varchar(3) NOT NULL,
  `tracking_code` varchar(50) NOT NULL,
  `shipped_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delivered_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `shipment`
--

INSERT INTO `shipment` (`id`, `order_id`, `status`, `tracking_code`, `shipped_at`, `delivered_at`) VALUES
(1, 1, 'shi', 'TRK0001', '2026-01-08 13:06:32', '2026-01-08 13:06:32'),
(2, 2, 'del', 'TRK0002', '2026-01-05 13:06:32', '2026-01-07 13:06:32'),
(3, 3, 'pen', 'TRK0003', '2026-01-08 13:06:32', '2026-01-08 13:06:32'),
(4, 4, 'shi', 'TRK0004', '2026-01-07 13:06:32', '2026-01-08 13:06:32'),
(5, 5, 'del', 'TRK0005', '2026-01-03 13:06:32', '2026-01-06 13:06:32'),
(6, 6, 'shi', 'TRK0006', '2026-01-06 13:06:32', '2026-01-08 13:06:32'),
(7, 7, 'pen', 'TRK0007', '2026-01-08 13:06:32', '2026-01-08 13:06:32'),
(8, 8, 'del', 'TRK0008', '2026-01-04 13:06:32', '2026-01-07 13:06:32'),
(9, 9, 'shi', 'TRK0009', '2026-01-08 13:06:32', '2026-01-08 13:06:32'),
(10, 10, 'del', 'TRK0010', '2026-01-02 13:06:32', '2026-01-05 13:06:32');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- A tábla indexei `discount`
--
ALTER TABLE `discount`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `model`
--
ALTER TABLE `model`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK624gtjin3po807j3vix093tlf` (`customer_id`);

--
-- A tábla indexei `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKea29bb770t1s99pp2ngvhgwnt` (`orders_id`),
  ADD KEY `FK551losx9j75ss5d6bfsqvijna` (`product_id`);

--
-- A tábla indexei `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `shipment`
--
ALTER TABLE `shipment`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT a táblához `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT a táblához `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `discount`
--
ALTER TABLE `discount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `model`
--
ALTER TABLE `model`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `order`
--
ALTER TABLE `order`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `order_item`
--
ALTER TABLE `order_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `payment`
--
ALTER TABLE `payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `product`
--
ALTER TABLE `product`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `shipment`
--
ALTER TABLE `shipment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK624gtjin3po807j3vix093tlf` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);

--
-- Megkötések a táblához `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `FK551losx9j75ss5d6bfsqvijna` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FKea29bb770t1s99pp2ngvhgwnt` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
