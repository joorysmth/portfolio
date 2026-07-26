-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 24, 2026 at 06:49 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fareed_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `group_number` int(11) NOT NULL,
  `supervisor_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `group_number`, `supervisor_id`, `created_at`) VALUES
(3, 1, 8, '2026-04-19 13:45:44'),
(4, 2, 2, '2026-04-19 13:46:14');

-- --------------------------------------------------------

--
-- Table structure for table `group_members`
--

CREATE TABLE `group_members` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `student_user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `group_members`
--

INSERT INTO `group_members` (`id`, `group_id`, `student_user_id`, `created_at`) VALUES
(4, 3, 3, '2026-04-19 13:45:52'),
(5, 3, 6, '2026-04-19 13:46:01'),
(6, 3, 10, '2026-04-19 13:46:07'),
(7, 4, 1, '2026-04-19 13:46:22'),
(8, 4, 7, '2026-04-19 13:46:28'),
(9, 4, 9, '2026-04-19 13:46:32');

-- --------------------------------------------------------

--
-- Table structure for table `projects_archive`
--

CREATE TABLE `projects_archive` (
  `id` int(11) NOT NULL,
  `project_title` varchar(500) NOT NULL,
  `abstract` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `project_submissions`
--

CREATE TABLE `project_submissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(500) NOT NULL,
  `abstract` text NOT NULL,
  `status` enum('awaiting','approved','rejected') NOT NULL DEFAULT 'awaiting',
  `similarity_result` enum('unique','duplicate') DEFAULT NULL,
  `similarity_percent` decimal(5,2) DEFAULT NULL,
  `similar_project_id` int(11) DEFAULT NULL,
  `similar_project_title` varchar(500) DEFAULT NULL,
  `similar_project_abstract` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `reviewed_by` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `project_submissions`
--

INSERT INTO `project_submissions` (`id`, `user_id`, `title`, `abstract`, `status`, `similarity_result`, `similarity_percent`, `similar_project_id`, `similar_project_title`, `similar_project_abstract`, `created_at`, `reviewed_at`, `reviewed_by`, `group_id`) VALUES
(8, 3, 'project title d', 'Abstract test Abstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract testAbstract test', 'awaiting', 'unique', '16.34', NULL, '', '', '2026-04-19 13:52:08', NULL, NULL, 3),
(9, 1, 'interfaces test test test', 'This page introduces FAREEED and explains that users can verify graduation project titles for redundancy before formal submission.\r\nIf someone is already logged in, the system redirects them automatically to the student or supervisor dashboard based on role.\r\nVisitors can create a new account or open the login page using the main call-to-action buttons on the home screen.', 'awaiting', 'unique', '18.03', NULL, '', '', '2026-04-19 15:30:43', NULL, NULL, 4);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `role` enum('student','supervisor','admin') NOT NULL,
  `username` varchar(100) NOT NULL,
  `full_name` varchar(200) NOT NULL,
  `department` varchar(200) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `privacy_accepted` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_frozen` tinyint(1) NOT NULL DEFAULT 0,
  `student_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role`, `username`, `full_name`, `department`, `email`, `password`, `phone`, `address`, `privacy_accepted`, `created_at`, `is_frozen`, `student_id`) VALUES
(1, 'student', 'Shahad', 'Shahad Ali Abdullah Al-Shahrani', 'CS', 'Shahad@gmail.com', '$2y$10$2VPG8Vbw0Khd0OmjBpRa0.HsMFDzSCWFgR2otMhEIBhbrrbLzRZ9K', '5674567876', 'abha', 1, '2026-03-07 10:51:17', 0, '‎442809107‎'),
(2, 'supervisor', 'sup2', 'sup2', 'CS', 'sup2@gmail.com', '$2y$10$Ty29b/GcBx8P4Drksc8ZCe1v./yRZUspqZwY2YapncQsdwsfC31Xa', '', '', 1, '2026-03-07 10:55:21', 0, NULL),
(3, 'student', 'Asal', 'Asal Saied Saad Algahtani‎', 'CS', 'Asal@gmail.com', '$2y$10$TnC/p3iMCzZ6uzncdNZSwu.ZJtsvULajalVB4belKb8op24BteMoS', '545657876', 'abha', 1, '2026-03-07 11:42:02', 0, '‎444808954‎'),
(5, 'admin', 'admin', 'Administrator', 'System', 'admin@gmail.com', '$2y$10$KvUMex2BpBExwlWpa1.vpeHtwZ6v4kzlKonoiS/7Ll5KaRr59RgJi', NULL, NULL, 1, '2026-03-07 19:41:54', 0, NULL),
(6, 'student', 'AlJoory', 'AlJoory Saleh Alshehri‎', 'cs', 'AlJoory@gmail.com', '$2y$10$stZtdtK.H4iSkBfkTjwL1.6kVzoKxMjAoPfGRWHo1n.AWibtN4i3m', '5657656787', 'abha', 1, '2026-03-12 17:43:19', 0, '‎444809210‎'),
(7, 'student', 'Wajd', 'Wajd Yahya Mohammed Asiri‎', 'CS', 'Wajd@gmail.com', '$2y$10$jHD2ubPKsFd6FSbkqyTmbeMvMpn/VvND.Y/b48kZvbIl08qEcc.26', '5465879876', 'abha', 1, '2026-04-19 13:14:16', 0, '‎444805996‎'),
(8, 'supervisor', 'sup1', 'sup1', 'CS', 'sup1@gmail.com', '$2y$10$zfWEH56mYKrkRxVuipfdROzdHXvLDyj0WcanbdLeDgAFnNzedLV3.', NULL, NULL, 1, '2026-04-19 13:15:43', 0, NULL),
(9, 'student', 'Wejdan', 'Wejdan Mohammed Fahm‏ ‏', 'CS', 'Wejdan@gmail.com', '$2y$10$xvKJO2ECW5Aefz903m.OTuxxpcMI3/dPgppiISuprFiY7Hpb4aNmK', NULL, NULL, 1, '2026-04-19 13:36:45', 0, '‎444808124‎'),
(10, 'student', 'Jana', 'Jana Yousef Mohammed', 'CS', 'Jana@gmail.com', '$2y$10$.qLvuzleCBUECC/l/tx8Ruah6v3ZmdMc.PWhYTlAAzvlnJoz4vH7G', '56676767678', 'abha', 1, '2026-04-19 13:44:11', 0, '‎444806568‎'),
(11, 'student', 'user1', 'user1', 'CS', 'user1@gmail.com', '$2y$10$E955jrC59.npGGHka0ZIk.Mrb/2jw6.pAAxdR/nA47/gVIqDlFQqC', NULL, NULL, 1, '2026-04-19 16:05:04', 1, '454444555');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_group_number` (`group_number`),
  ADD KEY `supervisor_id` (`supervisor_id`);

--
-- Indexes for table `group_members`
--
ALTER TABLE `group_members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_group_student` (`group_id`,`student_user_id`),
  ADD KEY `student_user_id` (`student_user_id`);

--
-- Indexes for table `projects_archive`
--
ALTER TABLE `projects_archive`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_title` (`project_title`(100));

--
-- Indexes for table `project_submissions`
--
ALTER TABLE `project_submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `fk_reviewed_by` (`reviewed_by`),
  ADD KEY `fk_submission_group` (`group_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `uq_student_id` (`student_id`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_role` (`role`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `group_members`
--
ALTER TABLE `group_members`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `project_submissions`
--
ALTER TABLE `project_submissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`supervisor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `group_members`
--
ALTER TABLE `group_members`
  ADD CONSTRAINT `group_members_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_members_ibfk_2` FOREIGN KEY (`student_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `project_submissions`
--
ALTER TABLE `project_submissions`
  ADD CONSTRAINT `fk_reviewed_by` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_submission_group` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `project_submissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
