-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 23, 2025 at 03:43 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `christian_coffee`
--

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `id` int(11) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `attempt_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `success` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`id`, `ip_address`, `username`, `attempt_time`, `success`) VALUES
(38, '::1', 'rubbek', '2025-09-18 07:32:03', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','processing','completed','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `total_amount`, `status`, `created_at`) VALUES
(1, 4, 500.00, 'pending', '2025-09-18 07:09:34'),
(2, 4, 500.00, 'pending', '2025-09-18 07:10:01'),
(3, 4, 1390.00, 'pending', '2025-09-18 07:10:34'),
(4, 4, 1400.00, 'pending', '2025-09-18 07:12:57'),
(5, 3, 1590.00, 'pending', '2025-09-18 07:32:56'),
(6, 3, 260.00, 'pending', '2025-09-18 07:33:27');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 2, 1, 150.00),
(2, 1, 10, 1, 350.00),
(3, 2, 2, 1, 150.00),
(4, 2, 10, 1, 350.00),
(5, 3, 1, 2, 120.00),
(6, 3, 2, 1, 150.00),
(7, 3, 4, 5, 130.00),
(8, 3, 10, 1, 350.00),
(9, 4, 2, 4, 150.00),
(10, 4, 3, 5, 160.00),
(11, 5, 2, 1, 150.00),
(12, 5, 4, 3, 130.00),
(13, 5, 10, 3, 350.00),
(14, 6, 4, 2, 130.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `image`, `quantity`, `created_at`) VALUES
(1, 'Espresso', 'Rich and bold shot of pure coffee perfection', 120.00, 'espresso.webp', 48, '2025-09-18 06:55:09'),
(2, 'Cappuccino', 'Perfect blend of espresso, steamed milk, and foam', 150.00, 'cappucino.jpg', 37, '2025-09-18 06:55:09'),
(3, 'Latte', 'Smooth espresso with steamed milk and light foam', 160.00, 'latte.jpg', 35, '2025-09-18 06:55:09'),
(4, 'Americano', 'Espresso shots with hot water for a clean taste', 130.00, 'americano.jpeg', 50, '2025-09-18 06:55:09'),
(5, 'Mocha', 'Delicious combination of coffee, chocolate, and steamed milk', 180.00, 'mocha.png', 35, '2025-09-18 06:55:09'),
(6, 'Macchiato', 'Espresso marked with a dollop of steamed milk foam', 140.00, 'macchiato.avif', 30, '2025-09-18 06:55:09'),
(7, 'Frappuccino', 'Blended iced coffee drink with whipped cream', 200.00, 'frappuccino.jpg', 25, '2025-09-18 06:55:09'),
(8, 'Cold Brew', 'Smooth, less acidic coffee brewed with cold water', 170.00, 'beans.jpg', 38, '2025-09-18 06:55:09'),
(9, 'Turkish Coffee', 'Traditional unfiltered coffee with rich flavor', 190.00, 'turkish.jpg', 20, '2025-09-18 06:55:09'),
(10, 'Coffee Beans (250g)', 'Premium arabica beans for home brewing', 350.00, 'Coldbrew.png', 94, '2025-09-18 06:55:09');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'admin', 'admin@christiancoffee.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', '2025-09-18 06:55:09'),
(3, 'rubbek', 'akosirhovic.15@gmail.com', '$2y$10$gOsixJ8k2j5iMP1AQ6Qh7ubQCxmxXe5AI57MEGyDhb25ZjXJjeoFW', 'admin', '2025-09-18 06:57:32'),
(4, 'Yami', 'rhovicmendoza.rm@gmail.com', '$2y$10$IaEfNjJ5dxIfj9xjoTu.TOFpLfKsmeWEQZyBfcPf4MFHPomJagbke', 'user', '2025-09-18 06:59:56'),
(5, '123', 'rhovic.delasarmas@gmail.com', '$2y$10$KrWDdfzTffecBj1Q4LK3nOAdBQ7sRqDzMY8AztxmH3ny2er/CEcJW', 'user', '2025-09-18 07:16:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ip_time` (`ip_address`,`attempt_time`),
  ADD KEY `idx_username_time` (`username`,`attempt_time`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
