<?php

use App\Http\Controllers\AntecedenteDentalController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\ExamenClinicoController;
use App\Http\Controllers\InicioController;
use App\Http\Controllers\PacienteController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UsuarioController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
})->name("porta.index");

Route::get('/login', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
})->name("login");

Route::get("configuracions/getConfiguracion", [ConfiguracionController::class, 'getConfiguracion'])->name("configuracions.getConfiguracion");

Route::middleware('auth')->prefix("admin")->group(function () {
    // INICIO
    Route::get('/inicio', [InicioController::class, 'inicio'])->name('inicio');

    // CONFIGURACION
    Route::resource("configuracions", ConfiguracionController::class)->only(
        ["index", "show", "update"]
    );

    // USUARIO
    Route::get('profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::patch('profile/update_foto', [ProfileController::class, 'update_foto'])->name('profile.update_foto');
    Route::delete('profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::get("getUser", [UserController::class, 'getUser'])->name('users.getUser');
    Route::get("permisos", [UserController::class, 'permisos']);

    // USUARIOS
    Route::put("usuarios/password/{user}", [UsuarioController::class, 'actualizaPassword'])->name("usuarios.password");
    Route::get("usuarios/api", [UsuarioController::class, 'api'])->name("usuarios.api");
    Route::get("usuarios/paginado", [UsuarioController::class, 'paginado'])->name("usuarios.paginado");
    Route::get("usuarios/listado", [UsuarioController::class, 'listado'])->name("usuarios.listado");
    Route::get("usuarios/listado/byTipo", [UsuarioController::class, 'byTipo'])->name("usuarios.byTipo");
    Route::get("usuarios/show/{user}", [UsuarioController::class, 'show'])->name("usuarios.show");
    Route::put("usuarios/update/{user}", [UsuarioController::class, 'update'])->name("usuarios.update");
    Route::delete("usuarios/{user}", [UsuarioController::class, 'destroy'])->name("usuarios.destroy");
    Route::resource("usuarios", UsuarioController::class)->only(
        ["index", "store"]
    );

    // PACIENTES
    Route::get("pacientes/api", [PacienteController::class, 'api'])->name("pacientes.api");
    Route::get("pacientes/paginado", [PacienteController::class, 'paginado'])->name("pacientes.paginado");
    Route::get("pacientes/listado", [PacienteController::class, 'listado'])->name("pacientes.listado");
    Route::resource("pacientes", PacienteController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // EXAMENCLINICOS
    Route::get("examen_clinicos/obtienem", [ExamenClinicoController::class, 'obtienem'])->name("examen_clinicos.obtienem");
    Route::get("examen_clinicos/api", [ExamenClinicoController::class, 'api'])->name("examen_clinicos.api");
    Route::get("examen_clinicos/paginado", [ExamenClinicoController::class, 'paginado'])->name("examen_clinicos.paginado");
    Route::get("examen_clinicos/listado", [ExamenClinicoController::class, 'listado'])->name("examen_clinicos.listado");
    Route::get("examen_clinicos/detalle/{examen_clinico}", [ExamenClinicoController::class, 'detalle'])->name("examen_clinicos.detalle");
    Route::resource("examen_clinicos", ExamenClinicoController::class)->only(
        ["index", "create", "store", "edit", "update", "show", "destroy"]
    );

    // ANTECEDENTES DENALTES
    Route::get("antecedente_dentals/obtienem", [AntecedenteDentalController::class, 'obtienem'])->name("antecedente_dentals.obtienem");
    Route::get("antecedente_dentals/api", [AntecedenteDentalController::class, 'api'])->name("antecedente_dentals.api");
    Route::get("antecedente_dentals/paginado", [AntecedenteDentalController::class, 'paginado'])->name("antecedente_dentals.paginado");
    Route::get("antecedente_dentals/listado", [AntecedenteDentalController::class, 'listado'])->name("antecedente_dentals.listado");
    Route::get("antecedente_dentals/detalle/{antecedente_dental}", [AntecedenteDentalController::class, 'detalle'])->name("antecedente_dentals.detalle");
    Route::resource("antecedente_dentals", AntecedenteDentalController::class)->only(
        ["index", "create", "store", "edit", "update", "show", "destroy"]
    );


    // REPORTES
    Route::get('reportes/usuarios', [ReporteController::class, 'usuarios'])->name("reportes.usuarios");
    Route::get('reportes/r_usuarios', [ReporteController::class, 'r_usuarios'])->name("reportes.r_usuarios");

    Route::get('reportes/pacientes', [ReporteController::class, 'pacientes'])->name("reportes.pacientes");
    Route::get('reportes/r_pacientes', [ReporteController::class, 'r_pacientes'])->name("reportes.r_pacientes");

    Route::get('reportes/examen_clinicos', [ReporteController::class, 'examen_clinicos'])->name("reportes.examen_clinicos");
    Route::get('reportes/r_examen_clinicos', [ReporteController::class, 'r_examen_clinicos'])->name("reportes.r_examen_clinicos");

    Route::get('reportes/antecedente_dental', [ReporteController::class, 'antecedente_dental'])->name("reportes.antecedente_dental");
    Route::get('reportes/r_antecedente_dental', [ReporteController::class, 'r_antecedente_dental'])->name("reportes.r_antecedente_dental");

    Route::get('reportes/pacientes_doctor', [ReporteController::class, 'pacientes_doctor'])->name("reportes.pacientes_doctor");
    Route::get('reportes/r_pacientes_doctor', [ReporteController::class, 'r_pacientes_doctor'])->name("reportes.r_pacientes_doctor");
});
require __DIR__ . '/auth.php';
