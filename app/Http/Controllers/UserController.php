<?php

namespace App\Http\Controllers;

use App\Models\Lote;
use App\Models\Paciente;
use App\Models\User;
use App\Models\VentaLote;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public static $permisos = [
        "DOCTOR GENERAL" => [
            "usuarios.index",
            "usuarios.create",
            "usuarios.edit",
            "usuarios.destroy",

            "pacientes.index",
            "pacientes.create",
            "pacientes.edit",
            "pacientes.destroy",

            "configuracions.index",
            "configuracions.create",
            "configuracions.edit",
            "configuracions.destroy",

            "reportes.usuarios",
        ],
        "DOCTOR ESPECIALISTA" => [],
    ];

    public static function getPermisosUser()
    {
        $array_permisos = self::$permisos;
        if ($array_permisos[Auth::user()->tipo]) {
            return $array_permisos[Auth::user()->tipo];
        }
        return [];
    }


    public static function verificaPermiso($permiso)
    {
        if (in_array($permiso, self::$permisos[Auth::user()->tipo])) {
            return true;
        }
        return false;
    }

    public function permisos(Request $request)
    {
        return response()->JSON([
            "permisos" => $this->permisos[Auth::user()->tipo]
        ]);
    }

    public function getUser()
    {
        return response()->JSON([
            "user" => Auth::user()
        ]);
    }

    public static function getInfoBoxUser()
    {
        $tipo = Auth::user()->tipo;
        $array_infos = [];

        if (in_array('usuarios.index', self::$permisos[$tipo])) {
            $array_infos[] = [
                'label' => 'USUARIOS',
                'cantidad' => User::where('id', '!=', 1)->where("tipo", "!=", "CLIENTE")->count(),
                'color' => 'bg-principal',
                'icon' => "fa-users",
                "url" => "usuarios.index"
            ];
        }

        if (in_array('pacientes.index', self::$permisos[$tipo])) {
            $pacientes = Paciente::count();
            $array_infos[] = [
                'label' => 'PACIENTES',
                'cantidad' => $pacientes,
                'color' => 'bg-principal',
                'icon' => "fa-users",
                "url" => "pacientes.index"
            ];
        }

        return $array_infos;
    }
}
