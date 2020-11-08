/*
 Navicat Premium Data Transfer

 Source Server         : local_mysql
 Source Server Type    : MySQL
 Source Server Version : 100411
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 100411
 File Encoding         : 65001

 Date: 06/11/2020 13:05:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for aca_batch
-- ----------------------------
DROP TABLE IF EXISTS `aca_batch`;
CREATE TABLE `aca_batch`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `ProgramID` int(11) NOT NULL,
  `SessionID` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `Code`(`Code`) USING BTREE,
  UNIQUE INDEX `Name`(`Name`, `ProgramID`) USING BTREE,
  INDEX `fk_aca_batch_proram`(`ProgramID`) USING BTREE,
  INDEX `fk_aca_batch_session`(`SessionID`) USING BTREE,
  CONSTRAINT `fk_aca_batch_proram` FOREIGN KEY (`ProgramID`) REFERENCES `aca_program` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_aca_batch_session` FOREIGN KEY (`SessionID`) REFERENCES `aca_session` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_batch
-- ----------------------------
INSERT INTO `aca_batch` VALUES (1, 'BATCH-001', 'B.S.S 1st Batch', 'B.S.S 1st Batch', '2018-01-01', '2021-12-31', 1, 1, 1, 'admin', '2020-10-14 11:10:06', 'admin', '2020-10-17 09:32:22');
INSERT INTO `aca_batch` VALUES (2, 'BATCH-002', 'B.S.S 2nd Batch', 'B.S.S 2nd Batch', '2019-01-01', '2022-12-31', 1, 2, 1, '', '0000-00-00 00:00:00', 'admin', '2020-10-21 22:47:52');
INSERT INTO `aca_batch` VALUES (3, 'BATCH-003', 'B.S.S 3rd Batch', 'B.S.S 3rd Batch', '2020-01-01', '2023-12-31', 1, 3, 1, 'admin', '2020-10-17 09:32:10', 'admin', '2020-10-19 10:06:39');
INSERT INTO `aca_batch` VALUES (4, 'MSJ-16', 'MJS-16 Batch', 'MJS-16 Batch', '2018-01-01', '2020-12-31', 3, 1, 1, 'admin', '2020-10-17 09:33:12', 'Shahin', '2020-11-04 10:27:41');
INSERT INTO `aca_batch` VALUES (5, 'MJS-17', 'MJS-17 Batch', 'MJS-17 Batch', '2019-01-01', '2021-12-31', 3, 2, 1, 'admin', '2020-11-03 13:41:09', 'Shahin', '2020-11-04 10:28:40');

-- ----------------------------
-- Table structure for aca_batch_running_semester
-- ----------------------------
DROP TABLE IF EXISTS `aca_batch_running_semester`;
CREATE TABLE `aca_batch_running_semester`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `BatchID` int(11) NOT NULL,
  `SemesterID` int(11) NOT NULL,
  `SessionID` int(11) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`BatchID`, `SemesterID`) USING BTREE,
  UNIQUE INDEX `ID`(`ID`) USING BTREE,
  INDEX `fk_aca_batch_running_semester_aca_semester`(`SemesterID`) USING BTREE,
  INDEX `fk_aca_batch_running_semester_aca_session`(`SessionID`) USING BTREE,
  CONSTRAINT `fk_aca_batch_running_semester_aca_batch` FOREIGN KEY (`BatchID`) REFERENCES `aca_batch` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_aca_batch_running_semester_aca_semester` FOREIGN KEY (`SemesterID`) REFERENCES `aca_semester` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_aca_batch_running_semester_aca_session` FOREIGN KEY (`SessionID`) REFERENCES `aca_session` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for aca_class_schedule_details
-- ----------------------------
DROP TABLE IF EXISTS `aca_class_schedule_details`;
CREATE TABLE `aca_class_schedule_details`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ClassScheduID` int(11) NOT NULL,
  `DayID` int(11) NOT NULL,
  `RoomID` int(11) NOT NULL,
  `TimeID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`DayID`, `RoomID`, `TimeID`, `Date`) USING BTREE,
  UNIQUE INDEX `ID`(`ID`) USING BTREE,
  INDEX `aca_class_schedule_class_master`(`ClassScheduID`) USING BTREE,
  INDEX `aca_class_schedule_time`(`TimeID`) USING BTREE,
  INDEX `aca_class_schedule_room`(`RoomID`) USING BTREE,
  CONSTRAINT `aca_class_schedule_class_master` FOREIGN KEY (`ClassScheduID`) REFERENCES `aca_class_schedule_master` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `aca_class_schedule_days` FOREIGN KEY (`DayID`) REFERENCES `aca_days` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `aca_class_schedule_room` FOREIGN KEY (`RoomID`) REFERENCES `aca_room` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `aca_class_schedule_time` FOREIGN KEY (`TimeID`) REFERENCES `aca_time_slot` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_class_schedule_details
-- ----------------------------
INSERT INTO `aca_class_schedule_details` VALUES (1, 1, 1, 1, 1, '2020-11-04', 'admin', '0000-00-00 00:00:00');
INSERT INTO `aca_class_schedule_details` VALUES (2, 1, 2, 3, 2, '2020-11-03', 'admin', '0000-00-00 00:00:00');
INSERT INTO `aca_class_schedule_details` VALUES (5, 3, 2, 3, 3, '2020-11-06', 'admin', '0000-00-00 00:00:00');
INSERT INTO `aca_class_schedule_details` VALUES (3, 2, 3, 3, 3, '2020-11-04', 'admin', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for aca_class_schedule_master
-- ----------------------------
DROP TABLE IF EXISTS `aca_class_schedule_master`;
CREATE TABLE `aca_class_schedule_master`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProgramID` int(11) NOT NULL,
  `SemesterID` int(11) NOT NULL,
  `CourserID` int(11) NOT NULL,
  `BatchID` int(11) NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ProgramID`, `SemesterID`, `CourserID`, `BatchID`, `StartDate`, `EndDate`) USING BTREE,
  UNIQUE INDEX `ID`(`ID`) USING BTREE,
  INDEX `aca_class_schedule_semester`(`SemesterID`) USING BTREE,
  INDEX `aca_class_schedule_batch`(`BatchID`) USING BTREE,
  INDEX `aca_class_schedule_course`(`CourserID`) USING BTREE,
  CONSTRAINT `aca_class_schedule_batch` FOREIGN KEY (`BatchID`) REFERENCES `aca_batch` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `aca_class_schedule_course` FOREIGN KEY (`CourserID`) REFERENCES `aca_course` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `aca_class_schedule_program` FOREIGN KEY (`ProgramID`) REFERENCES `aca_program` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `aca_class_schedule_semester` FOREIGN KEY (`SemesterID`) REFERENCES `aca_semester` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_class_schedule_master
-- ----------------------------
INSERT INTO `aca_class_schedule_master` VALUES (1, 1, 2, 5, 1, '2020-11-01', '2020-11-03', 'admin', '2020-11-01 00:20:59', '', '0000-00-00 00:00:00');
INSERT INTO `aca_class_schedule_master` VALUES (2, 2, 2, 6, 1, '2020-11-01', '2020-11-05', 'admin', '2020-11-04 00:22:14', '', '0000-00-00 00:00:00');
INSERT INTO `aca_class_schedule_master` VALUES (3, 3, 3, 4, 4, '2020-11-03', '2020-11-05', 'admin', '2020-11-03 00:22:48', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for aca_course
-- ----------------------------
DROP TABLE IF EXISTS `aca_course`;
CREATE TABLE `aca_course`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Credit` int(11) NOT NULL,
  `Hours` int(11) NOT NULL,
  `Marks` int(11) NOT NULL,
  `RetakeMarks` int(11) NOT NULL,
  `RetakeTimes` int(11) NOT NULL,
  `ProgramID` int(11) NOT NULL,
  `SemesterID` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` int(11) NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `Code`(`Code`) USING BTREE,
  UNIQUE INDEX `Name`(`Name`) USING BTREE,
  INDEX `fk_aca_course_aca_program`(`ProgramID`) USING BTREE,
  INDEX `fk_aca_course_aca_semester`(`SemesterID`) USING BTREE,
  CONSTRAINT `fk_aca_course_aca_program` FOREIGN KEY (`ProgramID`) REFERENCES `aca_program` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_aca_course_aca_semester` FOREIGN KEY (`SemesterID`) REFERENCES `aca_semester` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_course
-- ----------------------------
INSERT INTO `aca_course` VALUES (1, 'JS 001', 'Principles of Economics', '1.  Basic Concepts of Economics: Scarcity, choice and opportunity cost. Demand: the law of demand, the demand curve, individual and market demand, factors affecting the demand curve, shifts vs movement along the demand curve, elastic and inelastic demand. Supply: the law of supply, the supply curve, factors affecting the supply curve, shifts vs movement along the supply curve, elasticity of supply. \r\n2.  Market: Market equilibrium: interaction of demand and supply, effect of a shift in demand or supply or both, effect of a tax or a subsidy; price controls. Market structure: perfectly competitive markets, monopoly, oligopoly (game theory), monopolistic competition. Factor market: input hiring decision, competitive factor markets, monopsony, capital theory, concept of net present value (NPV), project appraisal, inter-temporal choice. Market failures: externalities, public goods, natural monopoly; Information economics: moral hazard and adverse selection. \r\n3.  Consumer Behaviour: Utility and choice, marginal utility, law of diminishing marginal utility, equimarginal principle, indifference curves and their properties, budget sets, equilibrium of the consumer with indifference curves and budget sets, income and substitution effects, derivation of the demand curve from the indifference curves and budget sets, complements and substitutes, consumer and producer surplus. \r\n4.  Production, Cost and Revenue: Concept of a production function, total, average and marginal product, the law of diminishing returns, returns to scale. Costs: fixed and variable cost, total, average and marginal cost, short-run and long-run costs, sunk cost, opportunity cost. Revenue: total, average and marginal revenue. Decision of a firm: isoquants, isocosts and the least cost combination, equating marginal revenue with marginal cost.\r\n5.  Macroeconomic Variables: National income, employment, interest and price, measuring the total activity of an economy: real GDP vs nominal GDP, price deflators. GDP and its components: consumption, investment, government expenditure, net exports and investment multiplier. \r\n6.  Determination of Income, Employment, Interest and Price in the Classical Model: The quantity theory of money, neutrality and dichotomy, criticisms of the classical model: the great depression, the Keynesian theory of income, employment; interest and price: the IS-LM framework. \r\n7.  Monetary and Fiscal Policies in the Keynesian Model: Economic fluctuations: Keynesian explanations; equilibrium business cycles, the real business cycle theory; the new Keynesians: menu costs, coordination failures, staggered prices; critique of the Keynesian model: the monetarists’ view, the rational expectations school. \r\n8.  Consumption, Capital and Money: Theories of consumption, capital theory and investment, money demand and supply. \r\n9.  Government: Debate over government debt, the Ricardian proposition, lags in government policy. \r\n10.  Economic Thoughts: Classical; Marxian; Neo-classical; Austrian; Keyenesian; Institutional; Behavioural. Globalization; Neo-liberalism.   \r\n', 4, 2, 100, 59, 2, 1, 1, 1, 0, '2020-10-14 11:19:23', 'admin', '2020-10-16 09:23:11');
INSERT INTO `aca_course` VALUES (2, 'JS 102', 'Principles of Sociology ', 'Principles of Sociology ', 4, 2, 100, 59, 2, 1, 1, 1, 0, '2020-10-15 09:48:14', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (3, 'JS 103', 'Principles of Political Science', '', 4, 2, 100, 59, 2, 1, 1, 1, 0, '2020-10-15 11:44:15', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (4, 'JS 104', 'Elementary Japanese Language (Part- 1)', '', 4, 2, 100, 59, 2, 1, 1, 1, 0, '2020-10-15 11:45:19', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (5, 'JS 201', 'Statistics', '', 4, 2, 100, 59, 2, 1, 2, 1, 0, '2020-10-15 11:53:19', 'admin', '2020-10-15 13:50:28');
INSERT INTO `aca_course` VALUES (6, 'JS 202', 'Japanese History and Civilization', '', 4, 2, 100, 59, 2, 1, 2, 1, 0, '2020-10-15 11:54:17', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (7, 'JS 203', 'Sociology of Japanese Society', 'Sociology of Japanese Society', 4, 2, 100, 59, 2, 1, 2, 1, 0, '2020-10-15 11:54:54', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (8, 'JS 204', 'Elementary Japanese Language (Part-2)', 'Elementary Japanese Language (Part-2)', 4, 2, 100, 59, 2, 1, 2, 1, 0, '2020-10-15 11:56:51', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (9, 'JS 301', 'Bangladesh Studies', 'Bangladesh Studies', 4, 2, 100, 59, 2, 1, 3, 1, 0, '2020-10-15 11:57:38', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (10, 'JS 302', 'Modernisation and Economic Development in Japan', 'Modernisation and Economic Development in Japan', 4, 2, 100, 59, 2, 1, 3, 1, 0, '2020-10-15 11:58:30', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (11, 'JS 303', 'Post-elementary Japanese Language', 'Post-elementary Japanese Language', 4, 2, 100, 59, 2, 1, 3, 1, 0, '2020-10-15 11:59:54', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (12, 'JS 304', 'Japanese Business Management and Communication', 'Japanese Business Management and Communication', 4, 2, 100, 59, 2, 1, 3, 1, 0, '2020-10-15 12:00:36', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (13, 'JS 305', 'Social and Cultural Geography of Japan', 'Social and Cultural Geography of Japan', 4, 2, 100, 59, 2, 1, 3, 1, 0, '2020-10-15 12:01:49', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (14, 'JS 306', 'Japanese Kanji (Part-1)', 'Japanese Kanji (Part-1)', 4, 2, 100, 59, 2, 1, 3, 1, 0, '2020-10-15 12:02:36', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (15, 'JS 401', 'Government and Politics of Japan', 'Government and Politics of Japan', 4, 2, 100, 59, 2, 1, 4, 1, 0, '2020-10-15 12:03:36', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (16, 'JS 402', 'Information and Communication Technology: Japan an', 'Information and Communication Technology:\r\nJapan and Bangladesh', 4, 2, 100, 59, 2, 1, 4, 1, 0, '2020-10-15 12:04:15', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (17, 'JS 403', 'Intermediate Japanese Language (Part-1)', 'Intermediate Japanese Language (Part-1)', 4, 2, 100, 59, 2, 1, 4, 1, 0, '2020-10-15 12:05:09', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (18, 'JS 404', 'Sculptural Art and Architecture of Japan and Bangl', 'Sculptural Art and Architecture of Japan and Bangladesh', 4, 2, 100, 59, 2, 1, 4, 1, 0, '2020-10-15 12:05:44', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (19, 'JS 405', 'Japanese Media', 'Japanese Media', 4, 2, 100, 59, 2, 1, 4, 1, 0, '2020-10-15 12:06:32', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (20, 'JS 406', 'Japan and South Asia', 'Japan and South Asia', 4, 2, 100, 59, 2, 1, 4, 1, 0, '2020-10-15 12:07:10', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (21, 'JS 407', 'Japanese Kanji (Part-2)', 'Japanese Kanji (Part-2)', 4, 2, 100, 59, 2, 1, 4, 1, 0, '2020-10-15 12:07:43', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (22, 'JS 901', 'Development Policy of Japan', 'Development Policy of Japan', 4, 2, 100, 59, 2, 2, 9, 1, 0, '2020-10-15 12:15:00', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (23, 'JS 902', 'Japanese Linguistics', 'Japanese Linguistics', 4, 2, 100, 59, 2, 2, 9, 1, 0, '2020-10-15 12:15:38', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (24, 'JS 903', 'Japanese Law, Society and Public Policy', 'Japanese Law, Society and Public Policy', 4, 2, 100, 59, 2, 2, 9, 1, 0, '2020-10-15 12:16:15', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (25, 'JS 904', 'Post-war Japanese Political Thought', 'Post-war Japanese Political Thought', 4, 2, 100, 59, 2, 2, 9, 1, 0, '2020-10-15 12:16:54', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (26, 'JS 905', 'Modern Japanese Literature', 'Modern Japanese Literature', 4, 2, 100, 59, 2, 2, 9, 1, 0, '2020-10-15 12:17:28', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (27, 'JS 906', 'Minorities and Marginalities: Class and Conflict i', 'Minorities and Marginalities: Class and Conflict in Japan', 4, 2, 100, 59, 2, 2, 9, 1, 0, '2020-10-15 12:18:05', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (28, 'JS 1001', 'Political Economy of Japan', 'Political Economy of Japan', 4, 2, 100, 59, 2, 2, 10, 1, 0, '2020-10-15 12:18:55', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (29, 'JS 1002', 'Contemporary Japan', 'Contemporary Japan', 4, 2, 100, 59, 2, 2, 10, 1, 0, '2020-10-15 12:19:34', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (30, 'JS 1003', 'Disaster and Development in Japan', 'Disaster and Development in Japan', 4, 2, 100, 59, 2, 2, 10, 1, 0, '2020-10-15 12:20:06', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (31, 'JS 1004', 'Post-war Japanese Literature', 'Post-war Japanese Literature', 4, 2, 100, 59, 2, 2, 10, 1, 0, '2020-10-15 12:20:38', '', '0000-00-00 00:00:00');
INSERT INTO `aca_course` VALUES (32, 'JS 1005', 'Film, Animation and Performing Arts', 'Film, Animation and Performing Arts', 4, 2, 100, 59, 2, 2, 10, 1, 0, '2020-10-15 12:21:19', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for aca_course_material
-- ----------------------------
DROP TABLE IF EXISTS `aca_course_material`;
CREATE TABLE `aca_course_material`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProgramID` int(11) NOT NULL,
  `SemesterID` int(11) NOT NULL,
  `CourseID` int(11) NOT NULL,
  `BatchID` int(11) NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Type` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `FileName` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `URL` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `IsApprove` tinyint(1) NOT NULL,
  `ApproveBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ProgramID`, `SemesterID`, `CourseID`, `BatchID`, `Name`) USING BTREE,
  UNIQUE INDEX `ID`(`ID`) USING BTREE,
  INDEX `fk_aca_course_material_semester`(`SemesterID`) USING BTREE,
  INDEX `fk_aca_course_material_course`(`CourseID`) USING BTREE,
  CONSTRAINT `fk_aca_course_material_course` FOREIGN KEY (`CourseID`) REFERENCES `aca_course` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_aca_course_material_program` FOREIGN KEY (`ProgramID`) REFERENCES `aca_program` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_aca_course_material_semester` FOREIGN KEY (`SemesterID`) REFERENCES `aca_semester` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for aca_courseteacher
-- ----------------------------
DROP TABLE IF EXISTS `aca_courseteacher`;
CREATE TABLE `aca_courseteacher`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProgramID` int(11) NOT NULL,
  `SemesterID` int(11) NOT NULL,
  `CourseID` int(11) NOT NULL,
  `TeacherID` int(11) NOT NULL,
  `BatchID` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ProgramID`, `SemesterID`, `CourseID`, `TeacherID`, `BatchID`) USING BTREE,
  UNIQUE INDEX `ID`(`ID`) USING BTREE,
  INDEX `aca_courseteacher_aca_program`(`ProgramID`) USING BTREE,
  INDEX `aca_courseteacher_aca_course`(`SemesterID`) USING BTREE,
  INDEX `aca_courseteacher_hrm_employee`(`TeacherID`) USING BTREE,
  CONSTRAINT `aca_courseteacher_aca_course` FOREIGN KEY (`SemesterID`) REFERENCES `aca_course` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `aca_courseteacher_aca_program` FOREIGN KEY (`ProgramID`) REFERENCES `aca_program` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `aca_courseteacher_aca_semester` FOREIGN KEY (`SemesterID`) REFERENCES `aca_semester` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `aca_courseteacher_hrm_employee` FOREIGN KEY (`TeacherID`) REFERENCES `hrm_employee` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_courseteacher
-- ----------------------------
INSERT INTO `aca_courseteacher` VALUES (1, 1, 1, 4, 1, 0, 1, 'admin', '2020-10-18 13:38:09', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for aca_days
-- ----------------------------
DROP TABLE IF EXISTS `aca_days`;
CREATE TABLE `aca_days`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Day` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_days
-- ----------------------------
INSERT INTO `aca_days` VALUES (1, 'Saturday');
INSERT INTO `aca_days` VALUES (2, 'Sunday');
INSERT INTO `aca_days` VALUES (3, 'Monday');
INSERT INTO `aca_days` VALUES (4, 'Tuesday');
INSERT INTO `aca_days` VALUES (5, 'Wednesday');
INSERT INTO `aca_days` VALUES (6, 'Thursday');
INSERT INTO `aca_days` VALUES (7, 'Friday');

-- ----------------------------
-- Table structure for aca_department
-- ----------------------------
DROP TABLE IF EXISTS `aca_department`;
CREATE TABLE `aca_department`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `FormalName` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Type` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Head` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `Code`(`Code`) USING BTREE,
  UNIQUE INDEX `Name`(`Name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_department
-- ----------------------------
INSERT INTO `aca_department` VALUES (1, '001', 'Department of Japanese Studies', 'Department of Japanese Studies', 'Department of Japanese Studies', 'Academic', 'Abdullah-Al-Mamun, PhD', 1, 'admin', '2020-10-14 11:01:07', 'admin', '2020-10-19 10:20:22');

-- ----------------------------
-- Table structure for aca_exam
-- ----------------------------
DROP TABLE IF EXISTS `aca_exam`;
CREATE TABLE `aca_exam`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProgramID` int(11) NOT NULL,
  `SemesterID` int(11) NOT NULL,
  `CourseID` int(11) NOT NULL,
  `BatchID` int(11) NOT NULL,
  `Name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ExamTypeID` int(11) NOT NULL,
  `Marks` int(11) NOT NULL,
  `ExamDateTime` datetime(0) NOT NULL,
  `Duration` time(0) NOT NULL,
  `QuestionType` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `FileName` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ExamQuestion` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `NoQuestion` int(11) NOT NULL,
  `NoChoice` int(11) NOT NULL,
  `SecurityType` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Spelling` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `TotalStudent` int(11) NOT NULL,
  `IsApprove` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ProgramID`, `SemesterID`, `CourseID`, `BatchID`, `Name`, `ExamTypeID`) USING BTREE,
  UNIQUE INDEX `ID`(`ID`) USING BTREE,
  INDEX `aca_exam_aca_semester`(`SemesterID`) USING BTREE,
  INDEX `aca_exam_aca_course`(`CourseID`) USING BTREE,
  INDEX `aca_exam_aca_batch`(`BatchID`) USING BTREE,
  INDEX `aca_exam_aca_exam_type`(`ExamTypeID`) USING BTREE,
  CONSTRAINT `aca_exam_aca_batch` FOREIGN KEY (`BatchID`) REFERENCES `aca_batch` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `aca_exam_aca_course` FOREIGN KEY (`CourseID`) REFERENCES `aca_course` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `aca_exam_aca_exam_type` FOREIGN KEY (`ExamTypeID`) REFERENCES `aca_exam_type` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `aca_exam_aca_program` FOREIGN KEY (`ProgramID`) REFERENCES `aca_program` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `aca_exam_aca_semester` FOREIGN KEY (`SemesterID`) REFERENCES `aca_semester` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_exam
-- ----------------------------
INSERT INTO `aca_exam` VALUES (1, 1, 1, 1, 1, 'Test', 1, 40, '2020-10-28 14:02:00', '02:00:00', 'Writen Question', '', '', 0, 0, 'Medium Security Mode', 'No', 34, 1, 'admin', '2020-10-27 18:27:44', 'admin', '2020-10-27 18:27:59');

-- ----------------------------
-- Table structure for aca_exam_allow_student
-- ----------------------------
DROP TABLE IF EXISTS `aca_exam_allow_student`;
CREATE TABLE `aca_exam_allow_student`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ExamID` int(11) NOT NULL,
  `StudentID` int(11) NOT NULL,
  `ExamRoll` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Status` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  UNIQUE INDEX `ID`(`ID`) USING BTREE,
  INDEX `fk_aca_exam_allow_student_aca_exam`(`ExamID`) USING BTREE,
  INDEX `fk_aca_exam_allow_student_aca_student`(`StudentID`) USING BTREE,
  CONSTRAINT `fk_aca_exam_allow_student_aca_exam` FOREIGN KEY (`ExamID`) REFERENCES `aca_exam` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_aca_exam_allow_student_aca_student` FOREIGN KEY (`StudentID`) REFERENCES `aca_stu_basic` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_exam_allow_student
-- ----------------------------
INSERT INTO `aca_exam_allow_student` VALUES (35, 1, 1, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (36, 1, 10, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (37, 1, 34, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (38, 1, 22, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (39, 1, 5, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (40, 1, 6, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (41, 1, 31, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (42, 1, 14, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (43, 1, 32, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (44, 1, 16, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (45, 1, 4, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (46, 1, 17, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (47, 1, 21, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (48, 1, 8, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (49, 1, 27, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (50, 1, 13, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (51, 1, 2, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (52, 1, 33, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (53, 1, 9, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (54, 1, 20, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (55, 1, 26, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (56, 1, 23, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (57, 1, 11, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (58, 1, 28, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (59, 1, 15, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (60, 1, 7, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (61, 1, 25, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (62, 1, 29, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (63, 1, 18, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (64, 1, 30, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (65, 1, 12, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (66, 1, 19, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (67, 1, 24, '', 1, 'admin', '2020-10-27 18:27:59');
INSERT INTO `aca_exam_allow_student` VALUES (68, 1, 3, '', 1, 'admin', '2020-10-27 18:27:59');

-- ----------------------------
-- Table structure for aca_exam_type
-- ----------------------------
DROP TABLE IF EXISTS `aca_exam_type`;
CREATE TABLE `aca_exam_type`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Marks` int(11) NOT NULL,
  `Duration` time(0) NOT NULL,
  `Contribution` decimal(10, 6) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `Code`(`Code`) USING BTREE,
  UNIQUE INDEX `Name`(`Name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_exam_type
-- ----------------------------
INSERT INTO `aca_exam_type` VALUES (1, '001', 'Class Test', 40, '03:00:00', 20.000000, 1, 'admin', '2020-10-15 01:30:37', 'admin', '2020-10-15 01:35:00');
INSERT INTO `aca_exam_type` VALUES (2, '002', 'Mid Term', 30, '02:00:00', 20.000000, 1, 'admin', '2020-10-28 14:21:50', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for aca_grade_point
-- ----------------------------
DROP TABLE IF EXISTS `aca_grade_point`;
CREATE TABLE `aca_grade_point`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Letter` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Point` decimal(11, 6) NOT NULL,
  `NumberFrom` int(11) NOT NULL,
  `NumberTo` int(11) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `Letter`(`Letter`) USING BTREE,
  UNIQUE INDEX `Point`(`Point`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_grade_point
-- ----------------------------
INSERT INTO `aca_grade_point` VALUES (1, 'F', 0.000000, 0, 39, 'admin', '2020-10-15 00:45:11', 'admin', '2020-10-15 00:49:56');
INSERT INTO `aca_grade_point` VALUES (2, 'D', 2.000000, 40, 44, 'admin', '2020-10-15 00:50:09', 'admin', '2020-10-15 01:00:58');
INSERT INTO `aca_grade_point` VALUES (3, 'C', 2.250000, 45, 49, 'admin', '2020-10-15 00:56:29', 'admin', '2020-10-15 01:01:57');
INSERT INTO `aca_grade_point` VALUES (4, 'C+', 2.500000, 50, 54, 'admin', '2020-10-15 00:57:08', 'admin', '2020-10-15 01:02:17');
INSERT INTO `aca_grade_point` VALUES (5, 'B-', 2.750000, 55, 59, 'admin', '2020-10-15 00:57:23', 'admin', '2020-10-15 01:03:00');
INSERT INTO `aca_grade_point` VALUES (6, 'B', 3.000000, 60, 64, 'admin', '2020-10-15 00:59:27', 'admin', '2020-10-15 01:03:14');
INSERT INTO `aca_grade_point` VALUES (7, 'B+', 3.250000, 65, 69, 'admin', '2020-10-15 00:59:50', 'admin', '2020-10-15 01:03:24');
INSERT INTO `aca_grade_point` VALUES (8, 'A-', 3.500000, 70, 74, 'admin', '2020-10-15 01:00:51', '', '0000-00-00 00:00:00');
INSERT INTO `aca_grade_point` VALUES (9, 'A', 3.750000, 75, 79, 'admin', '2020-10-15 01:03:49', '', '0000-00-00 00:00:00');
INSERT INTO `aca_grade_point` VALUES (10, 'A+', 4.000000, 80, 100, 'admin', '2020-10-15 01:04:03', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for aca_hostel
-- ----------------------------
DROP TABLE IF EXISTS `aca_hostel`;
CREATE TABLE `aca_hostel`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Address` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Rooms` int(11) NOT NULL,
  `Capacity` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_hostel
-- ----------------------------
INSERT INTO `aca_hostel` VALUES (1, 'AFRH', 'A.F. Rahman Hall ', 'A.F. Rahman Hall ', 'A.F. Rahman Hall \r\nUniversity of Dhaka', 496, 2136, 1, 'admin', '2020-10-14 16:22:30', 'admin', '2020-10-14 16:23:40');

-- ----------------------------
-- Table structure for aca_program
-- ----------------------------
DROP TABLE IF EXISTS `aca_program`;
CREATE TABLE `aca_program`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `FormalName` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `SemesterNo` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Createdate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `Code`(`Code`) USING BTREE,
  UNIQUE INDEX `Name`(`Name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_program
-- ----------------------------
INSERT INTO `aca_program` VALUES (1, '001', 'B.S.S Honours in Japanese Studies', 'B.S.S Honours in Japanese Studies', 'B.S.S Honours in Japanese Studies', 8, 1, 'admin', '2020-10-14 11:04:24', '', '0000-00-00 00:00:00');
INSERT INTO `aca_program` VALUES (2, '002', 'Masters of Social Sciences, MSS (Masters)', 'Masters of Social Sciences, MSS (Masters)', 'Masters of Social Sciences, MSS (Masters)', 2, 1, 'admin', '2020-10-15 12:10:15', 'Shahin', '2020-11-04 10:19:13');
INSERT INTO `aca_program` VALUES (3, '003', 'Masters in Japanese Studies', 'Masters in Japanese Studies', 'Masters in Japanese Studies', 4, 1, 'admin', '2020-10-15 19:37:48', 'Shahin', '2020-11-04 10:19:54');

-- ----------------------------
-- Table structure for aca_room
-- ----------------------------
DROP TABLE IF EXISTS `aca_room`;
CREATE TABLE `aca_room`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Type` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Level` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ClassCapacity` int(11) NOT NULL,
  `ExamCapacity` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `Name`(`Name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_room
-- ----------------------------
INSERT INTO `aca_room` VALUES (1, 'Room No-301', 'Class Room', '3rd Floor', 45, 25, 1, 'admin', '2020-10-14 11:22:10', '', '0000-00-00 00:00:00');
INSERT INTO `aca_room` VALUES (3, 'Room No-302', 'Class Room', '1', 45, 20, 1, 'admin', '2020-10-28 14:44:43', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for aca_semester
-- ----------------------------
DROP TABLE IF EXISTS `aca_semester`;
CREATE TABLE `aca_semester`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `FormalName` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ProgramID` int(11) NOT NULL,
  `SortingNo` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `Code`(`Code`) USING BTREE,
  UNIQUE INDEX `Name`(`Name`) USING BTREE,
  INDEX `fk_aca_semester_aca_program`(`ProgramID`) USING BTREE,
  CONSTRAINT `fk_aca_semester_aca_program` FOREIGN KEY (`ProgramID`) REFERENCES `aca_program` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_semester
-- ----------------------------
INSERT INTO `aca_semester` VALUES (1, 'SEM-001', '1st Year 1st Semester', '1st Year 1st Semester', '1st Year 1st Semester', 1, 1, 1, 'admin', '2020-10-14 11:18:17', 'admin', '2020-10-15 19:40:17');
INSERT INTO `aca_semester` VALUES (2, 'SEM 002', '1st Year 2nd Semester', '1st Year 2nd Semester', '', 1, 2, 1, 'admin', '2020-10-15 11:46:08', '', '0000-00-00 00:00:00');
INSERT INTO `aca_semester` VALUES (3, 'SEM 003', '2nd Year 3rd Semester', '2nd Year 3rd Semester', '', 1, 3, 1, 'admin', '2020-10-15 11:47:42', '', '0000-00-00 00:00:00');
INSERT INTO `aca_semester` VALUES (4, 'SEM 004', '2nd Year 4th Semester', '2nd Year 4th Semester', '', 1, 4, 1, 'admin', '2020-10-15 11:48:07', '', '0000-00-00 00:00:00');
INSERT INTO `aca_semester` VALUES (5, 'SEM 005', '3rd Year 5th Semester', '3rd Year 5th Semester', '', 1, 5, 1, 'admin', '2020-10-15 11:48:31', '', '0000-00-00 00:00:00');
INSERT INTO `aca_semester` VALUES (6, 'SEM 006', '3rd Year 6th Semester', '3rd Year 6th Semester', '', 1, 6, 1, 'admin', '2020-10-15 11:48:57', '', '0000-00-00 00:00:00');
INSERT INTO `aca_semester` VALUES (7, 'SEM 007', '4th Year 7th Semester', '4th Year 7th Semester', '', 1, 7, 1, 'admin', '2020-10-15 11:49:21', '', '0000-00-00 00:00:00');
INSERT INTO `aca_semester` VALUES (8, 'SEM 008', '4th Year 8th Semester', '4th Year 8th Semester', '', 1, 8, 1, 'admin', '2020-10-15 11:49:47', '', '0000-00-00 00:00:00');
INSERT INTO `aca_semester` VALUES (9, 'SEM 01', 'Masters 1st Semester', 'Masters 1st Semester', 'Masters 1st Semester', 2, 1, 1, 'admin', '2020-10-15 12:11:18', '', '0000-00-00 00:00:00');
INSERT INTO `aca_semester` VALUES (10, 'SEM 02', 'Masters 2nd Semester', 'Masters 2nd Semester', 'Masters 2nd Semester', 2, 2, 1, 'admin', '2020-10-15 12:11:49', '', '0000-00-00 00:00:00');
INSERT INTO `aca_semester` VALUES (11, 'SEM-MJS-001', 'MJS-1st Semester Final', 'MJS-1st Semester Final', 'MJS-1st Semester Final', 3, 1, 1, 'admin', '2020-10-28 14:29:42', 'admin', '2020-10-28 14:30:55');
INSERT INTO `aca_semester` VALUES (13, 'SEM-MJS-002', 'MJS-2nd Semester Final', 'MJS-2nd Semester Final', 'MJS-2nd Semester Final', 3, 2, 1, 'admin', '2020-10-28 14:33:00', '', '0000-00-00 00:00:00');
INSERT INTO `aca_semester` VALUES (14, 'SEM-MJS-003', 'MJS-3rd Semester Final', 'MJS-3rd Semester Final', 'MJS-3rd Semester Final', 3, 3, 1, 'admin', '2020-10-28 14:33:46', '', '0000-00-00 00:00:00');
INSERT INTO `aca_semester` VALUES (15, 'SEM-MJS-004', 'MJS-4th Semester Final', 'MJS-4th Semester Final', 'MJS-4th Semester Final', 3, 4, 1, 'admin', '2020-10-28 14:35:05', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for aca_session
-- ----------------------------
DROP TABLE IF EXISTS `aca_session`;
CREATE TABLE `aca_session`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `Code`(`Code`) USING BTREE,
  UNIQUE INDEX `Name`(`Name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_session
-- ----------------------------
INSERT INTO `aca_session` VALUES (1, '002', '2018-2019', '2018-2019', '2018-01-01', '2021-12-31', 1, 'admin', '2020-10-14 11:08:44', 'admin', '2020-11-01 21:12:08');
INSERT INTO `aca_session` VALUES (2, '003', '2019-2020', '2019-2020', '2019-01-01', '2022-12-31', 1, 'admin', '2020-10-14 16:00:46', 'admin', '2020-11-01 21:11:51');
INSERT INTO `aca_session` VALUES (3, '004', '2020-2021', '2020-2021', '2020-01-01', '2023-12-31', 1, '', '2020-10-14 16:00:46', 'admin', '2020-11-01 21:11:41');
INSERT INTO `aca_session` VALUES (4, '005', '2021-2022', '2021-2022', '2021-01-01', '2024-12-31', 1, 'admin', '2020-10-19 09:38:23', 'admin', '2020-11-01 21:11:31');
INSERT INTO `aca_session` VALUES (5, '001', '2017-2018', '2017-2018', '2017-01-01', '2020-12-31', 1, 'admin', '2020-10-21 12:23:56', 'admin', '2020-11-01 21:13:03');

-- ----------------------------
-- Table structure for aca_stu_basic
-- ----------------------------
DROP TABLE IF EXISTS `aca_stu_basic`;
CREATE TABLE `aca_stu_basic`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ApplicationNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `RegistrationNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ClassRoll` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ExamRoll` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Email` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ProximityCardID` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Image` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `DepartmentID` int(11) NOT NULL,
  `ProgramID` int(11) NOT NULL,
  `SessionID` int(11) NOT NULL,
  `BatchID` int(11) NOT NULL,
  `District` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Campus` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CostHead` bigint(20) NOT NULL,
  `AdmissionDate` date NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` date NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` date NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `ClassRoll`(`ClassRoll`) USING BTREE,
  UNIQUE INDEX `RegistrationNo`(`RegistrationNo`) USING BTREE,
  INDEX `fk_aca_stu_basic_aca_department`(`DepartmentID`) USING BTREE,
  INDEX `fk_aca_stu_basic_aca_program`(`ProgramID`) USING BTREE,
  INDEX `fk_aca_stu_basic_aca_session`(`SessionID`) USING BTREE,
  INDEX `fk_aca_stu_basic_aca_batch`(`BatchID`) USING BTREE,
  CONSTRAINT `fk_aca_stu_basic_aca_batch` FOREIGN KEY (`BatchID`) REFERENCES `aca_batch` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_aca_stu_basic_aca_department` FOREIGN KEY (`DepartmentID`) REFERENCES `aca_department` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_aca_stu_basic_aca_program` FOREIGN KEY (`ProgramID`) REFERENCES `aca_program` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_aca_stu_basic_aca_session` FOREIGN KEY (`SessionID`) REFERENCES `aca_session` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 178 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_stu_basic
-- ----------------------------
INSERT INTO `aca_stu_basic` VALUES (1, 'S. M. Rabby Raj', '', '2017-219-026', 'KJ-100-052', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-18', 'Shahin', '2020-11-01');
INSERT INTO `aca_stu_basic` VALUES (2, 'A.H.M SAKKHAR RAHMAN', '', '2017-419-006', 'MM-100-039', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', 'admin', '2020-10-21');
INSERT INTO `aca_stu_basic` VALUES (3, 'MD. SHAKIBUZZAMAN  CHOWDHURY', '', '2017-919-029', 'ZH-100-055', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', 'admin', '2020-11-01');
INSERT INTO `aca_stu_basic` VALUES (4, 'MUBIN KHAN AFRIDI', '', '2017-718-879', 'SM-100-023', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', 'Shahin', '2020-11-01');
INSERT INTO `aca_stu_basic` VALUES (5, 'ZAKIA RIFA NUSAIBA', '', '2017-415-848', 'RH-100-011', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', 'Shahin', '2020-11-02');
INSERT INTO `aca_stu_basic` VALUES (6, 'KHANDOKAR TAZINA ISLAM', '', '2017-418-872', 'FM-100-016', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', 'admin', '2020-10-21');
INSERT INTO `aca_stu_basic` VALUES (7, 'LUBABA BASHARAT', '', '2017-318-873', 'SN-100-017', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', 'admin', '2020-10-21');
INSERT INTO `aca_stu_basic` VALUES (8, 'SUMAIYA IMTIAZ', '', '2017-318-891', 'KM-100-035', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', 'admin', '2020-10-21');
INSERT INTO `aca_stu_basic` VALUES (9, 'FARIDA YEASMIN BANNA', '', '207-817-', 'RH-100-002', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', 'admin', '2020-10-21');
INSERT INTO `aca_stu_basic` VALUES (10, 'MD. NAIMUR RAHMAN PIASH', '', '2017-717-465', 'BA-100-003', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', 'admin', '2020-10-21');
INSERT INTO `aca_stu_basic` VALUES (11, 'MD. EMON MIA', '', '2017-617-466', 'SM-100-004', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', 'admin', '2020-10-21');
INSERT INTO `aca_stu_basic` VALUES (12, 'MD. SAIF ULLAH', '', '2017-517-467', 'ZH-100-005', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (13, 'MD. MINARUL ISLAM', '', '2017-317-469', 'MM-100-007', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (14, 'ABDUL MANNAN', '', '2017-117-470', 'FR-100-008', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (15, 'MALIHA BASHER KEYA', '', '2017-017-471', 'SN-100-009', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (16, 'MD. SAYFUL ISLAM', '', '2017-918-868', 'SM-100-012', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', 'Shahin', '2020-11-01');
INSERT INTO `aca_stu_basic` VALUES (17, 'SHAMAMA AKTER MIM', '', '2017-518-871', 'KM-100-015', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (18, 'MD. SHIRAJUL ISLAM', '', '2017-918-877', 'SS-100-021', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (19, 'AMIT HASAN', '', '2017-818-878', 'ZR-100-022', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', 'Shahin', '2020-11-02');
INSERT INTO `aca_stu_basic` VALUES (20, 'MAHMUDA NAZNIN', '', '2017-518-880', 'RH-100-024', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (21, 'ANANNA KABIR JEHAN', '', '2017-318-882', 'KM-100-026', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (22, 'RAKIBUL HASSAN', '', '2017-218-883', 'BB-100-027', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (23, 'NASRIN SULTANA', '', '2017-118-884', 'SK-100-028', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (24, 'MD. SAZZAD HOSSAIN', '', '2017-018-885', 'ZR-100-029', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', 'Shahin', '2020-11-02');
INSERT INTO `aca_stu_basic` VALUES (25, 'TONIMA KHATUN', '', '2017-418-890', 'SN-100-034', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (26, 'RABEYA SULTANA APON', '', '2017-519-005', 'RH-100-038', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (27, 'FARINA HAQUE', '', '2017-119-009', 'KM-100-042', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (28, 'ASIF KAMAL SOURAV', '', '2017-919-010', 'SM-100-043', '', 'tijopramanik@gmail.com', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (29, 'KAZI HUMAYRA RASHID', '', '2017-819-011', 'SN-100-044', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (30, 'ABID AHMAD', '', '2017-719-012', 'SS-100-0454', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (31, 'SHANU AKTER ETI', '', '2017-519-014', 'FM-100-047', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (32, 'S.M. AFIF IBNA YEAR', '', '2017-419-024', 'FR-100-050', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (33, 'SHAIKH RASHID BIN ISLAM', '', '2017-319-025', 'MM-100-051', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (34, 'MD. MEHEDI HASAN NAHID', '', '2017-019-028', 'BA-100-054', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'admin', '2020-10-21', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (35, 'Lutfur Rashid Arafat', '', '2017-119-027', 'ZR-100-053', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-01', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (36, 'Sazzadur Rahman', '', '2017-619-022', 'SS-100-048', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-01', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (37, 'Mohammad Fareeb Uzzaman', '', '2017-717-681', 'MM-100-036', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-01', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (38, 'Tasriful Kabir', '', '2017-118-875', 'ZH-100-019', '', '', '', '', 1, 1, 5, 1, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-02');
INSERT INTO `aca_stu_basic` VALUES (39, 'ABDUL AWAL MINTU', '', '2018-722-585', 'AA-100-010', '', '', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (40, 'FERDOUS SIDDIQUE SAYMON', '', '2018-724-268', 'AA-100-37', '', '', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (41, 'MD. MAHBUB HASAN', '', '2018-624-278', 'AA-100-047', '', '', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (42, 'MD. HADI ISLAM', '', '2018-724-277', 'BE-100-046', '', 'a.hadiislam01@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-02');
INSERT INTO `aca_stu_basic` VALUES (43, 'MOHAMMAD RAKIBUL AL HASAN NUR', '', '2018-124-291', 'BE-100-060', '', '', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (44, 'AHMAD REZA MINHAJ', '', '2018-722-576', 'BE-100-001', '', 'ahamadrezaminhaj2001@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (45, 'MD. ABDUR RAHIM SAGOR', '', '2018-024-283', 'BE-100-052', '', 'abdurrahimsagor102@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (46, 'ARMAN ALAM', '', '2018-624-269', 'SS-100-038', '', 'mdarmank966@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (47, 'FATIN HASNAT RAHMAN SETU', '', '2018-224-281', 'SS-100-050', '', 'fatinhasnatdjs@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (48, 'MD. ABIDUR RAHMAN', '', '2018-122-581', 'SS-100-006', '', 'muhammodabiddu@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (49, 'ZAHID HASAN', '', '2018-321-733', 'SS-100-0029', '', 'Zahidhrid5@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (50, 'MD. ASHIKUR RAHMAN', '', '2018-924-301', 'SS-100-070', '', '', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (51, 'PAVEL SARKAR', '', '2018-824-267', 'ZR-100-036', '', 'pavelsk883@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (52, 'MD. EFRAT JAHAN BHUIYAN SHAFIN', '', '2018-624-287', 'ZR-100-056', '', 'm.shafin004@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (53, 'MD. ZAHIDUL ISLAM HRIDOY', '', '2018-624-296', 'ZR-100-065', '', 'Zahidhrid5@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (54, 'TILAK SAHA', '', '2018-024-292', 'JH-100-061', '', 'ridtilak20@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (55, 'ANTON CHAKMA', '', '2018-323-948', 'JH-100-018', '', 'antonchangma@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-02');
INSERT INTO `aca_stu_basic` VALUES (56, 'SHUVRAM ROY', '', '2018-824-294', 'JH-100-063', '', 'roy.shuvram@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (58, 'YIASIN ARAFAT ALIF', '', '2018-324-262', 'KJ-100-031', '', '', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (59, 'MAHDI NASIF IQBAL MAHI', '', '2018-024-265', 'KJ-100-034', '', 'mahinasif06@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (60, 'MD. KHALID HASAN SHISHIR', '', '2018-224-272', 'KJ-100-041', '', 'khalidhasanshishir@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (61, 'MD. JAWAD SAIF', '', '2018-824-302', 'KJ-100-071', '', '', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (62, 'FERDOUS SALEHIN', '', '2018-824-285', 'KJ-100-054', '', '', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (63, 'SABRINA ZAHIR', '', '2018-624-188', 'KM-100-093', '', 'sabrinazahirmuna17@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (64, 'MEHZABIN BINTE MESBAH', '', '2018-323-993', 'KM-100-076', '', 'mehzabinmeem999@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (65, 'AWSAFUR RAHMAN', '', '2018-127-397', 'MM-100-079', '', 'awsafurrahman1998@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (66, 'MONSUR AHMED RAFI', '', '2018-227-396', 'MM-100-078', '', 'rafi.monsur7000@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (67, 'ABDULAH MAHMMAD AKRAM', '', '2018-922-583', 'MM-100-008', '', 'abdullahmohammadakram25@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (68, 'MD. SHAJAHAN HOSSAIN', '', '2018-021-709', 'MM-100-025', '', 'mdshajahanshan@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (69, 'NOWROZ AMIN BORSHON', '', '2018-924-275', 'MM-100-044', '', 'nawrozborshon17@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (70, 'FIRUZ HUMAYRA METHE', '', '2018-519-023', 'RH-100-049', '', 'humairaahmed532@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (72, 'NISHAT TASNIM MOMO', '', '2018-224-290', 'RH-100-059', '', 'nishatmomodu@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (73, 'A. S. M. BHOKHARE', '', '2018-921-728', 'SM-100-028', '', '', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (74, 'MD. ABDUL HANNAN', '', '2018-922-592', 'SM-100-017', '', '', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (76, 'ABDULLAH AL MAMUN', '', '2018-022-591', 'ZH-100-016', '', 'abdullahalmamun3490@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (77, 'MD. RAHAT', '', '2018-621-776', 'ZH-100-030', '', 'rahat.tanjir75@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (78, 'MD. MANIRUZZAMAN', '', '2018-124-264', 'ZH-100-033', '', 'monirvabuk@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (79, 'TANZID AHAMMAD', '', '2018-124-273', 'ZH-100-042', '', '', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (80, 'MEHEDI HASAN', '', '2018-924-266', 'BB-100-035', '', 'mhmehedi505@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (81, 'RASEL RAHAMAN', '', '2018-324-271', 'BB-100-040', '', 'raselrahaman0804@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (82, 'TANVIR HASAN CHOWDHURY', '', '2018-124-282', 'BB-100-051', '', 'tanvirfuad93@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (83, 'TASKHINA JANNAT JEBIN', '', '2018-921-719', 'SN-100-027', '', 'taskhina123@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (84, 'ISRAT JAHAN SRABONI', '', '2018-024-274', 'SN-100-043', '', 'israboni927@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (85, 'MST. TASNIA YASMIN', '', '2018-324-280', 'SN-100-049', '', 'tasniayasmin16@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (86, 'FERDOUS ARA TISHA', '', '2018-727-300', 'SN-100-077', '', 'ferdousaratisha@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (87, 'MST. TONIMA AFRIN', '', '2018-724-295', 'SN-100-064', '', '', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (88, 'SHAMMI AKTER PRIYANKA', '', '2018-623-981', 'FM-100-073', '', 'shammyakterpriyanka@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (89, 'MST. BEAUTY KHATUN', '', '2018-822-584', 'FM-100-009', '', '', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (91, 'HENA KHATUN', '', '2018-424-270', 'FM-100-039', '', '', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (92, 'SATRIA ZAMAN', '', '2018-424-289', 'FM-100-058', '', 'zamansatria6@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (93, 'HASNA JAHAN', '', '2018-424-298', 'SN-100-067', '', 'jahanhasna00@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (94, 'TANZILA JAHAN', '', '2018-621-767', 'SK-100-026', '', 'tanzilajahan902@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (95, 'FAHIMA ISLAM TAZIN', '', '2018-824-276', 'SK-100-045', '', 'islamtazin6@gmail.com', '', '', 1, 1, 1, 2, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (98, 'SUMONA AKTHAR SUMA', '', '2018-515-692', 'RH-100-015', '', 'sumonarahman371@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (99, 'NAFISA TASNIM JUI', '', '2019-215-703', 'RH-100-026', '', 'nafisatassniim@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (100, 'TASMIA MAHMUDA', '', '2019-515-719', 'RH-100-042', '', '', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (101, 'TASNI JUAIRIA BRINTY', '', '2019-919-036', 'RH-100-50', '', '', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (102, 'RIFAH NANJIBA MAMUN', '', '2019-219-042', 'RH-100-056', '', '', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (103, 'TANZIM RAHMAN TASHIN', '', '2019-119-043', 'RH-100-057', '', 'tashintanzim112@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (104, 'SOURAV PRAMANIK', '', '2019-315-694', 'JH-100-017', '', 'tijopramanik@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (105, 'PRONOY DEVNATH', '', '2019-015-697', 'JH-100-020', '', 'Pronaydevnath163@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (106, 'SAMARPON BARUA', '', '2019-515-700', 'JH-100-023', '', 'samarpon12@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (108, 'MD. FAHIM AL FOYSAL', '', '2019-915-715', 'BB-100-038', '', 'fahimalfaysal27852@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (109, 'MD. JASIM ALI', '', '2019-214-281', 'BB-100-046', '', 'md.jasim203571@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (110, 'SADIYA AFRIN ZITU', '', '2019-113-689', 'SN-100-005', '', 'sadiyazitu22@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (111, 'MARIA FARJANA OISHEE', '', '2019-415-693', 'SN-100-016', '', 'mariafarzana444@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (112, 'HABIBA AKTER TISA', '', '2019-215-695', 'SN-100-018', '', 'habibaaktertisa33@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (114, 'DEVO PRIA DAS DISHA', '', '2019-018-720', 'SN-100-048', '', 'devopriyadasdisha@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (115, 'MAHI MUSHARRAT RAHMAN', '', '2019-319-041', 'SN-100-055', '', 'mahirahman2000@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (116, 'TABASSUM AKTER NISHE', '', '2019-619-048', 'SN-100-062', '', 'tabassumnishe5830@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (117, 'SOYODA MORSHEDA ISLAM', '', '2019-513-694', 'SK-100-010', '', 'Soyodamorsheda@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (118, 'SANJANA NOURIN KHAN SHOYLE', '', '2019-019-044', 'SK-100-058', '', 'sanjananourin1810@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (119, 'MD. SHADMAN SAKIB', '', '2019-315-711', 'ZH-100-034', '', 'daddysakib@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (120, 'NAFIS FUAD', '', '2019-315-720', 'ZH-100-043', '', 'nafis_fuad@outlook.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (121, 'MD.TOWHIDUL ISLAM', '', '2019-019-035', 'ZH-100-049', '', 'towhidul.islam.1999@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-02', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (122, 'MIRAZ UDDIN SHIHAB', '', '2019-115-704', 'FR-100-027', '', 'mirazuddinshihab@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (123, 'MD. RABIUL ISLAM HRIDOY', '', '2019-819-037', 'FR-100-051', '', 'hridoyrislam20@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (124, 'MD. MUSA ISLAM', '', '2019-319-410', 'FR-100-063', '', 'smusa50123@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (126, 'AHMED ZABIR', '', '2019-715-690', 'BE-100-013', '', 'ahmedzabir932001@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (127, 'MD. NEWAS SHARIF', '', '2019-615-718', 'BE-100-041', '', '', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (128, 'MARWAN MOSTOFA KHADEM', '', '2019-919-045', 'BE-100-059', '', 'marwankhadem9@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (129, 'MAHMUDUL HASAN SHAMIM', '', '2019-913-690', 'ZR-100-006', '', 'shamim31916@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (132, 'MOHAMMAD ALI HOSSAIN ARKO', '', '2019-615-709', 'ZR-100-032', '', 'arkohossain30@gmai.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (133, 'MD. SOJON', '', '2019-213-688', 'SS-100-004', '', 'mdsojonsorkar5640@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (135, 'MAHBUBUL NEWAS FARSIM', '', '2019-719-038', 'SS-100-052', '', 'newazfarsim@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (136, 'SADIKEEN KAZI', '', '2019-813-691', 'KM-100-007', '', 'sadikeenkazi@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (137, 'FATEMA ISLAM', '', '2019-615-691', 'KM-100-014', '', '', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (139, 'MARJUBAH AFRAH', '', '2019-619-039', 'KM-100-053', '', 'marjubahafrah09344@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (140, 'JANNAUTL RAIAN JERIN', '', '2019-419-040', 'KM-100-054', '', 'jannatuljerin5578@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (141, 'NOSHIN TUSNIM ARPA', '', '2019-819-046', 'KM-100-060', '', 'noshintusnimarpa@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (143, 'MD. RAHAT SIKDER', '', '2019-215-712', 'MM-100-035', '', 'rahat.du28@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (145, 'NAIMUR RAHMAN', '', '2019-613-693', 'KJ-100-009', '', '', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (146, 'MD. FARHAN BIN HAMID AL MAIDI', '', '2019-015-705', 'KJ-100-028', '', '', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (147, 'MD. HASANUR RAHMAN HASAN', '', '2019-313-687', 'SM-100-003', '', '', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (148, 'MD. ASRAFUL ISLAM', '', '2019-314-262', 'SM-100-045', '', 'asrafulalam5247@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (149, 'RAJAUL KARIM', '', '2019-415-341', 'SM-100-047', '', 'rezaulrk892@gmai.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', 'Shahin', '2020-11-03');
INSERT INTO `aca_stu_basic` VALUES (150, 'SAMIA MAHMUD', '', '2019-713-692', 'FM-100-008', '', 'Islamsamia890@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (151, 'SYADA MIEL AHMED', '', '2019-115-63-696', 'FM-100-019', '', '', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (160, 'AZHARUL ISLAM', '', '2019-100-685', 'BA-100-001', '', 'mdazharulislam564@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (161, 'ABU NASER DISSIK', '', '2019-815-699', 'ZH-100-022', '', 'naserabu193@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (163, 'SK. RAKIBUL ISLAM', '', '2019-915-706', 'ZH-100-029', '', 'rakibulislamsk27@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (164, 'MD. SHIFAT AL SHAFI', '', '2019-915-698', 'SS-100-0021', '', 'shifatalshafi@Gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (165, 'SAADIYA TASNEEM PRAPTY', '', '2019-115-713', 'KM-100-0036', '', 'saadiyatasneem007@gmai.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (166, 'MD. MUNTAKIM HOSSAIN', '', '2019-315-702', 'MM-100-0025', '', '', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (167, 'SITHI ROY', '', '2019-413-686', 'RH-100-02', '', 'sithiroy2019@gmail.com', '', '', 1, 1, 2, 3, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-03', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (169, 'MOHAMMAD SAIFUL ISLAM', '', 'H-1644', 'ZH-001', '', '', '', '', 1, 3, 1, 4, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-04', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (170, 'MEHRAZ MORSHED', '', 'H-1804', 'ZH-009', '', '', '', '', 1, 3, 1, 4, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-04', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (171, 'SHAMSUL ALAM KHONDOKER', '', 'H-1805', 'ZH-013', '', '', '', '', 1, 3, 1, 4, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-04', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (172, 'IMTIAZ MAHMUD', '', 'H-1806', 'ZH-015', '', '', '', '', 1, 3, 1, 4, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-04', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (173, 'AFROZA AKTER', '', 'H-797', 'RH-016', '', '', '', '', 1, 3, 1, 4, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-04', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (174, 'MD. SANA ULLAH NOVEL', '', 'H-1807', 'ZH-017', '', '', '', '', 1, 3, 1, 4, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-04', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (175, 'MD. SHAFAYET HOSSAIN', '', 'H-1822', 'ZH-019', '', '', '', '', 1, 3, 1, 4, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-04', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (176, 'MD. MOZAMMAL HOSSAIN', '', 'H-1808', 'ZH-021', '', '', '', '', 1, 3, 1, 4, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-04', '', '0000-00-00');
INSERT INTO `aca_stu_basic` VALUES (177, 'MD. ZAFAR ALAM BHUIYAN', '', 'H-1809', 'ZH-022', '', '', '', '', 1, 3, 2, 4, '', '', 0, '0000-00-00', 1, 'Shahin', '2020-11-04', 'Shahin', '2020-11-04');

-- ----------------------------
-- Table structure for aca_time_slot
-- ----------------------------
DROP TABLE IF EXISTS `aca_time_slot`;
CREATE TABLE `aca_time_slot`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `StartTime` time(0) NOT NULL,
  `EndTime` time(0) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE INDEX `Name`(`Name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aca_time_slot
-- ----------------------------
INSERT INTO `aca_time_slot` VALUES (1, '10:00 AM - 10:40 AM', '10:00:00', '10:40:00', 1, 'admin', '2020-10-14 11:19:48', '', '0000-00-00 00:00:00');
INSERT INTO `aca_time_slot` VALUES (2, '6:00 PM - 8:00 PM', '18:00:00', '20:00:00', 1, 'admin', '2020-10-15 20:04:22', 'admin', '2020-10-21 22:50:49');
INSERT INTO `aca_time_slot` VALUES (3, '5:00 PM - 7:00 PM', '17:00:00', '19:00:00', 1, 'admin', '2020-10-15 20:04:59', '', '0000-00-00 00:00:00');
INSERT INTO `aca_time_slot` VALUES (4, '10:40 AM - 11:20 AM', '10:40:00', '11:20:00', 1, 'admin', '2020-10-28 14:41:57', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for hrm_designation
-- ----------------------------
DROP TABLE IF EXISTS `hrm_designation`;
CREATE TABLE `hrm_designation`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `OfficialTitle` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `SortingNo` int(11) NOT NULL,
  `IsActive` tinyint(4) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`Name`) USING BTREE,
  UNIQUE INDEX `ID`(`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hrm_designation
-- ----------------------------
INSERT INTO `hrm_designation` VALUES (5, 'Assistant Professor ', 'Assistant Professor', 'Assistant Professor ', 4, 1, 'Shahin', '2020-11-03 14:06:07', 'Shahin', '2020-11-03 14:27:07');
INSERT INTO `hrm_designation` VALUES (4, 'Associate Professor', 'Associate Professor', 'Associate Professor', 3, 1, 'Shahin', '2020-11-03 14:05:24', 'Shahin', '2020-11-03 14:26:46');
INSERT INTO `hrm_designation` VALUES (7, 'Chairman ', 'Chairman', 'Chairman', 1, 1, 'Shahin', '2020-11-03 14:09:53', '', '0000-00-00 00:00:00');
INSERT INTO `hrm_designation` VALUES (1, 'Lecturer', 'Lecturer', 'Lecturer', 5, 1, 'admin', '2020-10-14 10:53:20', 'Shahin', '2020-11-03 14:27:18');
INSERT INTO `hrm_designation` VALUES (8, 'OFFICE SOHAYOK', 'OFFICE SOHAYOK', 'OFFICE SOHAYOK', 8, 1, 'Shahin', '2020-11-03 14:28:27', '', '0000-00-00 00:00:00');
INSERT INTO `hrm_designation` VALUES (2, 'Professor', 'Professor', 'Professor', 2, 1, 'admin', '2020-10-18 10:17:49', 'Shahin', '2020-11-03 14:26:34');
INSERT INTO `hrm_designation` VALUES (6, 'Senior Administrative Officer ', 'Senior Administrative Officer', 'Senior Administrative Officer ', 6, 1, 'Shahin', '2020-11-03 14:08:08', 'Shahin', '2020-11-03 14:27:31');
INSERT INTO `hrm_designation` VALUES (3, 'Sr. Seminer Assistant', 'Sr. Seminer Assistant', 'Sr. Seminer Assistant', 7, 1, 'admin', '2020-10-28 14:54:50', 'Shahin', '2020-11-03 14:27:42');

-- ----------------------------
-- Table structure for hrm_employee
-- ----------------------------
DROP TABLE IF EXISTS `hrm_employee`;
CREATE TABLE `hrm_employee`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Image` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `EmployeeNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ShortName` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `DesignationID` int(11) NOT NULL,
  `ProximityCardID` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Email` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `DepartmentID` int(11) NOT NULL,
  `Campus` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`EmployeeNo`) USING BTREE,
  UNIQUE INDEX `ID`(`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hrm_employee
-- ----------------------------
INSERT INTO `hrm_employee` VALUES (2, '', '01', 'D', 'D', 6, '', 'sayed.dsj@du.ac.bd', 1, 'du', 1, 'admin', '2020-10-28 14:56:58', 'Shahin', '2020-11-03 14:34:06');
INSERT INTO `hrm_employee` VALUES (3, '', '1982087001', 'ABUL BARKAT, PhD', ' BARKAT ', 2, '', 'barkatabul71@gmail.com', 1, 'Dhaka University', 1, 'Shahin', '2020-11-03 13:53:00', 'Shahin', '2020-11-03 14:31:11');
INSERT INTO `hrm_employee` VALUES (4, '', '2013127002', 'MD. JAHANGIR ALAM, PhD ', 'Jahangir ', 5, '', 'rony.cdcs@gmail.com', 1, 'Dhaka University', 1, 'Shahin', '2020-11-03 14:14:43', 'Shahin', '2020-11-03 14:29:11');
INSERT INTO `hrm_employee` VALUES (1, '', '201328001', 'ABDULLAH AL MAMUN, PhD', 'MAMUN ', 7, '', 'mamun.djs@du.ac.bd', 1, 'Dhaka University', 1, 'admin', '2020-10-14 10:55:30', 'Shahin', '2020-11-03 14:30:43');
INSERT INTO `hrm_employee` VALUES (5, '', '2015026002', 'DILRUBA SHARMIN, PhD ', 'SHARMIN', 5, '', 'dsharmin.jsc@du.ac.bd', 1, 'Dhaka University', 1, 'Shahin', '2020-11-03 14:18:10', 'Shahin', '2020-11-03 14:19:21');
INSERT INTO `hrm_employee` VALUES (6, '', '2016021009', 'LOPAMUDRA MALEK, PhD ', 'LOPAMUDRA', 5, '', 'lopamudra.jsc@du.ac.bd', 1, 'Dhaka University', 1, 'Shahin', '2020-11-03 14:20:55', '', '0000-00-00 00:00:00');
INSERT INTO `hrm_employee` VALUES (7, '', '2016098010', 'NASHIA ZAMAN ', 'NASHIA ', 5, '', 'nashiazaman@du.ac.bd', 1, 'Dhaka University', 1, 'Shahin', '2020-11-03 14:22:16', '', '0000-00-00 00:00:00');
INSERT INTO `hrm_employee` VALUES (9, '', '2018014011', 'MD. SAIFULLAH AKON', 'AKON', 1, '', 'saifullah.djs@du.ac.bd', 1, 'Dhaka University', 1, 'Shahin', '2020-11-03 14:25:57', '', '0000-00-00 00:00:00');
INSERT INTO `hrm_employee` VALUES (8, '', '2018017026', 'SHIBLEE NOMAN ', 'NOMAN ', 1, '', 'shibleenoman.djs@du.ac.bd', 1, 'Dhaka University', 1, 'Shahin', '2020-11-03 14:23:47', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for sec_accesslog
-- ----------------------------
DROP TABLE IF EXISTS `sec_accesslog`;
CREATE TABLE `sec_accesslog`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ActionPage` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ActionDone` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `Remarks` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `IpAddress` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 323 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sec_accesslog
-- ----------------------------
INSERT INTO `sec_accesslog` VALUES (1, 'Session Setup', 'Session Update', 'ID-2 Code-002 Name-2019-20 Description-2019-20 StartDate-2019-01-01 EndDate-2021-12-31', 'admin', '2020-10-19 09:36:41', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (2, 'Session Setup', 'Session Entry', 'Code-002 Name-2020-21 Description-2020-21 Start Date-2020-01-01 End Date-2022-12-31', 'admin', '2020-10-19 09:37:18', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (3, 'Session Setup', 'Session Update', 'ID-1 Code-001 Name-2018-19 Description-2018-19 StartDate-2018-01-01 EndDate-2021-12-31', 'admin', '2020-10-19 09:37:41', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (4, 'Session Setup', 'Session Update', 'ID-2 Code-002 Name-2019-20 Description-2019-20 StartDate-2019-01-01 EndDate-2022-12-31', 'admin', '2020-10-19 09:37:49', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (5, 'Session Setup', 'Session Entry', 'Code-003 Name-2021-22 Description-2021-22 Start Date-2021-01-01 End Date-2023-12-31', 'admin', '2020-10-19 09:38:23', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (6, 'Batch Setup', 'Batch Update', 'ID-3 Code-BATCH-002 Name-B.S.S 2nd Batch Description-B.S.S 2nd Batch StartDate-2019-01-01 EndDate-2022-12-31 ProgramID-1 SessionID-2', 'admin', '2020-10-19 09:55:44', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (7, 'Session Setup', 'Session Update', 'ID-4 Code-003 Name-2020-21 Description-2020-21 StartDate-2020-01-01 EndDate-2022-12-31', 'admin', '2020-10-19 09:56:16', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (8, 'Session Setup', 'Session Update', 'ID-4 Code-003 Name-2020-21 Description-2020-21 StartDate-2020-01-01 EndDate-2023-12-31', 'admin', '2020-10-19 09:56:31', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (9, 'Batch Setup', 'Batch Update', 'ID-4 Code-BATCH-003 Name-B.S.S 3rd Batch Description-B.S.S 3rd Batch StartDate-2020-01-01 EndDate-2023-12-31 ProgramID-1 SessionID-4', 'admin', '2020-10-19 09:56:42', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (10, 'Session Setup', 'Session Update', 'ID-4 Code-004 Name-2021-22 Description-2021-22 StartDate-2021-01-01 EndDate-2024-12-31', 'admin', '2020-10-19 10:00:12', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (11, 'Session Setup', 'Session Update', 'ID-3 Code-003 Name-2020-21 Description-2020-21 StartDate-2020-01-01 EndDate-2022-12-31', 'admin', '2020-10-19 10:00:45', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (12, 'Session Setup', 'Session Update', 'ID-3 Code-003 Name-2020-21 Description-2020-21 StartDate-2020-01-01 EndDate-2023-12-31', 'admin', '2020-10-19 10:01:00', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (13, 'Batch Setup', 'Batch Update', 'ID-3 Code-BATCH-003 Name-B.S.S 3rd Batch Description-B.S.S 3rd Batch StartDate-2020-01-01 EndDate-2023-12-31 ProgramID-1 SessionID-2', 'admin', '2020-10-19 10:06:25', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (14, 'Batch Setup', 'Batch Update', 'ID-3 Code-BATCH-003 Name-B.S.S 3rd Batch Description-B.S.S 3rd Batch StartDate-2020-01-01 EndDate-2023-12-31 ProgramID-1 SessionID-3', 'admin', '2020-10-19 10:06:39', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (15, 'Batch Setup', 'Batch Update', 'ID-4 Code-BATCH-004 Name-B.S.S 4th Batch Description-B.S.S 4th Batch StartDate-2021-01-01 EndDate-2024-12-31 ProgramID-1 SessionID-4', 'admin', '2020-10-19 10:07:07', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (16, 'Department Setup', 'Department Update', 'Code-001 Name-Department of Japanese Studies FormalName-Department of Japanese Studies Type-Academic Description-Department of Japanese Studies Head-Abdullah-Al-Mamun, PhD', 'admin', '2020-10-19 10:17:07', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (17, 'Department Setup', 'Department Update', 'Code-001 Name-Department of Japanese Studies FormalName-Department of Japanese Studies Type-Academic Description-Department of Japanese Studies Head-Abdullah-Al-Mamun, PhD', 'admin', '2020-10-19 10:20:22', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (18, 'Student Setup', 'Student Entry', 'Name-A.H.M SAKKHAR RAHMAN RegistrationNo-2017-419-006 ClassRoll-MM-100-039 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 12:19:14', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (19, 'Session Setup', 'Session Entry', 'Code-005 Name-2017-2018 Description-2017-2018 Start Date-2017-01-01 End Date-2018-01-31', 'admin', '2020-10-21 12:23:56', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (20, 'Student Setup', 'Student Entry', 'Name-MD. SHAKIBUZZAMAN  CHOWDHURY RegistrationNo-2017-919-029 ClassRoll-ZH-100-055 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-1 ProximityCardID- IsActive-0', 'admin', '2020-10-21 12:26:23', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (21, 'Student Setup', 'Student Entry', 'Name-MUBIN KHAN AFRIDI RegistrationNo-2017-718-879 ClassRoll-KJ-100-023 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-0', 'admin', '2020-10-21 12:28:32', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (22, 'Student Setup', 'Student Entry', 'Name-ZAKIA RIFA NUSAIBA RegistrationNo-2017-415-848 ClassRoll-FM-100-011 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-0', 'admin', '2020-10-21 12:29:59', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (23, 'Student Setup', 'Student Entry', 'Name-KHANDOKAR TAZINA ISLAM RegistrationNo-2017-418-872 ClassRoll-FM-100-016 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-0', 'admin', '2020-10-21 12:31:32', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (24, 'Student Setup', 'Student Update', 'ID-2 Name-A.H.M SAKKHAR RAHMAN RegistrationNo-2017-419-006 ClassRoll-MM-100-039 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 12:31:59', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (25, 'Student Setup', 'Student Entry', 'Name-LUBABA BASHARAT RegistrationNo-2017-318-873 ClassRoll-SN-100-017 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-0', 'admin', '2020-10-21 12:33:31', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (26, 'Student Setup', 'Student Entry', 'Name-SUMAIYA IMTIAZ RegistrationNo-2017-318-891 ClassRoll-KM-100-035 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-0', 'admin', '2020-10-21 12:40:33', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (27, 'Student Setup', 'Student Update', 'ID-7 Name-LUBABA BASHARAT RegistrationNo-2017-318-873 ClassRoll-SN-100-017 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 12:42:20', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (28, 'Student Setup', 'Student Entry', 'Name-FARIDA YEASMIN BANNA RegistrationNo-207-817- ClassRoll-RH-100-039 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-0', 'admin', '2020-10-21 12:48:25', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (29, 'Student Setup', 'Student Entry', 'Name-MD. NAIMUR RAHMAN PIASH RegistrationNo-2017-717-465 ClassRoll-BA-100-003 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-0', 'admin', '2020-10-21 12:50:03', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (30, 'Student Setup', 'Student Update', 'ID-9 Name-FARIDA YEASMIN BANNA RegistrationNo-207-817- ClassRoll-RH-100-002 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-0', 'admin', '2020-10-21 12:50:51', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (31, 'Student Setup', 'Student Entry', 'Name-MD. EMON MIA RegistrationNo-2017-617-466 ClassRoll-SM-100-004 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-0', 'admin', '2020-10-21 12:52:24', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (32, 'Student Setup', 'Student Entry', 'Name-MD. SAIF ULLAH RegistrationNo-2017-517-467 ClassRoll-ZH-100-005 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 12:53:50', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (33, 'Student Setup', 'Student Entry', 'Name-MD. MINARUL ISLAM RegistrationNo-2017-317-469 ClassRoll-MM-100-007 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 12:55:09', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (34, 'Student Setup', 'Student Entry', 'Name-ABDUL MANNAN RegistrationNo-2017-117-470 ClassRoll-FR-100-008 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 12:56:26', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (35, 'Student Setup', 'Student Entry', 'Name-MALIHA BASHER KEYA RegistrationNo-2017-017-471 ClassRoll-SN-100-009 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 12:57:57', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (36, 'Student Setup', 'Student Entry', 'Name-MD. SAYFUL ISLAM RegistrationNo-2017-918-868 ClassRoll-KJ-100-012 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-0', 'admin', '2020-10-21 12:59:22', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (37, 'Student Setup', 'Student Entry', 'Name-SHAMAMA AKTER MIM RegistrationNo-2017-518-871 ClassRoll-KM-100-015 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:00:26', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (38, 'Student Setup', 'Student Entry', 'Name-MD. SHIRAJUL ISLAM RegistrationNo-2017-918-877 ClassRoll-SS-100-021 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:01:23', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (39, 'Student Setup', 'Student Entry', 'Name-AMIT HASAN RegistrationNo-2017-818-878 ClassRoll-ZH-100-022 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:04:05', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (40, 'Student Setup', 'Student Entry', 'Name-MAHMUDA NAZNIN RegistrationNo-2017-518-880 ClassRoll-RH-100-024 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:05:06', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (41, 'Student Setup', 'Student Entry', 'Name-ANANNA KABIR JEHAN RegistrationNo-2017-318-882 ClassRoll-KM-100-026 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:06:42', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (42, 'Student Setup', 'Student Entry', 'Name-RAKIBUL HASSAN RegistrationNo-2017-218-883 ClassRoll-BB-100-027 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:07:39', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (43, 'Student Setup', 'Student Entry', 'Name-NASRIN SULTANA RegistrationNo-2017-118-884 ClassRoll-SK-100-028 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:08:44', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (44, 'Student Setup', 'Student Entry', 'Name-MD. SAZZAD HOSSAIN RegistrationNo-2017-018-885 ClassRoll-ZH-100-029 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:09:32', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (45, 'Student Setup', 'Student Entry', 'Name-TONIMA KHATUN RegistrationNo-2017-418-890 ClassRoll-SN-100-034 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:10:19', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (46, 'Student Setup', 'Student Entry', 'Name-RABEYA SULTANA APON RegistrationNo-2017-519-005 ClassRoll-RH-100-038 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:11:20', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (47, 'Student Setup', 'Student Entry', 'Name-FARINA HAQUE RegistrationNo-2017-119-009 ClassRoll-KM-100-042 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:12:06', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (48, 'Student Setup', 'Student Entry', 'Name-ASIF KAMAL SOURAV RegistrationNo-201-919-010 ClassRoll-SM-100-043 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:13:44', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (49, 'Student Setup', 'Student Entry', 'Name-KAZI HUMAYRA RASHID RegistrationNo-2017-819-011 ClassRoll-SN-100-044 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:14:51', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (50, 'Student Setup', 'Student Entry', 'Name-ABID AHMAD RegistrationNo-2017-719-012 ClassRoll-SS-100-0454 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:15:41', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (51, 'Student Setup', 'Student Entry', 'Name-SHANU AKTER ETI RegistrationNo-2017-519-014 ClassRoll-FM-100-047 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:16:53', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (52, 'Student Setup', 'Student Entry', 'Name-S.M. AFIF IBNA YEAR RegistrationNo-2017-419-024 ClassRoll-FR-100-050 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:18:02', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (53, 'Student Setup', 'Student Entry', 'Name-SHAIKH RASHID BIN ISLAM RegistrationNo-2017-319-025 ClassRoll-MM-100-051 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:19:05', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (54, 'Student Setup', 'Student Entry', 'Name-MD. MEHEDI HASAN NAHID RegistrationNo-2017-019-028 ClassRoll-BA-100-054 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 13:20:15', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (55, 'Student Setup', 'Student Update', 'ID-10 Name-MD. NAIMUR RAHMAN PIASH RegistrationNo-2017-717-465 ClassRoll-BA-100-003 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 14:32:40', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (56, 'Batch Setup', 'Batch Update', 'ID-2 Code-BATCH-002 Name-B.S.S 2nd Batch Description-B.S.S 2nd Batch StartDate-2019-01-01 EndDate-2022-12-31 ProgramID-1 SessionID-2', 'admin', '2020-10-21 22:47:52', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (57, 'Time Slot Setup', 'Time Slot Entry', 'ID-2 Name-6:00 PM - 8:00 PM StartTime-18:00:00 EndTime-20:00:00', 'admin', '2020-10-21 22:50:49', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (58, 'Student Setup', 'Student Update', 'ID-5 Name-ZAKIA RIFA NUSAIBA RegistrationNo-2017-415-848 ClassRoll-FM-100-011 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 22:51:50', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (59, 'Student Setup', 'Student Update', 'ID-6 Name-KHANDOKAR TAZINA ISLAM RegistrationNo-2017-418-872 ClassRoll-FM-100-016 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 22:52:00', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (60, 'Student Setup', 'Student Update', 'ID-9 Name-FARIDA YEASMIN BANNA RegistrationNo-207-817- ClassRoll-RH-100-002 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 22:52:10', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (61, 'Student Setup', 'Student Update', 'ID-16 Name-MD. SAYFUL ISLAM RegistrationNo-2017-918-868 ClassRoll-KJ-100-012 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 22:52:17', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (62, 'Student Setup', 'Student Update', 'ID-11 Name-MD. EMON MIA RegistrationNo-2017-617-466 ClassRoll-SM-100-004 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 22:52:34', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (63, 'Student Setup', 'Student Update', 'ID-8 Name-SUMAIYA IMTIAZ RegistrationNo-2017-318-891 ClassRoll-KM-100-035 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 22:52:45', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (64, 'Student Setup', 'Student Update', 'ID-4 Name-MUBIN KHAN AFRIDI RegistrationNo-2017-718-879 ClassRoll-KJ-100-023 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 22:52:53', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (65, 'Student Setup', 'Student Update', 'ID-3 Name-MD. SHAKIBUZZAMAN  CHOWDHURY RegistrationNo-2017-919-029 ClassRoll-ZH-100-055 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-10-21 22:53:06', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (66, 'Role Setup', 'Role Entry', 'Name-Academic Course Own Course', 'admin', '2020-10-24 11:17:20', '202.86.218.2');
INSERT INTO `sec_accesslog` VALUES (67, 'Role Setup', 'Role Entry', 'Name-Academic Course All Course', 'admin', '2020-10-24 11:17:30', '202.86.218.2');
INSERT INTO `sec_accesslog` VALUES (68, 'Exam Setup', 'Exam Entry', 'ProgramID-1 SemesterID-1 CourseID-1 BatchID-1 Name-Test ExamTypeID-1 Marks-40 Duration-03:00 QuestionType-Writen Question IsApprove-1', 'admin', '2020-10-27 18:27:44', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (69, 'Exam Setup', 'Exam Update', 'ID-1 ProgramID-1 SemesterID-1 CourseID-1 BatchID-1 Name-Test ExamTypeID-1 Marks-40 Duration-02:00 QuestionType-Writen Question IsApprove-1', 'admin', '2020-10-27 18:27:59', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (70, 'Exam Type Setup', 'Exam Type Entry', 'Code-002 Name-Mid Term Marks-30 Duration-02:00 Contribution-20 IsActive-1', 'admin', '2020-10-28 14:21:50', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (71, 'Semester Setup', 'Semester Entry', 'Code-SEM-MJS-001 Name-MJS-1st Semes Masters Semester 1 FormalName-MJS Masters Semester 1 Description- ProgramID=3 SortingNo-1', 'admin', '2020-10-28 14:29:42', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (72, 'Semester Setup', 'Semester Entry', 'Code-SEM-MJS-001 Name-MJS-1st Semester Final FormalName-MJS-1st Semester Final Description-MJS-1st Semester Final ProgramID=3 SortingNo-1', 'admin', '2020-10-28 14:30:24', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (73, 'Semester Setup', 'Semester Update', 'ID-11 Code-SEM-MJS-001 Name-MJS-1st Semester Final FormalName-MJS-1st Semester Final Description-MJS-1st Semester Final ProgramID=3 SortingNo-1', 'admin', '2020-10-28 14:30:55', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (74, 'Semester Setup', 'Semester Entry', 'Code-SEM-MJS-002 Name-MJS-2nd Semester Final FormalName-MJS-2nd Semester Final Description-MJS-2nd Semester Final ProgramID=3 SortingNo-2', 'admin', '2020-10-28 14:33:00', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (75, 'Semester Setup', 'Semester Entry', 'Code-SEM-MJS-003 Name-MJS-3rd Semester Final FormalName-MJS-3rd Semester Final Description-MJS-3rd Semester Final ProgramID=3 SortingNo-3', 'admin', '2020-10-28 14:33:46', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (76, 'Semester Setup', 'Semester Entry', 'Code-SEM-MJS-004 Name-MJS-4th Semester Final FormalName-MJS-4th Semester Final Description-MJS-4th Semester Final ProgramID=3 SortingNo-4', 'admin', '2020-10-28 14:35:05', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (77, 'Time Slot Setup', 'Time Slot Entry', 'Name-10:40 AM - 11:20 AM StartTime-10:40 EndTime-11:20', 'admin', '2020-10-28 14:41:57', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (78, 'Room Setup', 'Room Entry', 'Name-Room No-301 Type-Class Room Level-1 ClassCapacity-45 ExamCapacity-20', 'admin', '2020-10-28 14:44:28', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (79, 'Room Setup', 'Room Entry', 'Name-Room No-302 Type-Class Room Level-1 ClassCapacity-45 ExamCapacity-20', 'admin', '2020-10-28 14:44:43', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (80, 'Designation Setup', 'Designation Entry', 'ID-2 Name-Professore OfficialTitle-Professore Description-Professore SortingNo-1 IsActive-1', 'admin', '2020-10-28 14:45:48', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (81, 'Designation Setup', 'Designation Entry', 'ID-1 Name-Lecturer OfficialTitle-Lecturer Description-Lecturer SortingNo-2 IsActive-1', 'admin', '2020-10-28 14:45:55', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (82, 'Designation Setup', 'Designation Entry', 'Name-Sr. Seminer Assistant OfficialTitle-Sr. Seminer Assistant Description-Sr. Seminer Assistant SortingNo-3 IsActive-1', 'admin', '2020-10-28 14:54:50', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (83, 'Teacher Setup', 'Teacher Entry', 'EmployeeNo-2016077039 Name-Borhan Uddin Mazumdar ShortName-Shahin DesignationID-3 DepartmentID-1 Email-mazumdar520@gmail.com Campus-Dhaka University ProximityCardID- IsActive-1', 'admin', '2020-10-28 14:56:58', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (84, 'User Setup', 'User Entry', 'Name-Shahin EmpID-2016077039', 'admin', '2020-10-28 14:57:51', '10.144.77.46');
INSERT INTO `sec_accesslog` VALUES (85, 'Student Setup', 'Student Update', 'ID-4 Name-MUBIN KHAN AFRIDI RegistrationNo-2017-718-879 ClassRoll-SM-100-023 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'Shahin', '2020-11-01 12:33:05', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (86, 'Student Setup', 'Student Update', 'ID-16 Name-MD. SAYFUL ISLAM RegistrationNo-2017-918-868 ClassRoll-SM-100-012 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'Shahin', '2020-11-01 12:34:15', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (87, 'Student Setup', 'Student Update', 'ID-1 Name-S. M. Rabby Raj RegistrationNo-2017-219-026 ClassRoll-KJ-100-052 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'Shahin', '2020-11-01 13:03:55', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (88, 'Student Setup', 'Student Entry', 'Name-Lutfur Rashid Arafat RegistrationNo-2017-119-027 ClassRoll-ZR-100-053 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'Shahin', '2020-11-01 13:05:58', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (89, 'Student Setup', 'Student Entry', 'Name-Sazzadur Rahman RegistrationNo-2017-619-022 ClassRoll-SS-100-048 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'Shahin', '2020-11-01 13:09:17', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (90, 'Student Setup', 'Student Entry', 'Name-Mohammad Fareeb Uzzaman RegistrationNo-2017-717-681 ClassRoll-MM-100-036 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'Shahin', '2020-11-01 13:11:40', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (91, 'Student Setup', 'Student Update', 'ID-28 Name-ASIF KAMAL SOURAV RegistrationNo-2017-919-010 ClassRoll-SM-100-043 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-11-01 21:08:53', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (92, 'Student Setup', 'Student Update', 'ID-3 Name-MD. SHAKIBUZZAMAN  CHOWDHURY RegistrationNo-2017-919-029 ClassRoll-ZH-100-055 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'admin', '2020-11-01 21:09:35', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (93, 'Session Setup', 'Session Update', 'ID-1 Code-001 Name-2018-2019 Description-2018-2019 StartDate-2018-01-01 EndDate-2021-12-31', 'admin', '2020-11-01 21:10:03', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (94, 'Session Setup', 'Session Update', 'ID-2 Code-002 Name-2019-2020 Description-2019-2020 StartDate-2019-01-01 EndDate-2022-12-31', 'admin', '2020-11-01 21:10:16', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (95, 'Session Setup', 'Session Update', 'ID-3 Code-003 Name-2020-2021 Description-2020-2021 StartDate-2020-01-01 EndDate-2023-12-31', 'admin', '2020-11-01 21:10:39', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (96, 'Session Setup', 'Session Update', 'ID-4 Code-004 Name-2021-2022 Description-2021-2022 StartDate-2021-01-01 EndDate-2024-12-31', 'admin', '2020-11-01 21:10:54', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (97, 'Session Setup', 'Session Update', 'ID-5 Code-006 Name-2017-2018 Description-2017-2018 StartDate-2017-01-01 EndDate-2018-01-31', 'admin', '2020-11-01 21:11:10', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (98, 'Session Setup', 'Session Update', 'ID-5 Code-001 Name-2017-2018 Description-2017-2018 StartDate-2017-01-01 EndDate-2018-01-31', 'admin', '2020-11-01 21:11:21', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (99, 'Session Setup', 'Session Update', 'ID-4 Code-005 Name-2021-2022 Description-2021-2022 StartDate-2021-01-01 EndDate-2024-12-31', 'admin', '2020-11-01 21:11:31', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (100, 'Session Setup', 'Session Update', 'ID-3 Code-004 Name-2020-2021 Description-2020-2021 StartDate-2020-01-01 EndDate-2023-12-31', 'admin', '2020-11-01 21:11:41', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (101, 'Session Setup', 'Session Update', 'ID-2 Code-003 Name-2019-2020 Description-2019-2020 StartDate-2019-01-01 EndDate-2022-12-31', 'admin', '2020-11-01 21:11:51', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (102, 'Session Setup', 'Session Update', 'ID-1 Code-002 Name-2018-2019 Description-2018-2019 StartDate-2018-01-01 EndDate-2021-12-31', 'admin', '2020-11-01 21:12:08', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (103, 'Session Setup', 'Session Update', 'ID-5 Code-001 Name-2017-2018 Description-2017-2018 StartDate-2017-01-01 EndDate-2018-01-31', 'admin', '2020-11-01 21:12:29', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (104, 'Session Setup', 'Session Update', 'ID-5 Code-001 Name-2017-2018 Description-2017-2018 StartDate-2017-01-01 EndDate-2020-12-31', 'admin', '2020-11-01 21:13:03', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (105, 'Student Setup', 'Student Entry', 'Name-Tasriful Kabir RegistrationNo-2017-118-875 ClassRoll-ZR-100-019 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 10:46:44', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (106, 'Student Setup', 'Student Update', 'ID-5 Name-ZAKIA RIFA NUSAIBA RegistrationNo-2017-415-848 ClassRoll-RH-100-011 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 10:49:03', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (107, 'Student Setup', 'Student Update', 'ID-19 Name-AMIT HASAN RegistrationNo-2017-818-878 ClassRoll-ZR-100-022 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 10:52:02', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (108, 'Student Setup', 'Student Update', 'ID-24 Name-MD. SAZZAD HOSSAIN RegistrationNo-2017-018-885 ClassRoll-ZR-100-029 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 10:53:10', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (109, 'Student Setup', 'Student Update', 'ID-38 Name-Tasriful Kabir RegistrationNo-2017-118-875 ClassRoll-ZH-100-019 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 10:54:11', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (110, 'Student Setup', 'Student Entry', 'Name-ABDUL AWAL MINTU RegistrationNo-2018-722-585 ClassRoll-AA-100-010 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 10:59:40', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (111, 'Student Setup', 'Student Entry', 'Name-FERDOUS SIDDIQUE SAYMON RegistrationNo-2018-724-268 ClassRoll-AA-100-37 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 11:02:13', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (112, 'Student Setup', 'Student Entry', 'Name-MD. MAHBUB HASAN RegistrationNo-2018-624-278 ClassRoll-AA-100-047 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 11:03:38', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (113, 'Student Setup', 'Student Entry', 'Name-MD. ARAFATUL ISLAM RIDOYAN RegistrationNo-2018-724-277 ClassRoll-AA-100-053 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 11:04:48', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (114, 'Student Setup', 'Student Update', 'ID-42 Name-MD. HADI ISLAM RegistrationNo-2018-724-277 ClassRoll-BE-100-046 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 11:21:55', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (115, 'Student Setup', 'Student Entry', 'Name-MOHAMMAD RAKIBUL AL HASAN NUR RegistrationNo-2018-124-291 ClassRoll-BE-100-060 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 11:30:35', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (116, 'Student Setup', 'Student Entry', 'Name-AHMAD REZA MINHAJ RegistrationNo-2018-722-576 ClassRoll-BE-100-001 ExamRoll- Email-ahamadrezaminhaj2001@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 11:35:42', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (117, 'Student Setup', 'Student Update', 'ID-42 Name-MD. HADI ISLAM RegistrationNo-2018-724-277 ClassRoll-BE-100-046 ExamRoll-  Email-a.hadiislam01@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 11:38:26', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (118, 'Student Setup', 'Student Entry', 'Name-MD. ABDUR RAHIM SAGOR RegistrationNo-2018-024-283 ClassRoll-BE-100-052 ExamRoll- Email-abdurrahimsagor102@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 11:46:18', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (119, 'Student Setup', 'Student Entry', 'Name-ARMAN ALAM RegistrationNo-2018-624-269 ClassRoll-SS-100-038 ExamRoll- Email-mdarmank966@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 12:26:12', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (120, 'Student Setup', 'Student Entry', 'Name-FATIN HASNAT RAHMAN SETU RegistrationNo-2018-224-281 ClassRoll-SS-100-050 ExamRoll- Email-fatinhasnatdjs@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 12:29:16', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (121, 'Student Setup', 'Student Entry', 'Name-MD. ABIDUR RAHMAN RegistrationNo-2018-122-581 ClassRoll-SS-100-006 ExamRoll- Email-muhammodabiddu@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 12:31:49', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (122, 'Student Setup', 'Student Entry', 'Name-ZAHID HASAN RegistrationNo-2018-321-733 ClassRoll-SS-100-0029 ExamRoll- Email-Zahidhrid5@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 12:34:07', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (123, 'Student Setup', 'Student Entry', 'Name-MD. ASHIKUR RAHMAN RegistrationNo-2018-924-301 ClassRoll-SS-100-070 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 12:46:31', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (124, 'Student Setup', 'Student Entry', 'Name-PAVEL SARKAR RegistrationNo-2018-824-267 ClassRoll-ZR-100-036 ExamRoll- Email-pavelsk883@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 12:50:12', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (125, 'Student Setup', 'Student Entry', 'Name-MD. EFRAT JAHAN BHUIYAN SHAFIN RegistrationNo-2018-624-287 ClassRoll-ZR-100-056 ExamRoll- Email-m.shafin004@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 12:54:45', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (126, 'Student Setup', 'Student Entry', 'Name-MD. ZAHIDUL ISLAM HRIDOY RegistrationNo-2018-624-296 ClassRoll-ZR-100-065 ExamRoll- Email-Zahidhrid5@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 12:57:11', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (127, 'Student Setup', 'Student Entry', 'Name-TILAK SAHA RegistrationNo-2018-024-292 ClassRoll-JH-100-061 ExamRoll- Email-ridtilak20@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 12:59:28', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (128, 'Student Setup', 'Student Entry', 'Name-ANTON CHAKMA RegistrationNo-2018-323-948 ClassRoll-JH-100-018 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:00:53', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (129, 'Student Setup', 'Student Entry', 'Name-SHUVRAM ROY RegistrationNo-2018-824-294 ClassRoll-JH-100-063 ExamRoll- Email-roy.shuvram@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:02:11', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (130, 'Student Setup', 'Student Entry', 'Name-NAYEEMUL HASAN NAYEEM RegistrationNo-2018-323-948 ClassRoll-KJ-100-075 ExamRoll- Email-nayemulhasannayem999@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:04:35', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (131, 'Student Setup', 'Student Entry', 'Name-YIASIN ARAFAT ALIF RegistrationNo-2018-324-262 ClassRoll-KJ-100-031 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:08:00', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (132, 'Student Setup', 'Student Entry', 'Name-MAHDI NASIF IQBAL MAHI RegistrationNo-2018-024-265 ClassRoll-KJ-100-034 ExamRoll- Email-mahinasif06@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:09:39', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (133, 'Student Setup', 'Student Entry', 'Name-MD. KHALID HASAN SHISHIR RegistrationNo-2018-224-272 ClassRoll-KJ-100-041 ExamRoll- Email-khalidhasanshishir@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:11:32', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (134, 'Student Setup', 'Student Entry', 'Name-MD. JAWAD SAIF RegistrationNo-2018-824-302 ClassRoll-KJ-100-071 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:15:30', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (135, 'Student Setup', 'Student Entry', 'Name-FERDOUS SALEHIN RegistrationNo-2018-824-285 ClassRoll-KJ-100-054 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:17:05', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (136, 'Student Setup', 'Student Entry', 'Name-SABRINA ZAHIR RegistrationNo-2018-624-188 ClassRoll-KM-100-093 ExamRoll- Email-sabrinazahirmuna17@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:19:06', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (137, 'Student Setup', 'Student Entry', 'Name-MEHZABIN BINTE MESBAH RegistrationNo-2018-323-993 ClassRoll-KM-100-076 ExamRoll- Email-mehzabinmeem999@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:20:31', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (138, 'Student Setup', 'Student Entry', 'Name-AWSAFUR RAHMAN RegistrationNo-2018-127-397 ClassRoll-MM-100-079 ExamRoll- Email-awsafurrahman1998@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:24:02', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (139, 'Student Setup', 'Student Entry', 'Name-MONSUR AHMED RAFI RegistrationNo-2018-227-396 ClassRoll-MM-100-078 ExamRoll- Email-rafi.monsur7000@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:26:56', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (140, 'Student Setup', 'Student Entry', 'Name-ABDULAH MAHMMAD AKRAM RegistrationNo-2018-922-583 ClassRoll-MM-100-008 ExamRoll- Email-abdullahmohammadakram25@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:28:40', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (141, 'Student Setup', 'Student Entry', 'Name-MD. SHAJAHAN HOSSAIN RegistrationNo-2018-021-709 ClassRoll-MM-100-025 ExamRoll- Email-mdshajahanshan@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:31:00', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (142, 'Student Setup', 'Student Entry', 'Name-NOWROZ AMIN BORSHON RegistrationNo-2018-924-275 ClassRoll-MM-100-044 ExamRoll- Email-nawrozborshon17@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:32:36', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (143, 'Student Setup', 'Student Update', 'ID-55 Name-ANTON CHAKMA RegistrationNo-2018-323-948 ClassRoll-JH-100-018 ExamRoll-  Email-antonchangma@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:34:18', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (144, 'Student Setup', 'Student Entry', 'Name-FIRUZ HUMAYRA METHE RegistrationNo-2018-519-023 ClassRoll-RH-100-049 ExamRoll- Email-humairaahmed532@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:36:08', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (145, 'Student Setup', 'Student Entry', 'Name-MST. RUBYA AREFIN RegistrationNo-2018-622-577 ClassRoll-RH-100-002 ExamRoll- Email-arefinrubya@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:38:15', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (146, 'Student Setup', 'Student Entry', 'Name-NISHAT TASNIM MOMO RegistrationNo-2018-224-290 ClassRoll-RH-100-059 ExamRoll- Email-nishatmomodu@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:39:57', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (147, 'Student Setup', 'Student Entry', 'Name-A. S. M. BHOKHARE RegistrationNo-2018-921-728 ClassRoll-SM-100-028 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:43:06', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (148, 'Student Setup', 'Student Update', 'ID-73 Name-MASUM BILLAH RegistrationNo-2018-9422-579 ClassRoll-SM-100-004 ExamRoll-  Email-masumbillal8888@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:46:39', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (149, 'Student Setup', 'Student Entry', 'Name-MD. ABDUL HANNAN RegistrationNo-2018-922-592 ClassRoll-SM-100-017 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 13:49:57', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (150, 'Student Setup', 'Student Entry', 'Name-MD. MIRAZUL HAQUE RegistrationNo-2018-222-580 ClassRoll-ZH-100-005 ExamRoll- Email-mirajulislam1573@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 14:53:49', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (151, 'Student Setup', 'Student Entry', 'Name-ABDULLAH AL MAMUN RegistrationNo-2018-022-591 ClassRoll-ZH-100-016 ExamRoll- Email-abdullahalmamun3490@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 14:55:07', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (152, 'Student Setup', 'Student Entry', 'Name-MD. RAHAT RegistrationNo-2018-621-776 ClassRoll-ZH-100-030 ExamRoll- Email-rahat.tanjir75@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 14:56:12', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (153, 'Student Setup', 'Student Entry', 'Name-MD. MANIRUZZAMAN RegistrationNo-2018-124-264 ClassRoll-ZH-100-033 ExamRoll- Email-monirvabuk@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 14:57:50', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (154, 'Student Setup', 'Student Entry', 'Name-TANZID AHAMMAD RegistrationNo-2018-124-273 ClassRoll-ZH-100-042 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 14:59:35', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (155, 'Student Setup', 'Student Entry', 'Name-MEHEDI HASAN RegistrationNo-2018-924-266 ClassRoll-BB-100-035 ExamRoll- Email-mhmehedi505@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:02:08', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (156, 'Student Setup', 'Student Entry', 'Name-RASEL RAHAMAN RegistrationNo-2018-324-271 ClassRoll-BB-100-040 ExamRoll- Email-raselrahaman0804@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:03:41', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (157, 'Student Setup', 'Student Entry', 'Name-TANVIR HASAN CHOWDHURY RegistrationNo-2018-124-282 ClassRoll-BB-100-051 ExamRoll- Email-tanvirfuad93@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:04:55', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (158, 'Student Setup', 'Student Entry', 'Name-TASKHINA JANNAT JEBIN RegistrationNo-2018-921-719 ClassRoll-SN-100-027 ExamRoll- Email-taskhina123@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:07:31', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (159, 'Student Setup', 'Student Entry', 'Name-ISRAT JAHAN SRABONI RegistrationNo-2018-024-274 ClassRoll-SN-100-043 ExamRoll- Email-israboni927@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:15:20', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (160, 'Student Setup', 'Student Entry', 'Name-MST. TASNIA YASMIN RegistrationNo-2018-324-280 ClassRoll-SN-100-049 ExamRoll- Email-tasniayasmin16@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:16:28', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (161, 'Student Setup', 'Student Entry', 'Name-FERDOUS ARA TISHA RegistrationNo-2018-727-300 ClassRoll-SN-100-077 ExamRoll- Email-ferdousaratisha@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:17:41', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (162, 'Student Setup', 'Student Entry', 'Name-MST. TONIMA AFRIN RegistrationNo-2018-724-295 ClassRoll-SN-100-064 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:19:31', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (163, 'Student Setup', 'Student Entry', 'Name-SHAMMI AKTER PRIYANKA RegistrationNo-2018-623-981 ClassRoll-FM-100-073 ExamRoll- Email-shammyakterpriyanka@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:21:02', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (164, 'Student Setup', 'Student Entry', 'Name-MST. BEAUTY KHATUN RegistrationNo-2018-822-584 ClassRoll-FM-100-009 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:23:09', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (165, 'Student Setup', 'Student Entry', 'Name-MST. BEAUTY KHATUN RegistrationNo-2018-822-584 ClassRoll-FM-100-009 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:28:05', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (166, 'Student Setup', 'Student Entry', 'Name-HENA KHATUN RegistrationNo-2018-424-270 ClassRoll-FM-100-039 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:29:36', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (167, 'Student Setup', 'Student Entry', 'Name-SATRIA ZAMAN RegistrationNo-2018-424-289 ClassRoll-FM-100-058 ExamRoll- Email-zamansatria6@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:30:58', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (168, 'Student Setup', 'Student Entry', 'Name-HASNA JAHAN RegistrationNo-2018-424-298 ClassRoll-SN-100-067 ExamRoll- Email-jahanhasna00@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:32:55', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (169, 'Student Setup', 'Student Entry', 'Name-TANZILA JAHAN RegistrationNo-2018-621-767 ClassRoll-SK-100-026 ExamRoll- Email-tanzilajahan902@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:34:13', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (170, 'Student Setup', 'Student Entry', 'Name-FAHIMA ISLAM TAZIN RegistrationNo-2018-824-276 ClassRoll-SK-100-045 ExamRoll- Email-islamtazin6@gmail.com DepartmentID-1 ProgramID-1 SessionID-1 BatchID-2 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:35:51', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (171, 'Student Setup', 'Student Entry', 'Name-SITHI ROY RegistrationNo-2019-413-686 ClassRoll-RH-100-002 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 15:54:39', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (172, 'Student Setup', 'Student Entry', 'Name-SITHI ROY RegistrationNo-2018-413-686 ClassRoll-RH-100-002 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 18:43:05', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (173, 'Student Setup', 'Student Entry', 'Name-SUMONA AKTHAR SUMA RegistrationNo-2018-515-692 ClassRoll-RH-100-015 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 18:44:39', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (174, 'Student Setup', 'Student Entry', 'Name-NAFISA TASNIM JUI RegistrationNo-2019-215-703 ClassRoll-RH-100-026 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 18:46:13', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (175, 'Student Setup', 'Student Entry', 'Name-TASMIA MAHMUDA RegistrationNo-2019-515-719 ClassRoll-RH-100-042 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 18:48:25', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (176, 'Student Setup', 'Student Entry', 'Name-TASNI JUAIRIA BRINTY RegistrationNo-2019-919-036 ClassRoll-RH-100-50 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 18:49:42', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (177, 'Student Setup', 'Student Entry', 'Name-RIFAH NANJIBA MAMUN RegistrationNo-2019-219-042 ClassRoll-RH-100-056 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 18:51:00', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (178, 'Student Setup', 'Student Entry', 'Name-TANZIM RAHMAN TASHIN RegistrationNo-2019-119-043 ClassRoll-RH-100-057 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 18:52:26', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (179, 'Student Setup', 'Student Entry', 'Name-SOURAV PRAMANIK RegistrationNo-2019-315-694 ClassRoll-RH-100-017 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 18:54:23', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (180, 'Student Setup', 'Student Update', 'ID-104 Name-SOURAV PRAMANIK RegistrationNo-2019-315-694 ClassRoll-JH-100-017 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 18:55:55', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (181, 'Student Setup', 'Student Entry', 'Name-PRONOY DEVNATH RegistrationNo-2019-015-697 ClassRoll-JH-100-020 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 18:57:02', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (182, 'Student Setup', 'Student Entry', 'Name-SAMARPON BARUA RegistrationNo-2019-515-700 ClassRoll-JH-100-023 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 18:58:10', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (183, 'Student Setup', 'Student Entry', 'Name-ARUP KUMAR BISWAS RegistrationNo-2019-719-047 ClassRoll-JH-100-061 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 18:59:34', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (184, 'Student Setup', 'Student Entry', 'Name-MD. FAHIM AL FOYSAL RegistrationNo-2019-915-715 ClassRoll-JH-100-038 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 19:00:55', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (185, 'Student Setup', 'Student Update', 'ID-108 Name-MD. FAHIM AL FOYSAL RegistrationNo-2019-915-715 ClassRoll-BB-100-038 ExamRoll-  Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 19:01:49', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (186, 'Student Setup', 'Student Entry', 'Name-MD. AJASIM ALI RegistrationNo-2019-214-281 ClassRoll-BB-100-046 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 19:03:06', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (187, 'Student Setup', 'Student Entry', 'Name-SADIYA AFRIN ZITU RegistrationNo-2019-113-689 ClassRoll-SN-100-005 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 19:04:35', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (188, 'Student Setup', 'Student Entry', 'Name-MARIA FARJANA OISHEE RegistrationNo-2019-415-693 ClassRoll-SN-100-016 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 19:05:50', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (189, 'Student Setup', 'Student Entry', 'Name-HABIBA AKTER TISA RegistrationNo-2019-215-695 ClassRoll-SN-100-018 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 19:07:08', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (190, 'Student Setup', 'Student Entry', 'Name-SUMAYA YASMIN RITU RegistrationNo-2019-113-698 ClassRoll-SN-100-044 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 19:09:06', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (191, 'Student Setup', 'Student Entry', 'Name-DEVO PRIA DAS DISHA RegistrationNo-2019-018-720 ClassRoll-SN-100-048 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 19:10:08', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (192, 'Student Setup', 'Student Entry', 'Name-MAHI MUSHARRATRAHMAN RegistrationNo-2019-319-041 ClassRoll-SN-100-055 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 19:11:58', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (193, 'Student Setup', 'Student Entry', 'Name-TABASSUM AKTER NISHE RegistrationNo-2019-619-048 ClassRoll-SN-100-062 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 19:13:05', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (194, 'Student Setup', 'Student Entry', 'Name-SOYODA MORSHEDA ISLAM RegistrationNo-2019-513-694 ClassRoll-SK-100-010 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 20:10:15', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (195, 'Student Setup', 'Student Entry', 'Name-SANJANA NOURIN KHAN SHOYLE RegistrationNo-2019-019-044 ClassRoll-SK-100-058 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 20:12:15', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (196, 'Student Setup', 'Student Entry', 'Name-MD.SHADMAN SAKIB RegistrationNo-2019-315-711 ClassRoll-ZH-100-034 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 20:13:35', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (197, 'Student Setup', 'Student Entry', 'Name-NAFIS FUAD RegistrationNo-2019-315-720 ClassRoll-ZH-100-043 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 20:14:52', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (198, 'Student Setup', 'Student Entry', 'Name-MD.TOWHIDUL ISLAM RegistrationNo-2019-019-035 ClassRoll-ZH-100-049 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-02 20:16:05', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (199, 'Student Setup', 'Student Entry', 'Name-MIRAZ UDDIN SHIHAB RegistrationNo-2019-115-704 ClassRoll-FR-100-027 ExamRoll- Email-mirazuddinshihab@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:19:51', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (200, 'Student Setup', 'Student Entry', 'Name-MD. RABIUL ISLAM HRIDOY RegistrationNo-2019-819-037 ClassRoll-FR-100-051 ExamRoll- Email-hridoyrislam20@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:21:38', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (201, 'Student Setup', 'Student Entry', 'Name-MD. MUSA ISLAM RegistrationNo-2019-319-410 ClassRoll-FR-100-063 ExamRoll- Email-smusa50123@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:23:06', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (202, 'Student Setup', 'Student Entry', 'Name-AZHARUL ISLAM RegistrationNo-2019-513-685 ClassRoll-BE-100-001 ExamRoll- Email-mdazharulislam564@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:24:35', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (203, 'Student Setup', 'Student Entry', 'Name-AHMED ZABIR RegistrationNo-2019-715-690 ClassRoll-BE-100-013 ExamRoll- Email-ahmedzabir932001@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:25:55', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (204, 'Student Setup', 'Student Entry', 'Name-MD. NEWAS SHARIF RegistrationNo-2019-615-718 ClassRoll-BE-100-041 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:28:39', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (205, 'Student Setup', 'Student Entry', 'Name-MARWAN MOSTOFA KHADEM RegistrationNo-2019-919-045 ClassRoll-BE-100-059 ExamRoll- Email-marwankhadem9@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:30:10', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (206, 'Student Setup', 'Student Entry', 'Name-MAHMUDUL HASAN SHAMIM RegistrationNo-2019-913-690 ClassRoll-ZR-100-006 ExamRoll- Email-shamim31916@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:32:18', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (207, 'Student Setup', 'Student Entry', 'Name-MD. ABU NASER SIDDIK RegistrationNo-2019-815-699 ClassRoll-ZR-100-022 ExamRoll- Email-naserabu193@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:33:50', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (208, 'Student Setup', 'Student Entry', 'Name-SK. RAKIBUL ISLAM RegistrationNo-2019-915-706 ClassRoll-ZR-100-029 ExamRoll- Email-rakibulislamsk27@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:35:08', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (209, 'Student Setup', 'Student Entry', 'Name-MOHAMMAD ALI HOSSAIN ARKO RegistrationNo-2019-615-709 ClassRoll-ZR-100-032 ExamRoll- Email-arkohossain30@gmai.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:36:34', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (210, 'Student Setup', 'Student Entry', 'Name-MD. SOJON RegistrationNo-2019-213-688 ClassRoll-SS-100-004 ExamRoll- Email-mdsojonsorkar5640@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:38:48', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (211, 'Student Setup', 'Student Entry', 'Name-MD. SHIFAT AL SHAFI RegistrationNo-2019-915-698 ClassRoll-SS-100-021 ExamRoll- Email-shifatalshafi@Gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:40:26', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (212, 'Student Setup', 'Student Entry', 'Name-MAHBUBUL NEWAS FARSIM RegistrationNo-2019-719-038 ClassRoll-SS-100-052 ExamRoll- Email-newazfarsim@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:42:03', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (213, 'Student Setup', 'Student Entry', 'Name-SADIKEEN KAZI RegistrationNo-2019-813-691 ClassRoll-KM-100-007 ExamRoll- Email-sadikeenkazi@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:44:46', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (214, 'Student Setup', 'Student Entry', 'Name-FATEMA ISLAM RegistrationNo-2019-615-691 ClassRoll-KM-100-014 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:47:11', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (215, 'Student Setup', 'Student Entry', 'Name-SAADIYA TASNEEM PRAPTY RegistrationNo-2019-115-704 ClassRoll-KM-100-036 ExamRoll- Email-saadiyatasneem007@gmai.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:49:38', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (216, 'Student Setup', 'Student Entry', 'Name-MARJUBAH AFRAH RegistrationNo-2019-619-039 ClassRoll-KM-100-053 ExamRoll- Email-marjubahafrah09344@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:51:43', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (217, 'Student Setup', 'Student Entry', 'Name-JANNAUTL RAIAN JERIN RegistrationNo-2019-419-040 ClassRoll-KM-100-054 ExamRoll- Email-jannatuljerin5578@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:53:24', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (218, 'Student Setup', 'Student Entry', 'Name-NOSHIN TUSNIM ARPA RegistrationNo-2019-819-046 ClassRoll-KM-100-060 ExamRoll- Email-noshintusnimarpa@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:54:56', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (219, 'Student Setup', 'Student Entry', 'Name-MD. MUNTAKIM HOSSAIN RegistrationNo-2019-315-702 ClassRoll-MM-100-025 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:57:15', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (220, 'Student Setup', 'Student Entry', 'Name-MD. RAHAT SIKDER RegistrationNo-2019-215-712 ClassRoll-MM-100-035 ExamRoll- Email-rahat.du28@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 10:59:13', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (221, 'Student Setup', 'Student Entry', 'Name-DEVO PRIA DAS DISHA RegistrationNo-2019-018-720 ClassRoll-SN-100-048 ExamRoll- Email-devopriyadasdisha@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:00:41', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (222, 'Student Setup', 'Student Entry', 'Name-NAIMUR RAHMAN RegistrationNo-2019-613-693 ClassRoll-KJ-100-009 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:02:40', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (223, 'Student Setup', 'Student Entry', 'Name-MD. FARHAN BIN HAMID AL MAIDI RegistrationNo-2019-015-705 ClassRoll-KJ-100-028 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:06:01', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (224, 'Student Setup', 'Student Entry', 'Name-MD. HASANUR RAHMAN HASAN RegistrationNo-2019-313-687 ClassRoll-SM-100-003 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:08:26', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (225, 'Student Setup', 'Student Entry', 'Name-MD. ASRAFUL ISLAM RegistrationNo-2019-314-262 ClassRoll-SM-100-045 ExamRoll- Email-asrafulalam5247@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:10:20', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (226, 'Student Setup', 'Student Entry', 'Name-RAJAUL KARIM RegistrationNo-2019-415-341 ClassRoll-SM-100-047 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:12:35', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (227, 'Student Setup', 'Student Entry', 'Name-SAMIA MAHMUD RegistrationNo-2019-713-692 ClassRoll-FM-100-008 ExamRoll- Email-Islamsamia890@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:14:19', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (228, 'Student Setup', 'Student Entry', 'Name-SYADA MIEL AHMED RegistrationNo-2019-115-63-696 ClassRoll-FM-100-019 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:17:58', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (229, 'Student Setup', 'Student Update', 'ID-108 Name-MD. FAHIM AL FOYSAL RegistrationNo-2019-915-715 ClassRoll-BB-100-038 ExamRoll-  Email-fahimalfaysal27852@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:23:08', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (230, 'Student Setup', 'Student Update', 'ID-109 Name-MD. JASIM ALI RegistrationNo-2019-214-281 ClassRoll-BB-100-046 ExamRoll-  Email-md.jasim203571@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:24:37', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (231, 'Student Setup', 'Student Update', 'ID-118 Name-SANJANA NOURIN KHAN SHOYLE RegistrationNo-2019-019-044 ClassRoll-SK-100-058 ExamRoll-  Email-sanjananourin1810@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:26:11', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (232, 'Student Setup', 'Student Update', 'ID-105 Name-PRONOY DEVNATH RegistrationNo-2019-015-697 ClassRoll-JH-100-020 ExamRoll-  Email-Pronaydevnath163@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:28:31', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (233, 'Student Setup', 'Student Update', 'ID-104 Name-SOURAV PRAMANIK RegistrationNo-2019-315-694 ClassRoll-JH-100-017 ExamRoll-  Email-tijopramanik@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:30:29', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (234, 'Student Setup', 'Student Update', 'ID-106 Name-SAMARPON BARUA RegistrationNo-2019-515-700 ClassRoll-JH-100-023 ExamRoll-  Email-samarpon12@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:31:57', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (235, 'Student Setup', 'Student Update', 'ID-98 Name-SUMONA AKTHAR SUMA RegistrationNo-2018-515-692 ClassRoll-RH-100-015 ExamRoll-  Email-sumonarahman371@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:33:01', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (236, 'Student Setup', 'Student Update', 'ID-99 Name-NAFISA TASNIM JUI RegistrationNo-2019-215-703 ClassRoll-RH-100-026 ExamRoll-  Email-nafisatassniim@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:34:38', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (237, 'Student Setup', 'Student Update', 'ID-117 Name-SOYODA MORSHEDA ISLAM RegistrationNo-2019-513-694 ClassRoll-SK-100-010 ExamRoll-  Email-Soyodamorsheda@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:41:27', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (238, 'Student Setup', 'Student Update', 'ID-117 Name-SOYODA MORSHEDA ISLAM RegistrationNo-2019-513-694 ClassRoll-SK-100-010 ExamRoll-  Email-Soyodamorsheda@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:43:19', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (239, 'Student Setup', 'Student Update', 'ID-115 Name-MAHI MUSHARRAT RAHMAN RegistrationNo-2019-319-041 ClassRoll-SN-100-055 ExamRoll-  Email-mahirahman2000@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:44:49', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (240, 'Student Setup', 'Student Update', 'ID-115 Name-MAHI MUSHARRAT RAHMAN RegistrationNo-2019-319-041 ClassRoll-SN-100-055 ExamRoll-  Email-mahirahman2000@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:47:04', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (241, 'Student Setup', 'Student Update', 'ID-120 Name-NAFIS FUAD RegistrationNo-2019-315-720 ClassRoll-ZH-100-043 ExamRoll-  Email-nafis_fuad@outlook.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:47:40', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (242, 'Student Setup', 'Student Update', 'ID-121 Name-MD.TOWHIDUL ISLAM RegistrationNo-2019-019-035 ClassRoll-ZH-100-049 ExamRoll-  Email-towhidul.islam.1999@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:49:14', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (243, 'Student Setup', 'Student Update', 'ID-119 Name-MD.SHADMAN SAKIB RegistrationNo-2019-315-711 ClassRoll-ZH-100-034 ExamRoll-  Email-daddysakib@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:50:11', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (244, 'Student Setup', 'Student Update', 'ID-116 Name-TABASSUM AKTER NISHE RegistrationNo-2019-619-048 ClassRoll-SN-100-062 ExamRoll-  Email-tabassumnishe5830@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:51:43', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (245, 'Student Setup', 'Student Update', 'ID-119 Name-MD. SADMAN SAKIB RegistrationNo-2019-315-711 ClassRoll-ZH-100-034 ExamRoll-  Email-daddysakib@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:52:09', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (246, 'Student Setup', 'Student Update', 'ID-110 Name-SADIYA AFRIN ZITU RegistrationNo-2019-113-689 ClassRoll-SN-100-005 ExamRoll-  Email-sadiyazitu22@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:55:54', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (247, 'Student Setup', 'Student Update', 'ID-110 Name-SADIYA AFRIN ZITU RegistrationNo-2019-113-689 ClassRoll-SN-100-005 ExamRoll-  Email-sadiyazitu22@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:56:45', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (248, 'Student Setup', 'Student Update', 'ID-149 Name-RAJAUL KARIM RegistrationNo-2019-415-341 ClassRoll-SM-100-047 ExamRoll-  Email-rezaulrk892@gmai.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:57:57', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (249, 'Student Setup', 'Student Update', 'ID-114 Name-DEVO PRIA DAS DISHA RegistrationNo-2019-018-720 ClassRoll-SN-100-048 ExamRoll-  Email-devopriyadasdisha@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 11:59:35', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (250, 'Student Setup', 'Student Update', 'ID-114 Name-DEVO PRIA DAS DISHA RegistrationNo-2019-018-720 ClassRoll-SN-100-048 ExamRoll-  Email-devopriyadasdisha@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:00:26', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (251, 'Student Setup', 'Student Entry', 'Name-SITHI ROY RegistrationNo-2019-413-686 ClassRoll-RH-100-002 ExamRoll- Email-sithiroy2019@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:02:24', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (252, 'Student Setup', 'Student Update', 'ID-111 Name-MARIA FARJANA OISHEE RegistrationNo-2019-415-693 ClassRoll-SN-100-016 ExamRoll-  Email-mariafarzana444@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:04:15', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (253, 'Student Setup', 'Student Update', 'ID-111 Name-MARIA FARJANA OISHEE RegistrationNo-2019-415-693 ClassRoll-SN-100-016 ExamRoll-  Email-mariafarzana444@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:05:35', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (254, 'Student Setup', 'Student Update', 'ID-112 Name-HABIBA AKTER TISA RegistrationNo-2019-215-695 ClassRoll-SN-100-018 ExamRoll-  Email-habibaaktertisa33@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:05:59', '10.134.72.255');
INSERT INTO `sec_accesslog` VALUES (255, 'Student Setup', 'Student Entry', 'Name-SITHI ROY RegistrationNo-2019-413-686 ClassRoll-RH-100-002 ExamRoll- Email-sithiroy2019@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:27:59', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (256, 'Student Setup', 'Student Entry', 'Name-SITHI ROY RegistrationNo-2019-413-686 ClassRoll-RH-100-002 ExamRoll- Email-sithiroy2019@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:31:42', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (257, 'Student Setup', 'Student Entry', 'Name-SITHI ROY RegistrationNo-2019-413-686 ClassRoll-RH-100-002 ExamRoll- Email-sithiroy2019@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:34:22', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (258, 'Student Setup', 'Student Update', 'ID-103 Name-TANZIM RAHMAN TASHIN RegistrationNo-2019-119-043 ClassRoll-RH-100-057 ExamRoll-  Email-tashintanzim112@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:42:58', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (259, 'Student Setup', 'Student Update', 'ID-119 Name-MD. SHADMAN SAKIB RegistrationNo-2019-315-711 ClassRoll-ZH-100-034 ExamRoll-  Email-daddysakib@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:44:36', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (260, 'Student Setup', 'Student Update', 'ID-28 Name-ASIF KAMAL SOURAV RegistrationNo-2017-919-010 ClassRoll-SM-100-043 ExamRoll-  Email-tijopramanik@gmail.com DepartmentID-1 ProgramID-1 SessionID-5 BatchID-1 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:46:12', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (261, 'Student Setup', 'Student Entry', 'Name-ARUP KUMAR BISWAS RegistrationNo-2019-719-047 ClassRoll-JH-100-061 ExamRoll- Email-arupbiswas3963@gmai.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:48:58', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (262, 'Student Setup', 'Student Entry', 'Name-SHUMAYA YASMIN RITU RegistrationNo-2019-113-698 ClassRoll-SN-100-044 ExamRoll- Email-ritu82275@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:52:41', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (263, 'Student Setup', 'Student Entry', 'Name-SITHI ROY RegistrationNo-2019-413-686 ClassRoll-RH-100-002 ExamRoll- Email-sithiroy2019@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:54:46', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (264, 'Student Setup', 'Student Entry', 'Name-AZHARUL ISLAM RegistrationNo-2019-513-685 ClassRoll-BE-100-001 ExamRoll- Email-mdazharulislam564@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:57:17', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (265, 'Student Setup', 'Student Entry', 'Name-AZHARUL ISLAM RegistrationNo-2019-100-685 ClassRoll-BA-100-001 ExamRoll- Email-mdazharulislam564@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 12:59:09', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (266, 'Student Setup', 'Student Entry', 'Name-ABU NASER DISSIK RegistrationNo-2019-815-699 ClassRoll-ZH-100-022 ExamRoll- Email-naserabu193@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 13:02:56', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (267, 'Student Setup', 'Student Entry', 'Name-SK. RAKIBUL ISLAM RegistrationNo-2019-915-706 ClassRoll-ZR-100-029 ExamRoll- Email-rakibulislamsk27@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-0', 'Shahin', '2020-11-03 13:04:48', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (268, 'Student Setup', 'Student Entry', 'Name-SK. RAKIBUL ISLAM RegistrationNo-2019-915-706 ClassRoll-ZH-100-029 ExamRoll- Email-rakibulislamsk27@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 13:06:04', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (269, 'Student Setup', 'Student Entry', 'Name-MD. SHIFAT AL SHAFI RegistrationNo-2019-915-698 ClassRoll-SS-100-0021 ExamRoll- Email-shifatalshafi@Gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 13:12:33', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (270, 'Student Setup', 'Student Entry', 'Name-SAADIYA TASNEEM PRAPTY RegistrationNo-2019-115-713 ClassRoll-KM-100-0036 ExamRoll- Email-saadiyatasneem007@gmai.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 13:16:57', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (271, 'Student Setup', 'Student Entry', 'Name-MD. MUNTAKIM HOSSAIN RegistrationNo-2019-315-702 ClassRoll-MM-100-0025 ExamRoll- Email- DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 13:21:23', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (272, 'Student Setup', 'Student Entry', 'Name-SITHI ROY RegistrationNo-2019-413-686 ClassRoll-RH-100-02 ExamRoll- Email-sithiroy2019@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 13:29:54', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (273, 'Batch Setup', 'Batch Update', 'ID-4 Code-BATCH-004 Name-MSJ-16 Description-MSJ-16 StartDate-2018-01-01 EndDate-2020-12-31 ProgramID-3 SessionID-1', 'admin', '2020-11-03 13:40:22', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (274, 'Batch Setup', 'Batch Entry', 'Code-MSJ-17 Name-MSJ-17 Description-MSJ-17 Start Date-2019-01-01 End Date-2021-12-31 ProgramID-3', 'admin', '2020-11-03 13:41:09', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (275, 'Batch Setup', 'Batch Update', 'ID-4 Code-MSJ-16 Name-MSJ-16 Batch Description-MSJ-16 Batch StartDate-2018-01-01 EndDate-2020-12-31 ProgramID-3 SessionID-1', 'admin', '2020-11-03 13:41:41', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (276, 'Batch Setup', 'Batch Update', 'ID-5 Code-MSJ-17 Name-MSJ-17 Batch Description-MSJ-17 Batch StartDate-2019-01-01 EndDate-2021-12-31 ProgramID-3 SessionID-2', 'admin', '2020-11-03 13:41:53', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (277, 'Student Setup', 'Student Entry', 'Name-SITHI ROY RegistrationNo-2019-413-686 ClassRoll-RH-100-02 ExamRoll- Email-sithiroy2019@gmail.com DepartmentID-1 ProgramID-1 SessionID-2 BatchID-3 ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 13:45:16', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (278, 'Teacher Setup', 'Teacher Entry', 'EmployeeNo-1982087001 Name-DR. MD. ABUL BARKAT  ShortName-ABUL BARKAT  DesignationID-2 DepartmentID-1 Email-barkatabul71@gmail.com Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 13:53:00', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (279, 'Teacher Setup', 'Teacher Update', 'ID-3 EmployeeNo-1982087001 Name-ABUL BARKAT PhD ShortName-ABUL BARKAT  DesignationID-2 DepartmentID-1 Email-barkatabul71@gmail.com Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 13:54:09', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (280, 'Designation Setup', 'Designation Entry', 'Name-Associate Professor OfficialTitle-Associate Professor Description-Associate Professor SortingNo-2 IsActive-1', 'Shahin', '2020-11-03 14:05:24', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (281, 'Designation Setup', 'Designation Entry', 'ID-2 Name-Professor OfficialTitle-Professor Description-Professor SortingNo-1 IsActive-1', 'Shahin', '2020-11-03 14:05:45', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (282, 'Designation Setup', 'Designation Entry', 'Name-Assistant Professor  OfficialTitle-Assistant Professor Description-Assistant Professor  SortingNo-3 IsActive-1', 'Shahin', '2020-11-03 14:06:07', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (283, 'Designation Setup', 'Designation Entry', 'ID-1 Name-Lecturer OfficialTitle-Lecturer Description-Lecturer SortingNo-4 IsActive-1', 'Shahin', '2020-11-03 14:06:23', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (284, 'Designation Setup', 'Designation Entry', 'ID-3 Name-Sr. Seminer Assistant OfficialTitle-Sr. Seminer Assistant Description-Sr. Seminer Assistant SortingNo-6 IsActive-1', 'Shahin', '2020-11-03 14:06:48', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (285, 'Designation Setup', 'Designation Entry', 'Name-Senior Administrative Officer  OfficialTitle-Senior Administrative Officer Description-Senior Administrative Officer  SortingNo-5 IsActive-1', 'Shahin', '2020-11-03 14:08:08', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (286, 'Designation Setup', 'Designation Entry', 'Name-Chairman  OfficialTitle-Chairman Description-Chairman SortingNo-01 IsActive-1', 'Shahin', '2020-11-03 14:09:53', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (287, 'Teacher Setup', 'Teacher Update', 'ID-1 EmployeeNo-201328001 Name-ABDULLAH AL MAMUN  ShortName-MAMUN  DesignationID-7 DepartmentID-1 Email-mamun.djs@du.ac.bd Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:11:41', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (288, 'Teacher Setup', 'Teacher Entry', 'EmployeeNo-2013127002 Name-MD. JAHANGIR ALAM, PhD  ShortName-Jahangir Alam  DesignationID-5 DepartmentID-1 Email-rony.cdcs@gmail.com Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:14:43', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (289, 'Teacher Setup', 'Teacher Update', 'ID-4 EmployeeNo-2013127002 Name-MD. JAHANGIR ALAM, PhD  ShortName-Jahangir Alam  DesignationID-5 DepartmentID-1 Email-rony.cdcs@gmail.com Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:15:01', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (290, 'Teacher Setup', 'Teacher Update', 'ID-3 EmployeeNo-1982087001 Name-ABUL BARKAT PhD ShortName- BARKAT A DesignationID-2 DepartmentID-1 Email-barkatabul71@gmail.com Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:15:35', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (291, 'Teacher Setup', 'Teacher Entry', 'EmployeeNo-2015026002 Name-DILRUBA SHARMIN  ShortName-SHARMIN DesignationID-5 DepartmentID-1 Email-dsharmin.jsc@du.ac.bd Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:18:10', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (292, 'Teacher Setup', 'Teacher Update', 'ID-5 EmployeeNo-2015026002 Name-DILRUBA SHARMIN, PhD  ShortName-SHARMIN DesignationID-5 DepartmentID-1 Email-dsharmin.jsc@du.ac.bd Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:19:21', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (293, 'Teacher Setup', 'Teacher Entry', 'EmployeeNo-2016021009 Name-LOPAMUDRA MALEK, PhD  ShortName-LOPAMUDRA DesignationID-5 DepartmentID-1 Email-lopamudra.jsc@du.ac.bd Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:20:55', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (294, 'Teacher Setup', 'Teacher Entry', 'EmployeeNo-2016098010 Name-NASHIA ZAMAN  ShortName-NASHIA  DesignationID-5 DepartmentID-1 Email-nashiazaman@du.ac.bd Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:22:16', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (295, 'Teacher Setup', 'Teacher Entry', 'EmployeeNo-2018017026 Name-SHIBLEE NOMAN  ShortName-NOMAN  DesignationID-1 DepartmentID-1 Email-shibleenoman.djs@du.ac.bd Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:23:47', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (296, 'Teacher Setup', 'Teacher Entry', 'EmployeeNo-2018014011 Name-MD. SAIFULLAH AKON ShortName-AKON DesignationID-1 DepartmentID-1 Email-saifullah.djs@du.ac.bd Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:25:57', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (297, 'Designation Setup', 'Designation Entry', 'ID-2 Name-Professor OfficialTitle-Professor Description-Professor SortingNo-2 IsActive-1', 'Shahin', '2020-11-03 14:26:34', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (298, 'Designation Setup', 'Designation Entry', 'ID-4 Name-Associate Professor OfficialTitle-Associate Professor Description-Associate Professor SortingNo-3 IsActive-1', 'Shahin', '2020-11-03 14:26:46', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (299, 'Designation Setup', 'Designation Entry', 'ID-5 Name-Assistant Professor  OfficialTitle-Assistant Professor Description-Assistant Professor  SortingNo-4 IsActive-1', 'Shahin', '2020-11-03 14:27:07', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (300, 'Designation Setup', 'Designation Entry', 'ID-1 Name-Lecturer OfficialTitle-Lecturer Description-Lecturer SortingNo-5 IsActive-1', 'Shahin', '2020-11-03 14:27:18', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (301, 'Designation Setup', 'Designation Entry', 'ID-6 Name-Senior Administrative Officer  OfficialTitle-Senior Administrative Officer Description-Senior Administrative Officer  SortingNo-6 IsActive-1', 'Shahin', '2020-11-03 14:27:31', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (302, 'Designation Setup', 'Designation Entry', 'ID-3 Name-Sr. Seminer Assistant OfficialTitle-Sr. Seminer Assistant Description-Sr. Seminer Assistant SortingNo-7 IsActive-1', 'Shahin', '2020-11-03 14:27:42', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (303, 'Designation Setup', 'Designation Entry', 'Name-OFFICE SOHAYOK OfficialTitle-OFFICE SOHAYOK Description-OFFICE SOHAYOK SortingNo-8 IsActive-1', 'Shahin', '2020-11-03 14:28:27', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (304, 'Teacher Setup', 'Teacher Update', 'ID-4 EmployeeNo-2013127002 Name-MD. JAHANGIR ALAM, PhD  ShortName-Jahangir  DesignationID-5 DepartmentID-1 Email-rony.cdcs@gmail.com Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:29:11', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (305, 'Teacher Setup', 'Teacher Update', 'ID-3 EmployeeNo-1982087001 Name-ABUL BARKAT PhD ShortName- BARKAT  DesignationID-2 DepartmentID-1 Email-barkatabul71@gmail.com Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:29:35', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (306, 'Teacher Setup', 'Teacher Update', 'ID-1 EmployeeNo-201328001 Name-ABDULLAH AL MAMUN, PhD ShortName-MAMUN  DesignationID-7 DepartmentID-1 Email-mamun.djs@du.ac.bd Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:30:43', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (307, 'Teacher Setup', 'Teacher Update', 'ID-3 EmployeeNo-1982087001 Name-ABUL BARKAT, PhD ShortName- BARKAT  DesignationID-2 DepartmentID-1 Email-barkatabul71@gmail.com Campus-Dhaka University ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:31:11', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (308, 'Teacher Setup', 'Teacher Update', 'ID-2 EmployeeNo-01 Name-D ShortName-D DesignationID-6 DepartmentID-1 Email-sayed.dsj@du.ac.bd Campus-du ProximityCardID- IsActive-1', 'Shahin', '2020-11-03 14:34:06', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (309, 'Student Setup', 'Student Entry', 'Name-MOHAMMAD SAIFUL ISLAM RegistrationNo-H-1644 ClassRoll-ZH-001 ExamRoll- Email- DepartmentID-1 ProgramID-3 SessionID-1 BatchID-4 ProximityCardID- IsActive-1', 'Shahin', '2020-11-04 10:12:48', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (310, 'Student Setup', 'Student Entry', 'Name-MEHRAZ MORSHED RegistrationNo-H-1804 ClassRoll-ZH-009 ExamRoll- Email- DepartmentID-1 ProgramID-3 SessionID-1 BatchID-4 ProximityCardID- IsActive-1', 'Shahin', '2020-11-04 10:13:50', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (311, 'Student Setup', 'Student Entry', 'Name-SHAMSUL ALAM KHONDOKER RegistrationNo-H-1805 ClassRoll-ZH-013 ExamRoll- Email- DepartmentID-1 ProgramID-3 SessionID-1 BatchID-4 ProximityCardID- IsActive-1', 'Shahin', '2020-11-04 10:14:58', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (312, 'Student Setup', 'Student Entry', 'Name-IMTIAZ MAHMUD RegistrationNo-H-1806 ClassRoll-ZH-015 ExamRoll- Email- DepartmentID-1 ProgramID-3 SessionID-1 BatchID-4 ProximityCardID- IsActive-1', 'Shahin', '2020-11-04 10:16:08', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (313, 'Program Setup', 'Program Update', 'ID-2 Code-002 Name-Masters of Social Sciences, MSS (Masters) FormalName-Masters of Social Sciences, MSS (Masters) Description-Masters of Social Sciences, MSS (Masters) Semester No-2', 'Shahin', '2020-11-04 10:19:13', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (314, 'Program Setup', 'Program Update', 'ID-3 Code-003 Name-Masters in Japanese Studies FormalName-Masters in Japanese Studies Description-Masters in Japanese Studies Semester No-4', 'Shahin', '2020-11-04 10:19:54', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (315, 'Student Setup', 'Student Entry', 'Name-AFROZA AKTER RegistrationNo-H-797 ClassRoll-RH-016 ExamRoll- Email- DepartmentID-1 ProgramID-3 SessionID-1 BatchID-4 ProximityCardID- IsActive-1', 'Shahin', '2020-11-04 10:21:55', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (316, 'Student Setup', 'Student Entry', 'Name-MD. SANA ULLAH NOVEL RegistrationNo-H-1807 ClassRoll-ZH-017 ExamRoll- Email- DepartmentID-1 ProgramID-3 SessionID-1 BatchID-4 ProximityCardID- IsActive-1', 'Shahin', '2020-11-04 10:22:51', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (317, 'Student Setup', 'Student Entry', 'Name-MD. SHAFAYET HOSSAIN RegistrationNo-H-1822 ClassRoll-ZH-019 ExamRoll- Email- DepartmentID-1 ProgramID-3 SessionID-1 BatchID-4 ProximityCardID- IsActive-1', 'Shahin', '2020-11-04 10:24:05', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (318, 'Batch Setup', 'Batch Update', 'ID-4 Code-MSJ-16 Name-MJS-16 Batch Description-MJS-16 Batch StartDate-2018-01-01 EndDate-2020-12-31 ProgramID-3 SessionID-1', 'Shahin', '2020-11-04 10:27:41', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (319, 'Batch Setup', 'Batch Update', 'ID-5 Code-MJS-17 Name-MJS-17 Batch Description-MJS-17 Batch StartDate-2019-01-01 EndDate-2021-12-31 ProgramID-3 SessionID-2', 'Shahin', '2020-11-04 10:28:40', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (320, 'Student Setup', 'Student Entry', 'Name-MD. MOZAMMAL HOSSAIN RegistrationNo-H-1808 ClassRoll-ZH-021 ExamRoll- Email- DepartmentID-1 ProgramID-3 SessionID-1 BatchID-4 ProximityCardID- IsActive-1', 'Shahin', '2020-11-04 10:30:28', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (321, 'Student Setup', 'Student Entry', 'Name-MD. ZAFAR ALAM BHUIYAN RegistrationNo-H-1809 ClassRoll-ZH-023 ExamRoll- Email- DepartmentID-1 ProgramID-3 SessionID-2 BatchID-4 ProximityCardID- IsActive-1', 'Shahin', '2020-11-04 10:31:25', '202.86.218.1');
INSERT INTO `sec_accesslog` VALUES (322, 'Student Setup', 'Student Update', 'ID-177 Name-MD. ZAFAR ALAM BHUIYAN RegistrationNo-H-1809 ClassRoll-ZH-022 ExamRoll-  Email- DepartmentID-1 ProgramID-3 SessionID-2 BatchID-4 ProximityCardID- IsActive-1', 'Shahin', '2020-11-04 10:32:10', '202.86.218.1');

-- ----------------------------
-- Table structure for sec_menuitem
-- ----------------------------
DROP TABLE IF EXISTS `sec_menuitem`;
CREATE TABLE `sec_menuitem`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MenuName` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `PageLink` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ModuleName` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `MotherMenu` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `PageName` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `IsReport` tinyint(4) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`MenuName`) USING BTREE,
  UNIQUE INDEX `ID`(`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sec_menuitem
-- ----------------------------
INSERT INTO `sec_menuitem` VALUES (16, 'Academic', 'javascript:', 'Academic', 'Main', '', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (22, 'Academics', 'javascript:', 'Academic', 'Academic', '', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (45, 'Access Log Report', 'index.php?Adminis=AccessLog', 'Security', 'Security', 'gui/administrator/AccessLogRpt.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (27, 'Assignment', 'index.php?Aca=AS', 'Academic', 'Academics', 'gui/academic/assignment.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (38, 'Assignment Result', 'index.php?Aca=AR', 'Academic', 'Reports', '', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (7, 'Batch', 'index.php?Basic=BS', 'Configuration', 'Common Setup', 'gui/basic/batch.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (44, 'Change Password', 'index.php?Adminis=CP', 'Security', 'Security', 'gui/administrator/changepassword.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (10, 'Class  Schedules', 'javascript:', 'Configuration', 'Configuration', 'Class  Schedules', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (25, 'Class Schedule', 'index.php?Aca=CSCER', 'Academic', 'Academic', 'gui/academic/classschedulereport.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (24, 'Class Schedule Setup', 'index.php?Aca=CSC', 'Academic', 'Academic', 'gui/academic/classschedule.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (2, 'Common Setup', 'index.php?Page=Security', 'Configuration', 'Configuration', '', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (1, 'Configuration', 'javascript:', 'Configuration', 'Main', '', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (23, 'Course Assign to Teacher', 'index.php?Aca=ACT', 'Academic', 'Academic', 'gui/academic/courseassignteacher.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (26, 'Course Material', 'index.php?Aca=CM', 'Academic', 'Academics', 'gui/academic/coursematerial.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (9, 'Course Setup', 'index.php?Basic=CS', 'Configuration', 'Main', 'gui/basic/courses.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (36, 'Coursewise Result', 'index.php?Aca=CR', 'Academic', 'Reports', '', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (30, 'Create Exam', 'index.php?Aca=CE', 'Academic', 'Exams', 'gui/academic/createexam.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (41, 'Create Role', 'index.php?Adminis=CR', 'Security', 'Security', 'gui/administrator/Rolesetup.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (40, 'Create User', 'index.php?Adminis=CU', 'Security', 'Security', 'gui/administrator/usersetup.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (46, 'Data Backup', 'index.php?Adminis=Backup', 'Security', 'Security', 'gui/administrator/Backup.php', 1, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (20, 'Degisnation Entry', 'index.php?Basic=DE', 'Academic', 'Teacher', 'gui/basic/designation.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (3, 'Department', 'index.php?Basic=DP', 'Configuration', 'Common Setup', 'gui/basic/department.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (13, 'Exam', 'javascript:', 'Configuration', 'Configuration', '', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (31, 'Exam List', 'index.php?Aca=EL', 'Academic', 'Exams', 'gui/academic/examlist.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (34, 'Exam Result', 'index.php?Aca=ER', 'Academic', 'Reports', '', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (15, 'Exam Type', 'index.php?Basic=ET', 'Configuration', 'Exam', 'gui/basic/examtype.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (29, 'Exams', 'javascript:', 'Academic', 'Academic', '', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (14, 'Grade Point & Marks', 'index.php?Basic=GPM', 'Configuration', 'Exam', 'gui/basic/gradepoint.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (4, 'Hostel/Hall', 'index.php?Basic=HA', 'Configuration', 'Common Setup', 'gui/basic/hostel.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (28, 'Live Chat', 'index.php?Aca=LC', 'Academic', 'Academics', 'gui/academic/livechat.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (5, 'Program', 'index.php?Basic=PS', 'Configuration', 'Common Setup', 'gui/basic/program.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (33, 'Reports', 'javascript:', 'Academic', 'Academic', '', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (42, 'Role Permission', 'index.php?Adminis=RP', 'Security', 'Security', 'gui/administrator/Rolepermission.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (12, 'Room Setup', 'index.php?Basic=RS', 'Configuration', 'Class  Schedules', 'gui/basic/room.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (39, 'Security', 'javascript:', 'Security', 'Main', 'g', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (8, 'Semester', 'index.php?Basic=SEM', 'Configuration', 'Common Setup', 'gui/basic/semester.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (37, 'Semester Final Result', 'index.php?Aca=SFR', 'Academic', 'Reports', '', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (35, 'Semesterwise Result', 'index.php?Aca=SRes', 'Academic', 'Reports', '', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (6, 'Session', 'index.php?Basic=SS', 'Configuration', 'Common Setup', 'gui/basic/session.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (17, 'Student', 'javascript:', 'Academic', 'Academic', '', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (18, 'Student Entry', 'index.php?Aca=SE', 'Academic', 'Student', 'gui/academic/student.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (32, 'Surveillance/Result', 'index.php?Aca=SR', 'Academic', 'Exams', 'gui/academic/examresult.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (19, 'Teacher', 'javascript:', 'Academic', 'Academic', '', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (21, 'Teacher Entry', 'index.php?Aca=TE', 'Academic', 'Teacher', 'gui/academic/teacher.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (11, 'Time Slot', 'index.php?Basic=TS', 'Configuration', 'Class  Schedules', 'gui/basic/timeslot.php', 0, 'admin', '2020-10-01 00:00:00');
INSERT INTO `sec_menuitem` VALUES (43, 'User To Role Mapping', 'index.php?Adminis=URM', 'Security', 'Security', 'gui/administrator/usertorolemap.php', 0, 'admin', '2020-10-01 00:00:00');

-- ----------------------------
-- Table structure for sec_role
-- ----------------------------
DROP TABLE IF EXISTS `sec_role`;
CREATE TABLE `sec_role`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`Name`) USING BTREE,
  UNIQUE INDEX `ID`(`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sec_role
-- ----------------------------
INSERT INTO `sec_role` VALUES (3, 'Academic Course All Course', 1, 'admin', '2020-10-24 11:17:30', '', '0000-00-00 00:00:00');
INSERT INTO `sec_role` VALUES (2, 'Academic Course Own Course', 1, 'admin', '2020-10-24 11:17:20', '', '0000-00-00 00:00:00');
INSERT INTO `sec_role` VALUES (1, 'Administrator', 1, 'admin', '2020-10-14 10:56:14', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for sec_rolepermission
-- ----------------------------
DROP TABLE IF EXISTS `sec_rolepermission`;
CREATE TABLE `sec_rolepermission`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RoleID` int(11) NOT NULL,
  `MenuID` int(11) NOT NULL,
  `IsAction` tinyint(4) NOT NULL,
  `IsInsert` tinyint(4) NOT NULL,
  `IsUpdate` tinyint(4) NOT NULL,
  `IsDelete` tinyint(4) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`RoleID`, `MenuID`) USING BTREE,
  UNIQUE INDEX `ID`(`ID`) USING BTREE,
  INDEX `fk_sec_rolepermission_sec_menuitem`(`MenuID`) USING BTREE,
  CONSTRAINT `fk_sec_rolepermission_sec_menuitem` FOREIGN KEY (`MenuID`) REFERENCES `sec_menuitem` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_sec_rolepermission_sec_role` FOREIGN KEY (`RoleID`) REFERENCES `sec_role` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sec_rolepermission
-- ----------------------------
INSERT INTO `sec_rolepermission` VALUES (4, 1, 1, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (3, 1, 2, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (6, 1, 3, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (10, 1, 4, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (11, 1, 5, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (14, 1, 6, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (1, 1, 7, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (13, 1, 8, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (5, 1, 9, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (2, 1, 10, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (15, 1, 11, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (12, 1, 12, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (7, 1, 13, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (9, 1, 14, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (8, 1, 15, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (16, 1, 16, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (34, 1, 17, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (35, 1, 18, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (37, 1, 19, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (26, 1, 20, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (38, 1, 21, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (17, 1, 22, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (22, 1, 23, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (21, 1, 24, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (20, 1, 25, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (23, 1, 26, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (18, 1, 27, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (30, 1, 28, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (29, 1, 29, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (25, 1, 30, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (27, 1, 31, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (36, 1, 32, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (31, 1, 33, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (28, 1, 34, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (33, 1, 35, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (24, 1, 36, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (32, 1, 37, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (19, 1, 38, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (44, 1, 39, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (42, 1, 40, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (41, 1, 41, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (43, 1, 42, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (45, 1, 43, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (40, 1, 44, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');
INSERT INTO `sec_rolepermission` VALUES (39, 1, 45, 1, 1, 1, 1, 'admin', '2020-10-31 08:35:40');

-- ----------------------------
-- Table structure for sec_user
-- ----------------------------
DROP TABLE IF EXISTS `sec_user`;
CREATE TABLE `sec_user`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `EmployeeID` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UserType` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `LeaveApprovalLevel` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  `UpdateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `UpdateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE,
  UNIQUE INDEX `ID`(`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sec_user
-- ----------------------------
INSERT INTO `sec_user` VALUES (1, 'admin', '$2y$10$MUF5pmw6eFCJ1D1V.QBeY.ySZ5D.uP2ZNXvFv0l901p4WpnIMp5Da', '0001', 'Admin', '', 1, 'admin', '2020-10-03 09:51:21', '', '0000-00-00 00:00:00');
INSERT INTO `sec_user` VALUES (2, 'rahim', 'e10adc3949ba59abbe56e057f20f883e', '0001', '001', 'Basic', 1, 'admin', '2020-10-14 10:56:02', '', '0000-00-00 00:00:00');
INSERT INTO `sec_user` VALUES (3, 'Shahin', 'f454011ac41efa02f169da85fdd2b9b5', '2016077039', 'Sr. Seminer Assistant', 'Basic', 1, 'admin', '2020-10-28 14:57:51', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for sec_userrole
-- ----------------------------
DROP TABLE IF EXISTS `sec_userrole`;
CREATE TABLE `sec_userrole`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `RoleID` int(11) NOT NULL,
  `CreateBy` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `CreateDate` datetime(0) NOT NULL,
  PRIMARY KEY (`UserName`, `RoleID`) USING BTREE,
  UNIQUE INDEX `ID`(`ID`) USING BTREE,
  INDEX `fk_sec_userrole_sec_role`(`RoleID`) USING BTREE,
  CONSTRAINT `fk_sec_userrole_sec_role` FOREIGN KEY (`RoleID`) REFERENCES `sec_role` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_sec_userrole_sec_user` FOREIGN KEY (`UserName`) REFERENCES `sec_user` (`UserName`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sec_userrole
-- ----------------------------
INSERT INTO `sec_userrole` VALUES (2, 'Shahin', 1, 'admin', '2020-10-28 14:58:11');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sec_user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ifbk_sec_user_id`(`sec_user_id`) USING BTREE,
  CONSTRAINT `ifbk_sec_user_id` FOREIGN KEY (`sec_user_id`) REFERENCES `sec_user` (`ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'hasan', '$2y$10$mlrijAdu8HUgJWuXINhBaeDWK0PZb1s2NYEiB0.ydm9SuF43bzwVK', 1);

-- ----------------------------
-- View structure for v_alluser
-- ----------------------------
DROP VIEW IF EXISTS `v_alluser`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `v_alluser` AS select `aca_stu_basic`.`ClassRoll` AS `memberNo`,`aca_stu_basic`.`Name` AS `Name`,'Student' AS `TYPE` from `aca_stu_basic` where `aca_stu_basic`.`IsActive` = 1 union all select `hrm_employee`.`EmployeeNo` AS `memberNo`,`hrm_employee`.`Name` AS `Name`,`hrm_designation`.`Name` AS `TYPE` from (`hrm_employee` join `hrm_designation` on(`hrm_employee`.`DesignationID` = `hrm_designation`.`ID`)) where `hrm_employee`.`IsActive` = '1' ;

SET FOREIGN_KEY_CHECKS = 1;
