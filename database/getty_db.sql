-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 18-11-2024 a las 21:32:36
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
(1, 'GETTY', 'GT', 'GETTY S.A.', 'LA PAZ', 'ZONA LOS OLIVOS', '77777777', 'GETTY@GMAIL.COM', 'GETTY.COM', 'ACTIVIDAD', '1725897866_1.jpg', NULL, '2024-11-11 19:58:10');

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examen_clinicos`
--

CREATE TABLE `examen_clinicos` (
  `id` bigint UNSIGNED NOT NULL,
  `cod` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examen_imagens`
--

CREATE TABLE `examen_imagens` (
  `id` bigint UNSIGNED NOT NULL,
  `examen_clinico_id` bigint UNSIGNED NOT NULL,
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>email: JUAN@GMAIL.COM<br/>fono: 7777777<br/>password: $2y$12$ZEclJTz5qo7TFBFtp8ehwuaIDE.g0VYqOlLl4aJSFvNoCL0JFYS7O<br/>tipo: DOCTOR GENERAL<br/>foto: 1731963984_JPERES.jpg<br/>fecha_registro: 2024-11-18<br/>acceso: 1<br/>created_at: 2024-11-18 21:06:24<br/>updated_at: 2024-11-18 21:06:24<br/>', NULL, 'USUARIOS', '2024-11-18', '21:06:24', '2024-11-19 01:06:24', '2024-11-19 01:06:24');

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
  `edad` int DEFAULT NULL,
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
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '1111', 'LP', 'ZONA LOS OLIVOS', 'JUAN@GMAIL.COM', '7777777', '$2y$12$ZEclJTz5qo7TFBFtp8ehwuaIDE.g0VYqOlLl4aJSFvNoCL0JFYS7O', 'DOCTOR GENERAL', '1731963984_JPERES.jpg', '2024-11-18', 1, '2024-11-19 01:06:24', '2024-11-19 01:06:24');

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `consultas`
--
ALTER TABLE `consultas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `examen_clinicos`
--
ALTER TABLE `examen_clinicos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `examen_imagens`
--
ALTER TABLE `examen_imagens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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