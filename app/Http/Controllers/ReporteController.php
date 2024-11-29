<?php

namespace App\Http\Controllers;

use App\Models\AntecedenteDental;
use App\Models\Cliente;
use App\Models\Consulta;
use App\Models\ExamenClinico;
use App\Models\Lote;
use App\Models\Paciente;
use App\Models\Urbanizacion;
use App\Models\User;
use App\Models\VentaLote;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;
use PDF;

class ReporteController extends Controller
{
    public function usuarios()
    {
        return Inertia::render("Reportes/Usuarios");
    }

    public function r_usuarios(Request $request)
    {
        $tipo =  $request->tipo;
        $usuarios = User::where('id', '!=', 1)->where("tipo", "!=", "CLIENTE")->orderBy("paterno", "ASC")->get();

        if ($tipo != 'TODOS') {
            $request->validate([
                'tipo' => 'required',
            ]);
            $usuarios = User::where('id', '!=', 1)->where('tipo', $request->tipo)->orderBy("paterno", "ASC")->get();
        }

        $pdf = PDF::loadView('reportes.usuarios', compact('usuarios'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('usuarios.pdf');
    }

    public function pacientes()
    {
        return Inertia::render("Reportes/Pacientes");
    }

    public function r_pacientes(Request $request)
    {
        $paciente_id =  $request->paciente_id;
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $pacientes = Paciente::select("pacientes.*");

        if ($paciente_id != 'todos') {
            $pacientes->where("id", $paciente_id);
        } else {
            if (Auth::user()->tipo == 'DOCTOR ESPECIALISTA') {
                $id_pacientes = Consulta::where("especialista_id", Auth::user()->id)->distinct("paciente_id")->pluck("paciente_id")->toArray();
                $pacientes->whereIn("pacientes.id", $id_pacientes);
            }
        }

        if ($fecha_ini && $fecha_fin) {
            $pacientes->whereBetween("fecha_registro", [$fecha_ini, $fecha_fin]);
        }

        $pacientes = $pacientes->get();


        $pdf = PDF::loadView('reportes.pacientes', compact('pacientes'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('pacientes.pdf');
    }

    public function examen_clinicos()
    {
        return Inertia::render("Reportes/ExamenClinicos");
    }

    public function r_examen_clinicos(Request $request)
    {
        $examen_clinico_id =  $request->examen_clinico_id;
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $examen_clinicos = ExamenClinico::select("examen_clinicos.*")
            ->join("pacientes", "pacientes.id", "=", "examen_clinicos.paciente_id");

        if ($examen_clinico_id != 'todos') {
            $examen_clinicos->where("examen_clinicos.id", $examen_clinico_id);
        } else {
            if (Auth::user()->tipo == 'DOCTOR ESPECIALISTA') {
                $id_pacientes = Consulta::where("especialista_id", Auth::user()->id)->distinct("paciente_id")->pluck("paciente_id")->toArray();
                $examen_clinicos->whereIn("pacientes.id", $id_pacientes);
            }
        }

        if ($fecha_ini && $fecha_fin) {
            $examen_clinicos->whereBetween("examen_clinicos.fecha_registro", [$fecha_ini, $fecha_fin]);
        }

        $examen_clinicos = $examen_clinicos->get();

        $pdf = PDF::loadView('reportes.examen_clinicos', compact('examen_clinicos'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('examen_clinicos.pdf');
    }

    public function antecedente_dental()
    {
        return Inertia::render("Reportes/AntecedenteDental");
    }

    public function r_antecedente_dental(Request $request)
    {
        $paciente_id =  $request->paciente_id;
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $antecedente_dentals = AntecedenteDental::select("antecedente_dentals.*")
            ->join("pacientes", "pacientes.id", "=", "antecedente_dentals.paciente_id");

        if ($paciente_id != 'todos') {
            $antecedente_dentals->where("antecedente_dentals.paciente_id", $paciente_id);
        } else {
            if (Auth::user()->tipo == 'DOCTOR ESPECIALISTA') {
                $id_pacientes = Consulta::where("especialista_id", Auth::user()->id)->distinct("paciente_id")->pluck("paciente_id")->toArray();
                $antecedente_dentals->whereIn("pacientes.id", $id_pacientes);
            }
        }
        if ($fecha_ini && $fecha_fin) {
            $antecedente_dentals->whereBetween("antecedente_dentals.fecha_registro", [$fecha_ini, $fecha_fin]);
        }

        $antecedente_dentals = $antecedente_dentals->get();

        $pdf = PDF::loadView('reportes.antecedente_dentals', compact('antecedente_dentals'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('antecedentes.pdf');
    }

    public function pacientes_doctor()
    {
        return Inertia::render("Reportes/PacientesDoctor");
    }

    public function r_pacientes_doctor(Request $request)
    {
        $user_id =  $request->user_id;
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;

        $data = [];

        $users = User::select("users.*")->where("id", "!=", 1);

        if ($user_id != 'todos') {
            $users->where("id", $user_id);
        }

        $users = $users->get();

        foreach ($users as $user) {
            $columna = "general_id";
            if ($user->tipo == 'DOCTOR ESPECIALISTA') {
                $columna = "especialista_id";
            }
            $c_pacientes = Paciente::select("pacientes.*")
                ->join("consultas", "consultas.paciente_id", "=", "pacientes.id");
            $c_pacientes->where($columna, $user->id);

            if ($fecha_ini && $fecha_fin) {
                $c_pacientes->whereBetween("fecha_registro", [$fecha_ini, $fecha_fin]);
            }

            $c_pacientes = $c_pacientes->distinct("pacientes.id")->count();
            $data[] = [$user->full_name, (float)$c_pacientes];
        }

        return response()->JSON([
            "data" => $data
        ]);
    }
}
