-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 29-11-2024 a las 21:13:32
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `getty_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `antecedente_dentals`
--

CREATE TABLE `antecedente_dentals` (
  `id` bigint UNSIGNED NOT NULL,
  `paciente_id` bigint UNSIGNED NOT NULL,
  `lesiones_cara` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ch_pulgar_pasado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ch_dedo_actual` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `respiracion_bucal` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `muerde_unia` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `desgaste_dientes` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `falta_permanente` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `falta_alguno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `falta_alguno_d` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `problema_cabeza` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `examinado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `examinado_d` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aparatos` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aparatos_d` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `antecedente_dentals`
--

INSERT INTO `antecedente_dentals` (`id`, `paciente_id`, `lesiones_cara`, `ch_pulgar_pasado`, `ch_dedo_actual`, `respiracion_bucal`, `muerde_unia`, `desgaste_dientes`, `falta_permanente`, `falta_alguno`, `falta_alguno_d`, `problema_cabeza`, `examinado`, `examinado_d`, `aparatos`, `aparatos_d`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 'NO', 'NO', 'NO', 'NO', 'NO', 'NO', 'NO', 'NO', '', 'NO', 'NO', '', 'NO', '', '2024-11-26', '2024-11-27 00:31:01', '2024-11-27 00:31:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `razon_social` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ciudad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `web` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `alias`, `razon_social`, `ciudad`, `dir`, `fono`, `correo`, `web`, `actividad`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'GETTY', 'GT', 'GETTY S.A.', 'LA PAZ', 'ZONA LOS OLIVOS', '77777777', 'GETTY@GMAIL.COM', 'GETTY.COM', 'ACTIVIDAD', '1725897866_1.jpg', NULL, '2024-11-27 02:56:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultas`
--

CREATE TABLE `consultas` (
  `id` bigint UNSIGNED NOT NULL,
  `paciente_id` bigint UNSIGNED NOT NULL,
  `general_id` bigint UNSIGNED NOT NULL,
  `especialista_id` bigint UNSIGNED NOT NULL,
  `motivo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `consultas`
--

INSERT INTO `consultas` (`id`, `paciente_id`, `general_id`, `especialista_id`, `motivo`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 3, 'MOTIVO CONSULTA', '2024-11-29 22:36:54', '2024-11-29 22:36:54'),
(2, 1, 2, 4, 'CONSULTA 2', '2024-11-29 22:38:58', '2024-11-29 22:38:58'),
(3, 2, 7, 6, 'CONSULTA 1', '2024-11-29 22:39:09', '2024-11-29 22:39:09'),
(4, 3, 2, 3, 'CONSULTA 1', '2024-11-29 22:42:04', '2024-11-29 22:42:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examen_clinicos`
--

CREATE TABLE `examen_clinicos` (
  `id` bigint UNSIGNED NOT NULL,
  `cod` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nro` bigint UNSIGNED NOT NULL,
  `paciente_id` bigint UNSIGNED NOT NULL,
  `simetria_facial` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `diccion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `patron_facial` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `respiracion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `perfil` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `relacion_labial` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `labios` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `maxilar_superior` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deglucion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lengua_deglucion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `habito_bucal` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `denticion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `overjet` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `higiene_bucal` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `salud_dental` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `relacion_molar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `relacion_canina` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amigdalas` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mordida_cruzada` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `linea_sup` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `linea_sup_mm` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linea_inf` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `linea_inf_mm` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacion` text COLLATE utf8mb4_unicode_ci,
  `modelo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `examen_clinicos`
--

INSERT INTO `examen_clinicos` (`id`, `cod`, `nro`, `paciente_id`, `simetria_facial`, `diccion`, `patron_facial`, `respiracion`, `perfil`, `relacion_labial`, `labios`, `maxilar_superior`, `deglucion`, `lengua_deglucion`, `habito_bucal`, `denticion`, `overjet`, `higiene_bucal`, `salud_dental`, `relacion_molar`, `relacion_canina`, `amigdalas`, `mordida_cruzada`, `linea_sup`, `linea_sup_mm`, `linea_inf`, `linea_inf_mm`, `observacion`, `modelo`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'EC.1', 1, 1, 'SIMETRIA', 'NORMAL', 'MESOCEFALO', 'NASAL', 'RECTO', 'NORMAL', 'NORMALES', 'CLASE I', 'NORMAL', 'NORMAL', 'SUCCIÓN DE DEDOS', 'DECIDUA', 'NORMAL', 'MALA', 'MALA', 'CLASE I', 'CLASE I', 'NORMALES', 'DIENTE ANTERIOR', 'COINCIDE LINEA MEDIA FACIAL', '', 'COINCIDE LINEA MEDIA FACIAL', '', 'OBSERVACION EXAMEN DENTAL', '1732395997.obj', '2024-11-23', '2024-11-24 01:06:45', '2024-11-27 02:22:51'),
(2, 'EC.2', 2, 2, 'SIMETRIA', 'NORMAL', 'MESOCEFALO', 'NASAL', 'RECTO', 'NORMAL', 'NORMALES', 'CLASE I', 'NORMAL', 'NORMAL', 'SUCCIÓN DE DEDOS', 'DECIDUA', 'NORMAL', 'MALA', 'MALA', 'CLASE I', 'CLASE I', 'NORMALES', 'DIENTE ANTERIOR', 'COINCIDE LINEA MEDIA FACIAL', '', 'COINCIDE LINEA MEDIA FACIAL', '', '', '1732907203.OBJ', '2024-11-29', '2024-11-29 23:06:57', '2024-11-29 23:06:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examen_imagens`
--

CREATE TABLE `examen_imagens` (
  `id` bigint UNSIGNED NOT NULL,
  `examen_clinico_id` bigint UNSIGNED NOT NULL,
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ext` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `examen_imagens`
--

INSERT INTO `examen_imagens` (`id`, `examen_clinico_id`, `imagen`, `ext`, `created_at`, `updated_at`) VALUES
(10, 1, '01732396005.png', 'png', '2024-11-24 01:06:45', '2024-11-24 01:06:45'),
(11, 1, '11732396005.png', 'png', '2024-11-24 01:06:45', '2024-11-24 01:06:45'),
(12, 1, '21732396005.png', 'png', '2024-11-24 01:06:45', '2024-11-24 01:06:45'),
(13, 2, '01732907217.png', 'png', '2024-11-29 23:06:57', '2024-11-29 23:06:57'),
(14, 2, '11732907217.png', 'png', '2024-11-29 23:06:57', '2024-11-29 23:06:57'),
(15, 2, '21732907217.png', 'png', '2024-11-29 23:06:57', '2024-11-29 23:06:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` text COLLATE utf8mb4_unicode_ci,
  `datos_nuevo` text COLLATE utf8mb4_unicode_ci,
  `modulo` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>password: $2y$12$ZEclJTz5qo7TFBFtp8ehwuaIDE.g0VYqOlLl4aJSFvNoCL0JFYS7O<br/>tipo: DOCTOR GENERAL<br/>foto: 1731963984_JPERES.jpg<br/>fecha_registro: 2024-11-18<br/>acceso: 1<br/>created_at: 2024-11-18 21:06:24<br/>updated_at: 2024-11-18 21:06:24<br/>', NULL, 'USUARIOS', '2024-11-18', '21:06:24', '2024-11-19 01:06:24', '2024-11-19 01:06:24'),
(2, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PACIENTE', 'id: 1<br/>usuario: <br/>nombre: RAMIRO<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 123456<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 676767676<br/>password: <br/>tipo: <br/>foto: 1731972418_.jpg<br/>fecha_registro: <br/>acceso: <br/>created_at: 2024-11-18 23:26:58<br/>updated_at: 2024-11-18 23:26:58<br/>', NULL, 'PACIENTES', '2024-11-18', '23:26:58', '2024-11-19 03:26:58', '2024-11-19 03:26:58'),
(3, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PACIENTE', 'id: 1<br/>usuario: <br/>nombre: RAMIRO<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 123456<br/>ci_exp: LP<br/>dir: <br/>email: <br/>fono: 676767676<br/>password: <br/>tipo: <br/>foto: 1731972418_.jpg<br/>fecha_registro: <br/>acceso: <br/>created_at: 2024-11-18 23:26:58<br/>updated_at: 2024-11-18 23:26:58<br/>', 'id: 1<br/>usuario: <br/>nombre: RAMIRO<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 123456<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: <br/>fono: 676767676<br/>password: <br/>tipo: <br/>foto: 1731972418_.jpg<br/>fecha_registro: <br/>acceso: <br/>created_at: 2024-11-18 23:26:58<br/>updated_at: 2024-11-18 23:28:29<br/>', 'PACIENTES', '2024-11-18', '23:28:29', '2024-11-19 03:28:29', '2024-11-19 03:28:29'),
(4, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PACIENTE', 'id: 2<br/>usuario: <br/>nombre: MARIA<br/>paterno: GONZALES<br/>materno: <br/>ci: <br/>ci_exp: <br/>dir: ZONA LOS PEDREGALES<br/>email: <br/>fono: <br/>password: <br/>tipo: <br/>foto: <br/>fecha_registro: <br/>acceso: <br/>created_at: 2024-11-18 23:28:59<br/>updated_at: 2024-11-18 23:28:59<br/>', NULL, 'PACIENTES', '2024-11-18', '23:28:59', '2024-11-19 03:28:59', '2024-11-19 03:28:59'),
(5, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN PACIENTE', 'id: 2<br/>usuario: <br/>nombre: MARIA<br/>paterno: GONZALES<br/>materno: <br/>ci: <br/>ci_exp: <br/>dir: ZONA LOS PEDREGALES<br/>email: <br/>fono: <br/>password: <br/>tipo: <br/>foto: <br/>fecha_registro: <br/>acceso: <br/>created_at: 2024-11-18 23:28:59<br/>updated_at: 2024-11-18 23:28:59<br/>', NULL, 'PACIENTES', '2024-11-18', '23:29:37', '2024-11-19 03:29:37', '2024-11-19 03:29:37'),
(6, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PACIENTE', 'id: 2<br/>usuario: <br/>nombre: MARIA<br/>paterno: GONZALES<br/>materno: <br/>ci: <br/>ci_exp: <br/>dir: <br/>email: <br/>fono: <br/>password: <br/>tipo: <br/>foto: <br/>fecha_registro: <br/>acceso: <br/>created_at: 2024-11-18 23:30:02<br/>updated_at: 2024-11-18 23:30:02<br/>', NULL, 'PACIENTES', '2024-11-18', '23:30:02', '2024-11-19 03:30:02', '2024-11-19 03:30:02'),
(7, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN EXAMEN CLÍNICO', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732394116.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 20:39:51<br/>updated_at: 2024-11-23 20:39:51<br/>', NULL, 'EXAMEN CLÍNICO', '2024-11-23', '20:39:51', '2024-11-24 00:39:51', '2024-11-24 00:39:51'),
(8, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN EXAMEN CLÍNICO', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732394116.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 20:39:51<br/>updated_at: 2024-11-23 20:39:51<br/>', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395088.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 20:39:51<br/>updated_at: 2024-11-23 20:51:38<br/>', 'EXAMEN CLÍNICO', '2024-11-23', '20:51:38', '2024-11-24 00:51:38', '2024-11-24 00:51:38'),
(9, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN EXAMEN CLÍNICO', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395088.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 20:39:51<br/>updated_at: 2024-11-23 20:51:38<br/>', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395088.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 20:39:51<br/>updated_at: 2024-11-23 20:51:38<br/>', 'EXAMEN CLÍNICO', '2024-11-23', '21:02:17', '2024-11-24 01:02:17', '2024-11-24 01:02:17'),
(10, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN EXAMEN CLÍNICO', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395088.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 20:39:51<br/>updated_at: 2024-11-23 20:51:38<br/>', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395754.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 20:39:51<br/>updated_at: 2024-11-23 21:02:41<br/>', 'EXAMEN CLÍNICO', '2024-11-23', '21:02:41', '2024-11-24 01:02:41', '2024-11-24 01:02:41'),
(11, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN EXAMEN CLÍNICO', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395754.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 20:39:51<br/>updated_at: 2024-11-23 21:02:41<br/>', NULL, 'EXAMEN CLÍNICO', '2024-11-23', '21:04:49', '2024-11-24 01:04:49', '2024-11-24 01:04:49'),
(12, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN EXAMEN CLÍNICO', 'id: 2<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395904.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 21:05:14<br/>updated_at: 2024-11-23 21:05:14<br/>', NULL, 'EXAMEN CLÍNICO', '2024-11-23', '21:05:14', '2024-11-24 01:05:14', '2024-11-24 01:05:14'),
(13, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN EXAMEN CLÍNICO', 'id: 2<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395904.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 21:05:14<br/>updated_at: 2024-11-23 21:05:14<br/>', 'id: 2<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395927.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 21:05:14<br/>updated_at: 2024-11-23 21:05:44<br/>', 'EXAMEN CLÍNICO', '2024-11-23', '21:05:44', '2024-11-24 01:05:44', '2024-11-24 01:05:44'),
(14, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN EXAMEN CLÍNICO', 'id: 2<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395927.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 21:05:14<br/>updated_at: 2024-11-23 21:05:44<br/>', NULL, 'EXAMEN CLÍNICO', '2024-11-23', '21:05:50', '2024-11-24 01:05:50', '2024-11-24 01:05:50'),
(15, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN EXAMEN CLÍNICO', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: <br/>linea_sup_mm: <br/>linea_inf: <br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395997.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 21:06:45<br/>updated_at: 2024-11-23 21:06:45<br/>', NULL, 'EXAMEN CLÍNICO', '2024-11-23', '21:06:45', '2024-11-24 01:06:45', '2024-11-24 01:06:45'),
(16, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN ANTECEDENTE DENTAL', 'id: 1<br/>paciente_id: 1<br/>lesiones_cara: NO<br/>ch_pulgar_pasado: NO<br/>ch_dedo_actual: NO<br/>respiracion_bucal: NO<br/>muerde_unia: NO<br/>desgaste_dientes: NO<br/>falta_permanente: NO<br/>falta_alguno: NO<br/>falta_alguno_d: <br/>problema_cabeza: NO<br/>examinado: NO<br/>examinado_d: <br/>aparatos: NO<br/>aparatos_d: <br/>fecha_registro: 2024-11-26<br/>created_at: 2024-11-26 20:31:01<br/>updated_at: 2024-11-26 20:31:01<br/>', NULL, 'ANTECEDENTE DENTAL', '2024-11-26', '20:31:02', '2024-11-27 00:31:02', '2024-11-27 00:31:02'),
(17, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN EXAMEN CLÍNICO', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: <br/>linea_sup_mm: <br/>linea_inf: <br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395997.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 21:06:45<br/>updated_at: 2024-11-23 21:06:45<br/>', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395997.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 21:06:45<br/>updated_at: 2024-11-26 21:01:35<br/>', 'EXAMEN CLÍNICO', '2024-11-26', '21:01:35', '2024-11-27 01:01:35', '2024-11-27 01:01:35'),
(18, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN EXAMEN CLÍNICO', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: <br/>linea_sup_mm: <br/>linea_inf: <br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395997.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 21:06:45<br/>updated_at: 2024-11-23 21:06:45<br/>', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395997.OBJ<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 21:06:45<br/>updated_at: 2024-11-26 21:01:35<br/>', 'EXAMEN CLÍNICO', '2024-11-26', '21:01:35', '2024-11-27 01:01:35', '2024-11-27 01:01:35'),
(19, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN EXAMEN CLÍNICO', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395997.obj<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 21:06:45<br/>updated_at: 2024-11-26 21:01:35<br/>', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395997.obj<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 21:06:45<br/>updated_at: 2024-11-26 21:25:36<br/>', 'EXAMEN CLÍNICO', '2024-11-26', '21:25:36', '2024-11-27 01:25:36', '2024-11-27 01:25:36'),
(20, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN EXAMEN CLÍNICO', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732395997.obj<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 21:06:45<br/>updated_at: 2024-11-26 21:25:36<br/>', 'id: 1<br/>cod: EC.1<br/>nro: 1<br/>paciente_id: 1<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: OBSERVACION EXAMEN DENTAL<br/>modelo: 1732395997.obj<br/>fecha_registro: 2024-11-23<br/>created_at: 2024-11-23 21:06:45<br/>updated_at: 2024-11-26 22:22:51<br/>', 'EXAMEN CLÍNICO', '2024-11-26', '22:22:51', '2024-11-27 02:22:51', '2024-11-27 02:22:51'),
(21, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN USUARIO', 'id: 3<br/>usuario: MPAREDES<br/>nombre: MARCO<br/>paterno: PAREDES<br/>materno: <br/>ci: 2222<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: MARCO@GMAIL.COM<br/>fono: 66666777<br/>password: $2y$12$eo5QP1TuX5LdxqNXEnf7ue8bLFxFZ/xu4TAc0.p1qkEgwBjn.nPJq<br/>tipo: DOCTOR ESPECIALISTA<br/>foto: 1732661918_MPAREDES.jpg<br/>fecha_registro: 2024-11-26<br/>acceso: 1<br/>created_at: 2024-11-26 22:58:38<br/>updated_at: 2024-11-26 22:58:38<br/>', NULL, 'USUARIOS', '2024-11-26', '22:58:38', '2024-11-27 02:58:38', '2024-11-27 02:58:38'),
(22, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PACIENTE', 'id: 2<br/>nombre: MARIA<br/>paterno: GONZALES<br/>materno: <br/>ci: <br/>ci_exp: <br/>fecha_nac: 2014-01-01<br/>dir: <br/>fono: <br/>foto: <br/>nombre_proge: JUAN GONZALES<br/>senior: <br/>dir_s: <br/>fono_dom_s: <br/>fono_trab_s: <br/>cel_s: <br/>fax_s: <br/>correo_s: <br/>agradecer: <br/>nom_edad_hmnos: <br/>user_id: 1<br/>fecha_registro: 2024-11-18<br/>created_at: 2024-11-18 23:30:02<br/>updated_at: 2024-11-18 23:30:02<br/>', 'id: 2<br/>nombre: MARIA<br/>paterno: GONZALES<br/>materno: <br/>ci: <br/>ci_exp: <br/>fecha_nac: 2014-01-01<br/>dir: <br/>fono: <br/>foto: <br/>nombre_proge: JUAN GONZALES<br/>senior: <br/>dir_s: <br/>fono_dom_s: <br/>fono_trab_s: <br/>cel_s: <br/>fax_s: <br/>correo_s: <br/>agradecer: <br/>nom_edad_hmnos: <br/>user_id: 1<br/>fecha_registro: 2024-11-18<br/>created_at: 2024-11-18 23:30:02<br/>updated_at: 2024-11-18 23:30:02<br/>', 'PACIENTES', '2024-11-29', '18:05:46', '2024-11-29 22:05:46', '2024-11-29 22:05:46'),
(23, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PACIENTE', 'id: 2<br/>nombre: MARIA<br/>paterno: GONZALES<br/>materno: <br/>ci: <br/>ci_exp: <br/>fecha_nac: 2014-01-01<br/>dir: <br/>fono: <br/>foto: <br/>nombre_proge: JUAN GONZALES<br/>senior: <br/>dir_s: <br/>fono_dom_s: <br/>fono_trab_s: <br/>cel_s: <br/>fax_s: <br/>correo_s: <br/>agradecer: <br/>nom_edad_hmnos: <br/>user_id: 1<br/>fecha_registro: 2024-11-18<br/>created_at: 2024-11-18 23:30:02<br/>updated_at: 2024-11-18 23:30:02<br/>', 'id: 2<br/>nombre: MARIA<br/>paterno: GONZALES<br/>materno: <br/>ci: <br/>ci_exp: <br/>fecha_nac: 2014-01-01<br/>dir: <br/>fono: <br/>foto: <br/>nombre_proge: JUAN GONZALES<br/>senior: <br/>dir_s: <br/>fono_dom_s: <br/>fono_trab_s: <br/>cel_s: <br/>fax_s: <br/>correo_s: <br/>agradecer: <br/>nom_edad_hmnos: <br/>user_id: 1<br/>fecha_registro: 2024-11-18<br/>created_at: 2024-11-18 23:30:02<br/>updated_at: 2024-11-18 23:30:02<br/>', 'PACIENTES', '2024-11-29', '18:05:51', '2024-11-29 22:05:51', '2024-11-29 22:05:51'),
(24, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PACIENTE', 'id: 2<br/>nombre: MARIA<br/>paterno: GONZALES<br/>materno: <br/>ci: <br/>ci_exp: <br/>fecha_nac: 2014-01-01<br/>dir: <br/>fono: <br/>foto: <br/>nombre_proge: JUAN GONZALES<br/>senior: <br/>dir_s: <br/>fono_dom_s: <br/>fono_trab_s: <br/>cel_s: <br/>fax_s: <br/>correo_s: <br/>agradecer: <br/>nom_edad_hmnos: <br/>user_id: 1<br/>fecha_registro: 2024-11-18<br/>created_at: 2024-11-18 23:30:02<br/>updated_at: 2024-11-18 23:30:02<br/>', 'id: 2<br/>nombre: MARIA<br/>paterno: GONZALES<br/>materno: <br/>ci: <br/>ci_exp: <br/>fecha_nac: 2014-01-01<br/>dir: <br/>fono: <br/>foto: 17329035732.jpg<br/>nombre_proge: JUAN GONZALES<br/>senior: <br/>dir_s: <br/>fono_dom_s: <br/>fono_trab_s: <br/>cel_s: <br/>fax_s: <br/>correo_s: <br/>agradecer: <br/>nom_edad_hmnos: <br/>user_id: 1<br/>fecha_registro: 2024-11-18<br/>created_at: 2024-11-18 23:30:02<br/>updated_at: 2024-11-29 18:06:13<br/>', 'PACIENTES', '2024-11-29', '18:06:13', '2024-11-29 22:06:13', '2024-11-29 22:06:13'),
(25, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PACIENTE', 'id: 1<br/>nombre: RAMIRO<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 123456<br/>ci_exp: LP<br/>fecha_nac: 2000-01-01<br/>dir: ZONA LOS OLIVOS<br/>fono: 676767676<br/>foto: 1731972418_.jpg<br/>nombre_proge: <br/>senior: RAMIRO MAMANI<br/>dir_s: ZONA LOS PEDREGALES<br/>fono_dom_s: 222277<br/>fono_trab_s: 277777<br/>cel_s: 766666666<br/>fax_s: FAX<br/>correo_s: RAMIRO@GMAIL.COM<br/>agradecer: JUAN PERES<br/>nom_edad_hmnos: PEDRO MAMANI 20, CARLOS MAMANI 15<br/>user_id: 1<br/>fecha_registro: 2024-11-18<br/>created_at: 2024-11-18 23:26:58<br/>updated_at: 2024-11-18 23:28:29<br/>', 'id: 1<br/>nombre: RAMIRO<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 123456<br/>ci_exp: LP<br/>fecha_nac: 2000-01-01<br/>dir: ZONA LOS OLIVOS<br/>fono: 676767676<br/>foto: 17329036281.jpg<br/>nombre_proge: <br/>senior: RAMIRO MAMANI<br/>dir_s: ZONA LOS PEDREGALES<br/>fono_dom_s: 222277<br/>fono_trab_s: 277777<br/>cel_s: 766666666<br/>fax_s: FAX<br/>correo_s: RAMIRO@GMAIL.COM<br/>agradecer: JUAN PERES<br/>nom_edad_hmnos: PEDRO MAMANI 20, CARLOS MAMANI 15<br/>user_id: 1<br/>fecha_registro: 2024-11-18<br/>created_at: 2024-11-18 23:26:58<br/>updated_at: 2024-11-29 18:07:08<br/>', 'PACIENTES', '2024-11-29', '18:07:08', '2024-11-29 22:07:08', '2024-11-29 22:07:08'),
(26, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PACIENTE', 'id: 1<br/>nombre: RAMIRO<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 123456<br/>ci_exp: LP<br/>fecha_nac: 2000-01-01<br/>dir: ZONA LOS OLIVOS<br/>fono: 676767676<br/>foto: 17329036281.jpg<br/>nombre_proge: <br/>senior: RAMIRO MAMANI<br/>dir_s: ZONA LOS PEDREGALES<br/>fono_dom_s: 222277<br/>fono_trab_s: 277777<br/>cel_s: 766666666<br/>fax_s: FAX<br/>correo_s: RAMIRO@GMAIL.COM<br/>agradecer: JUAN PERES<br/>nom_edad_hmnos: PEDRO MAMANI 20, CARLOS MAMANI 15<br/>user_id: 1<br/>fecha_registro: 2024-11-18<br/>created_at: 2024-11-18 23:26:58<br/>updated_at: 2024-11-29 18:07:08<br/>', 'id: 1<br/>nombre: RAMIRO<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 123456<br/>ci_exp: LP<br/>fecha_nac: 2000-01-01<br/>dir: ZONA LOS OLIVOS<br/>fono: 676767676<br/>foto: 17329036281.jpg<br/>nombre_proge: <br/>senior: RAMIRO MAMANI<br/>dir_s: ZONA LOS PEDREGALES<br/>fono_dom_s: 222277<br/>fono_trab_s: 277777<br/>cel_s: 766666666<br/>fax_s: FAX<br/>correo_s: RAMIRO@GMAIL.COM<br/>agradecer: JUAN PERES<br/>nom_edad_hmnos: PEDRO MAMANI 20, CARLOS MAMANI 15<br/>user_id: 1<br/>fecha_registro: 2024-11-18<br/>created_at: 2024-11-18 23:26:58<br/>updated_at: 2024-11-29 18:07:08<br/>', 'PACIENTES', '2024-11-29', '18:36:54', '2024-11-29 22:36:54', '2024-11-29 22:36:54'),
(27, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 4<br/>usuario: MPAREDES1<br/>nombre: MARY<br/>paterno: PAREDES<br/>materno: GONZALES<br/>ci: 3333<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 76676767<br/>password: $2y$12$BXxQ9EXfxvETcOehLU1wreaZrCNBioE7t3jLYM7ToQ4RAK1bNT5R2<br/>tipo: DOCTOR ESPECIALISTA<br/>foto: 1732905444_MPAREDES1.jpg<br/>fecha_registro: 2024-11-29<br/>acceso: 0<br/>created_at: 2024-11-29 18:37:24<br/>updated_at: 2024-11-29 18:37:24<br/>', NULL, 'USUARIOS', '2024-11-29', '18:37:24', '2024-11-29 22:37:24', '2024-11-29 22:37:24'),
(28, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 4<br/>usuario: MPAREDES1<br/>nombre: MARY<br/>paterno: PAREDES<br/>materno: GONZALES<br/>ci: 3333<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 76676767<br/>password: $2y$12$BXxQ9EXfxvETcOehLU1wreaZrCNBioE7t3jLYM7ToQ4RAK1bNT5R2<br/>tipo: DOCTOR ESPECIALISTA<br/>foto: 1732905444_MPAREDES1.jpg<br/>fecha_registro: 2024-11-29<br/>acceso: 0<br/>created_at: 2024-11-29 18:37:24<br/>updated_at: 2024-11-29 18:37:24<br/>', 'id: 4<br/>usuario: MPAREDES1<br/>nombre: MARY<br/>paterno: PAREDES<br/>materno: GONZALES<br/>ci: 3333<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 76676767<br/>password: $2y$12$BXxQ9EXfxvETcOehLU1wreaZrCNBioE7t3jLYM7ToQ4RAK1bNT5R2<br/>tipo: DOCTOR ESPECIALISTA<br/>foto: 1732905449_MPAREDES1.jpg<br/>fecha_registro: 2024-11-29<br/>acceso: 0<br/>created_at: 2024-11-29 18:37:24<br/>updated_at: 2024-11-29 18:37:29<br/>', 'USUARIOS', '2024-11-29', '18:37:29', '2024-11-29 22:37:29', '2024-11-29 22:37:29'),
(29, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 5<br/>usuario: CRAMIRES<br/>nombre: CARMEN<br/>paterno: RAMIRES<br/>materno: RAMIRES<br/>ci: 4444<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 65656555<br/>password: $2y$12$1k7h9qoo0jGWtjv82swhpO8eM5Zydg0891Y3Am6274jj.ZEaEexwq<br/>tipo: DOCTOR ESPECIALISTA<br/>foto: <br/>fecha_registro: 2024-11-29<br/>acceso: 0<br/>created_at: 2024-11-29 18:37:44<br/>updated_at: 2024-11-29 18:37:44<br/>', NULL, 'USUARIOS', '2024-11-29', '18:37:44', '2024-11-29 22:37:44', '2024-11-29 22:37:44'),
(30, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 6<br/>usuario: FGONZALES<br/>nombre: FABRICIO<br/>paterno: GONZALES<br/>materno: CARASCO<br/>ci: 5555<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6556556<br/>password: $2y$12$urXIMYoyLaAnqShKFsPikeaHEmqCzw02.iCkjTKEjd280QFMAdqVy<br/>tipo: DOCTOR ESPECIALISTA<br/>foto: <br/>fecha_registro: 2024-11-29<br/>acceso: 0<br/>created_at: 2024-11-29 18:38:02<br/>updated_at: 2024-11-29 18:38:02<br/>', NULL, 'USUARIOS', '2024-11-29', '18:38:02', '2024-11-29 22:38:02', '2024-11-29 22:38:02'),
(31, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 7<br/>usuario: MSOLIZ<br/>nombre: MERCEDES<br/>paterno: SOLIZ<br/>materno: <br/>ci: 6666<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 655656556<br/>password: $2y$12$xTSk3t4OZLPIos/h8NEQjuJImb.fr7MXPGkRe8/sxXhYyUFW.rw0G<br/>tipo: DOCTOR GENERAL<br/>foto: <br/>fecha_registro: 2024-11-29<br/>acceso: 0<br/>created_at: 2024-11-29 18:38:28<br/>updated_at: 2024-11-29 18:38:28<br/>', NULL, 'USUARIOS', '2024-11-29', '18:38:28', '2024-11-29 22:38:28', '2024-11-29 22:38:28'),
(32, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 7<br/>usuario: MSOLIZ<br/>nombre: MERCEDES<br/>paterno: SOLIZ<br/>materno: <br/>ci: 6666<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 655656556<br/>password: $2y$12$xTSk3t4OZLPIos/h8NEQjuJImb.fr7MXPGkRe8/sxXhYyUFW.rw0G<br/>tipo: DOCTOR GENERAL<br/>foto: <br/>fecha_registro: 2024-11-29<br/>acceso: 0<br/>created_at: 2024-11-29 18:38:28<br/>updated_at: 2024-11-29 18:38:28<br/>', 'id: 7<br/>usuario: MSOLIZ<br/>nombre: MERCEDES<br/>paterno: SOLIZ<br/>materno: <br/>ci: 6666<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 655656556<br/>password: $2y$12$xTSk3t4OZLPIos/h8NEQjuJImb.fr7MXPGkRe8/sxXhYyUFW.rw0G<br/>tipo: DOCTOR GENERAL<br/>foto: <br/>fecha_registro: 2024-11-29<br/>acceso: 1<br/>created_at: 2024-11-29 18:38:28<br/>updated_at: 2024-11-29 18:38:31<br/>', 'USUARIOS', '2024-11-29', '18:38:31', '2024-11-29 22:38:31', '2024-11-29 22:38:31'),
(33, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 6<br/>usuario: FGONZALES<br/>nombre: FABRICIO<br/>paterno: GONZALES<br/>materno: CARASCO<br/>ci: 5555<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6556556<br/>password: $2y$12$urXIMYoyLaAnqShKFsPikeaHEmqCzw02.iCkjTKEjd280QFMAdqVy<br/>tipo: DOCTOR ESPECIALISTA<br/>foto: <br/>fecha_registro: 2024-11-29<br/>acceso: 0<br/>created_at: 2024-11-29 18:38:02<br/>updated_at: 2024-11-29 18:38:02<br/>', 'id: 6<br/>usuario: FGONZALES<br/>nombre: FABRICIO<br/>paterno: GONZALES<br/>materno: CARASCO<br/>ci: 5555<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 6556556<br/>password: $2y$12$urXIMYoyLaAnqShKFsPikeaHEmqCzw02.iCkjTKEjd280QFMAdqVy<br/>tipo: DOCTOR ESPECIALISTA<br/>foto: <br/>fecha_registro: 2024-11-29<br/>acceso: 1<br/>created_at: 2024-11-29 18:38:02<br/>updated_at: 2024-11-29 18:38:36<br/>', 'USUARIOS', '2024-11-29', '18:38:36', '2024-11-29 22:38:36', '2024-11-29 22:38:36'),
(34, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 5<br/>usuario: CRAMIRES<br/>nombre: CARMEN<br/>paterno: RAMIRES<br/>materno: RAMIRES<br/>ci: 4444<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 65656555<br/>password: $2y$12$1k7h9qoo0jGWtjv82swhpO8eM5Zydg0891Y3Am6274jj.ZEaEexwq<br/>tipo: DOCTOR ESPECIALISTA<br/>foto: <br/>fecha_registro: 2024-11-29<br/>acceso: 0<br/>created_at: 2024-11-29 18:37:44<br/>updated_at: 2024-11-29 18:37:44<br/>', 'id: 5<br/>usuario: CRAMIRES<br/>nombre: CARMEN<br/>paterno: RAMIRES<br/>materno: RAMIRES<br/>ci: 4444<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 65656555<br/>password: $2y$12$1k7h9qoo0jGWtjv82swhpO8eM5Zydg0891Y3Am6274jj.ZEaEexwq<br/>tipo: DOCTOR ESPECIALISTA<br/>foto: <br/>fecha_registro: 2024-11-29<br/>acceso: 1<br/>created_at: 2024-11-29 18:37:44<br/>updated_at: 2024-11-29 18:38:39<br/>', 'USUARIOS', '2024-11-29', '18:38:39', '2024-11-29 22:38:39', '2024-11-29 22:38:39'),
(35, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 4<br/>usuario: MPAREDES1<br/>nombre: MARY<br/>paterno: PAREDES<br/>materno: GONZALES<br/>ci: 3333<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 76676767<br/>password: $2y$12$BXxQ9EXfxvETcOehLU1wreaZrCNBioE7t3jLYM7ToQ4RAK1bNT5R2<br/>tipo: DOCTOR ESPECIALISTA<br/>foto: 1732905449_MPAREDES1.jpg<br/>fecha_registro: 2024-11-29<br/>acceso: 0<br/>created_at: 2024-11-29 18:37:24<br/>updated_at: 2024-11-29 18:37:29<br/>', 'id: 4<br/>usuario: MPAREDES1<br/>nombre: MARY<br/>paterno: PAREDES<br/>materno: GONZALES<br/>ci: 3333<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>email: <br/>fono: 76676767<br/>password: $2y$12$BXxQ9EXfxvETcOehLU1wreaZrCNBioE7t3jLYM7ToQ4RAK1bNT5R2<br/>tipo: DOCTOR ESPECIALISTA<br/>foto: 1732905449_MPAREDES1.jpg<br/>fecha_registro: 2024-11-29<br/>acceso: 1<br/>created_at: 2024-11-29 18:37:24<br/>updated_at: 2024-11-29 18:38:41<br/>', 'USUARIOS', '2024-11-29', '18:38:41', '2024-11-29 22:38:41', '2024-11-29 22:38:41'),
(36, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PACIENTE', 'id: 1<br/>nombre: RAMIRO<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 123456<br/>ci_exp: LP<br/>fecha_nac: 2000-01-01<br/>dir: ZONA LOS OLIVOS<br/>fono: 676767676<br/>foto: 17329036281.jpg<br/>nombre_proge: <br/>senior: RAMIRO MAMANI<br/>dir_s: ZONA LOS PEDREGALES<br/>fono_dom_s: 222277<br/>fono_trab_s: 277777<br/>cel_s: 766666666<br/>fax_s: FAX<br/>correo_s: RAMIRO@GMAIL.COM<br/>agradecer: JUAN PERES<br/>nom_edad_hmnos: PEDRO MAMANI 20, CARLOS MAMANI 15<br/>user_id: 1<br/>fecha_registro: 2024-11-18<br/>created_at: 2024-11-18 23:26:58<br/>updated_at: 2024-11-29 18:07:08<br/>', 'id: 1<br/>nombre: RAMIRO<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 123456<br/>ci_exp: LP<br/>fecha_nac: 2000-01-01<br/>dir: ZONA LOS OLIVOS<br/>fono: 676767676<br/>foto: 17329036281.jpg<br/>nombre_proge: <br/>senior: RAMIRO MAMANI<br/>dir_s: ZONA LOS PEDREGALES<br/>fono_dom_s: 222277<br/>fono_trab_s: 277777<br/>cel_s: 766666666<br/>fax_s: FAX<br/>correo_s: RAMIRO@GMAIL.COM<br/>agradecer: JUAN PERES<br/>nom_edad_hmnos: PEDRO MAMANI 20, CARLOS MAMANI 15<br/>user_id: 1<br/>fecha_registro: 2024-11-18<br/>created_at: 2024-11-18 23:26:58<br/>updated_at: 2024-11-29 18:07:08<br/>', 'PACIENTES', '2024-11-29', '18:38:58', '2024-11-29 22:38:58', '2024-11-29 22:38:58'),
(37, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PACIENTE', 'id: 2<br/>nombre: MARIA<br/>paterno: GONZALES<br/>materno: <br/>ci: <br/>ci_exp: <br/>fecha_nac: 2014-01-01<br/>dir: <br/>fono: <br/>foto: 17329035732.jpg<br/>nombre_proge: JUAN GONZALES<br/>senior: <br/>dir_s: <br/>fono_dom_s: <br/>fono_trab_s: <br/>cel_s: <br/>fax_s: <br/>correo_s: <br/>agradecer: <br/>nom_edad_hmnos: <br/>user_id: 1<br/>fecha_registro: 2024-11-18<br/>created_at: 2024-11-18 23:30:02<br/>updated_at: 2024-11-29 18:06:13<br/>', 'id: 2<br/>nombre: MARIA<br/>paterno: GONZALES<br/>materno: <br/>ci: <br/>ci_exp: <br/>fecha_nac: 2014-01-01<br/>dir: <br/>fono: <br/>foto: 17329035732.jpg<br/>nombre_proge: JUAN GONZALES<br/>senior: <br/>dir_s: <br/>fono_dom_s: <br/>fono_trab_s: <br/>cel_s: <br/>fax_s: <br/>correo_s: <br/>agradecer: <br/>nom_edad_hmnos: <br/>user_id: 1<br/>fecha_registro: 2024-11-18<br/>created_at: 2024-11-18 23:30:02<br/>updated_at: 2024-11-29 18:06:13<br/>', 'PACIENTES', '2024-11-29', '18:39:09', '2024-11-29 22:39:09', '2024-11-29 22:39:09'),
(38, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PACIENTE', 'id: 3<br/>nombre: CARLOS<br/>paterno: MARTINES<br/>materno: SOLIZ<br/>ci: <br/>ci_exp: <br/>fecha_nac: <br/>dir: <br/>fono: <br/>foto: <br/>nombre_proge: <br/>senior: <br/>dir_s: <br/>fono_dom_s: <br/>fono_trab_s: <br/>cel_s: <br/>fax_s: <br/>correo_s: <br/>agradecer: <br/>nom_edad_hmnos: <br/>user_id: 1<br/>fecha_registro: 2024-11-29<br/>created_at: 2024-11-29 18:42:04<br/>updated_at: 2024-11-29 18:42:04<br/>', NULL, 'PACIENTES', '2024-11-29', '18:42:04', '2024-11-29 22:42:04', '2024-11-29 22:42:04'),
(39, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PACIENTE', 'id: 3<br/>nombre: CARLOS<br/>paterno: MARTINES<br/>materno: SOLIZ<br/>ci: <br/>ci_exp: <br/>fecha_nac: <br/>dir: <br/>fono: <br/>foto: <br/>nombre_proge: <br/>senior: <br/>dir_s: <br/>fono_dom_s: <br/>fono_trab_s: <br/>cel_s: <br/>fax_s: <br/>correo_s: <br/>agradecer: <br/>nom_edad_hmnos: <br/>user_id: 1<br/>fecha_registro: 2024-11-29<br/>created_at: 2024-11-29 18:42:04<br/>updated_at: 2024-11-29 18:42:04<br/>', 'id: 3<br/>nombre: CARLOS<br/>paterno: MARTINES<br/>materno: SOLIZ<br/>ci: <br/>ci_exp: <br/>fecha_nac: <br/>dir: <br/>fono: <br/>foto: <br/>nombre_proge: <br/>senior: <br/>dir_s: <br/>fono_dom_s: <br/>fono_trab_s: <br/>cel_s: <br/>fax_s: <br/>correo_s: <br/>agradecer: <br/>nom_edad_hmnos: <br/>user_id: 1<br/>fecha_registro: 2024-11-29<br/>created_at: 2024-11-29 18:42:04<br/>updated_at: 2024-11-29 18:42:04<br/>', 'PACIENTES', '2024-11-29', '18:42:32', '2024-11-29 22:42:32', '2024-11-29 22:42:32'),
(40, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PACIENTE', 'id: 3<br/>nombre: CARLOS<br/>paterno: MARTINES<br/>materno: SOLIZ<br/>ci: <br/>ci_exp: <br/>fecha_nac: <br/>dir: <br/>fono: <br/>foto: <br/>nombre_proge: <br/>senior: <br/>dir_s: <br/>fono_dom_s: <br/>fono_trab_s: <br/>cel_s: <br/>fax_s: <br/>correo_s: <br/>agradecer: <br/>nom_edad_hmnos: <br/>user_id: 1<br/>fecha_registro: 2024-11-29<br/>created_at: 2024-11-29 18:42:04<br/>updated_at: 2024-11-29 18:42:04<br/>', 'id: 3<br/>nombre: CARLOS<br/>paterno: MARTINES<br/>materno: SOLIZ<br/>ci: 54544554<br/>ci_exp: LP<br/>fecha_nac: 2000-01-01<br/>dir: LOS OLIVOS<br/>fono: 767667676767<br/>foto: <br/>nombre_proge: <br/>senior: CARLOS MARTINES<br/>dir_s: LOS PEDREGALES<br/>fono_dom_s: 22222<br/>fono_trab_s: 27272727<br/>cel_s: 6767767<br/>fax_s: FAX<br/>correo_s: CARLOS@GMAIL.COM<br/>agradecer: CARLOS<br/>nom_edad_hmnos: PEDRO 11 Y  JUAN 22<br/>user_id: 1<br/>fecha_registro: 2024-11-29<br/>created_at: 2024-11-29 18:42:04<br/>updated_at: 2024-11-29 19:01:24<br/>', 'PACIENTES', '2024-11-29', '19:01:24', '2024-11-29 23:01:24', '2024-11-29 23:01:24'),
(41, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN EXAMEN CLÍNICO', 'id: 2<br/>cod: EC.2<br/>nro: 2<br/>paciente_id: 2<br/>simetria_facial: SIMETRIA<br/>diccion: NORMAL<br/>patron_facial: MESOCEFALO<br/>respiracion: NASAL<br/>perfil: RECTO<br/>relacion_labial: NORMAL<br/>labios: NORMALES<br/>maxilar_superior: CLASE I<br/>deglucion: NORMAL<br/>lengua_deglucion: NORMAL<br/>habito_bucal: SUCCIÓN DE DEDOS<br/>denticion: DECIDUA<br/>overjet: NORMAL<br/>higiene_bucal: MALA<br/>salud_dental: MALA<br/>relacion_molar: CLASE I<br/>relacion_canina: CLASE I<br/>amigdalas: NORMALES<br/>mordida_cruzada: DIENTE ANTERIOR<br/>linea_sup: COINCIDE LINEA MEDIA FACIAL<br/>linea_sup_mm: <br/>linea_inf: COINCIDE LINEA MEDIA FACIAL<br/>linea_inf_mm: <br/>observacion: <br/>modelo: 1732907203.OBJ<br/>fecha_registro: 2024-11-29<br/>created_at: 2024-11-29 19:06:57<br/>updated_at: 2024-11-29 19:06:57<br/>', NULL, 'EXAMEN CLÍNICO', '2024-11-29', '19:06:57', '2024-11-29 23:06:57', '2024-11-29 23:06:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '2024_01_31_165641_create_configuracions_table', 1),
(3, '2024_02_02_205431_create_historial_accions_table', 1),
(4, '2024_11_18_211411_create_pacientes_table', 2),
(5, '2024_11_18_211430_create_consultas_table', 2),
(6, '2024_11_18_211448_create_examen_clinicos_table', 2),
(7, '2024_11_18_211546_create_examen_imagens_table', 2),
(8, '2024_11_18_211558_create_antecedente_dentals_table', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci_exp` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `dir` varchar(350) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fono` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_proge` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `senior` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir_s` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono_dom_s` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono_trab_s` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cel_s` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fax_s` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo_s` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `agradecer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom_edad_hmnos` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`id`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `fecha_nac`, `dir`, `fono`, `foto`, `nombre_proge`, `senior`, `dir_s`, `fono_dom_s`, `fono_trab_s`, `cel_s`, `fax_s`, `correo_s`, `agradecer`, `nom_edad_hmnos`, `user_id`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'RAMIRO', 'MAMANI', 'MAMANI', '123456', 'LP', '2000-01-01', 'ZONA LOS OLIVOS', '676767676', '17329036281.jpg', '', 'RAMIRO MAMANI', 'ZONA LOS PEDREGALES', '222277', '277777', '766666666', 'FAX', 'RAMIRO@GMAIL.COM', 'JUAN PERES', 'PEDRO MAMANI 20, CARLOS MAMANI 15', 1, '2024-11-18', '2024-11-19 03:26:58', '2024-11-29 22:07:08'),
(2, 'MARIA', 'GONZALES', '', '', '', '2014-01-01', '', '', '17329035732.jpg', 'JUAN GONZALES', '', '', '', '', '', '', '', '', '', 1, '2024-11-18', '2024-11-19 03:30:02', '2024-11-29 22:06:13'),
(3, 'CARLOS', 'MARTINES', 'SOLIZ', '54544554', 'LP', '2000-01-01', 'LOS OLIVOS', '767667676767', '', '', 'CARLOS MARTINES', 'LOS PEDREGALES', '22222', '27272727', '6767767', 'FAX', 'CARLOS@GMAIL.COM', 'CARLOS', 'PEDRO 11 Y  JUAN 22', 1, '2024-11-29', '2024-11-29 22:42:04', '2024-11-29 23:01:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `acceso` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `email`, `fono`, `password`, `tipo`, `foto`, `fecha_registro`, `acceso`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin', NULL, '0', '', '', 'admin@admin.com', '', '$2y$12$65d4fgZsvBV5Lc/AxNKh4eoUdbGyaczQ4sSco20feSQANshNLuxSC', 'DOCTOR GENERAL', NULL, '2024-11-09', 1, NULL, NULL),
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '1111', 'LP', 'ZONA LOS OLIVOS', 'JUAN@GMAIL.COM', '7777777', '$2y$12$ZEclJTz5qo7TFBFtp8ehwuaIDE.g0VYqOlLl4aJSFvNoCL0JFYS7O', 'DOCTOR GENERAL', '1731963984_JPERES.jpg', '2024-11-18', 1, '2024-11-19 01:06:24', '2024-11-19 01:06:24'),
(3, 'MPAREDES', 'MARCO', 'PAREDES', '', '2222', 'LP', 'ZONA LOS OLIVOS', 'MARCO@GMAIL.COM', '66666777', '$2y$12$eo5QP1TuX5LdxqNXEnf7ue8bLFxFZ/xu4TAc0.p1qkEgwBjn.nPJq', 'DOCTOR ESPECIALISTA', '1732661918_MPAREDES.jpg', '2024-11-26', 1, '2024-11-27 02:58:38', '2024-11-27 02:58:38'),
(4, 'MPAREDES1', 'MARY', 'PAREDES', 'GONZALES', '3333', 'LP', 'LOS OLIVOS', '', '76676767', '$2y$12$BXxQ9EXfxvETcOehLU1wreaZrCNBioE7t3jLYM7ToQ4RAK1bNT5R2', 'DOCTOR ESPECIALISTA', '1732905449_MPAREDES1.jpg', '2024-11-29', 1, '2024-11-29 22:37:24', '2024-11-29 22:38:41'),
(5, 'CRAMIRES', 'CARMEN', 'RAMIRES', 'RAMIRES', '4444', 'LP', 'LOS OLIVOS', '', '65656555', '$2y$12$1k7h9qoo0jGWtjv82swhpO8eM5Zydg0891Y3Am6274jj.ZEaEexwq', 'DOCTOR ESPECIALISTA', NULL, '2024-11-29', 1, '2024-11-29 22:37:44', '2024-11-29 22:38:39'),
(6, 'FGONZALES', 'FABRICIO', 'GONZALES', 'CARASCO', '5555', 'LP', 'LOS OLIVOS', '', '6556556', '$2y$12$urXIMYoyLaAnqShKFsPikeaHEmqCzw02.iCkjTKEjd280QFMAdqVy', 'DOCTOR ESPECIALISTA', NULL, '2024-11-29', 1, '2024-11-29 22:38:02', '2024-11-29 22:38:36'),
(7, 'MSOLIZ', 'MERCEDES', 'SOLIZ', '', '6666', 'LP', 'LOS OLIVOS', '', '655656556', '$2y$12$xTSk3t4OZLPIos/h8NEQjuJImb.fr7MXPGkRe8/sxXhYyUFW.rw0G', 'DOCTOR GENERAL', NULL, '2024-11-29', 1, '2024-11-29 22:38:28', '2024-11-29 22:38:31');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `antecedente_dentals`
--
ALTER TABLE `antecedente_dentals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `antecedente_dentals_paciente_id_foreign` (`paciente_id`);

--
-- Indices de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `consultas`
--
ALTER TABLE `consultas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `consultas_paciente_id_foreign` (`paciente_id`),
  ADD KEY `consultas_general_id_foreign` (`general_id`),
  ADD KEY `consultas_especialista_id_foreign` (`especialista_id`);

--
-- Indices de la tabla `examen_clinicos`
--
ALTER TABLE `examen_clinicos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `examen_clinicos_cod_unique` (`cod`),
  ADD KEY `examen_clinicos_paciente_id_foreign` (`paciente_id`);

--
-- Indices de la tabla `examen_imagens`
--
ALTER TABLE `examen_imagens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `examen_imagens_examen_clinico_id_foreign` (`examen_clinico_id`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `antecedente_dentals`
--
ALTER TABLE `antecedente_dentals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `consultas`
--
ALTER TABLE `consultas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `examen_clinicos`
--
ALTER TABLE `examen_clinicos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `examen_imagens`
--
ALTER TABLE `examen_imagens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `antecedente_dentals`
--
ALTER TABLE `antecedente_dentals`
  ADD CONSTRAINT `antecedente_dentals_paciente_id_foreign` FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`);

--
-- Filtros para la tabla `consultas`
--
ALTER TABLE `consultas`
  ADD CONSTRAINT `consultas_especialista_id_foreign` FOREIGN KEY (`especialista_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `consultas_general_id_foreign` FOREIGN KEY (`general_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `consultas_paciente_id_foreign` FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`);

--
-- Filtros para la tabla `examen_clinicos`
--
ALTER TABLE `examen_clinicos`
  ADD CONSTRAINT `examen_clinicos_paciente_id_foreign` FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`);

--
-- Filtros para la tabla `examen_imagens`
--
ALTER TABLE `examen_imagens`
  ADD CONSTRAINT `examen_imagens_examen_clinico_id_foreign` FOREIGN KEY (`examen_clinico_id`) REFERENCES `examen_clinicos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
