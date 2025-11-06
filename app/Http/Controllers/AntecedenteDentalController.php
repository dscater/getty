<?php

namespace App\Http\Controllers;

use App\Models\AntecedenteDental;
use App\Models\Consulta;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class AntecedenteDentalController extends Controller
{
    public $validacion = [
        "paciente_id" => "required",
    ];

    public $mensajes = [
        "paciente_id.required" => "Este campo es obligatorio",
        "falta_alguno_d.required" => "Este campo es obligatorio",
        "examinado_d.required" => "Este campo es obligatorio",
        "aparatos_d.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("AntecedenteDentals/Index");
    }

    public function listado()
    {
        $antecedente_dentals = AntecedenteDental::with(["paciente"])->select("antecedente_dentals.*");
        $antecedente_dentals->join("pacientes", "pacientes.id", "=", "antecedente_dentals.paciente_id");
        if (Auth::user()->tipo == 'DOCTOR ESPECIALISTA') {
            $id_pacientes = Consulta::where("especialista_id", Auth::user()->id)->distinct("paciente_id")->pluck("paciente_id")->toArray();
            $antecedente_dentals->whereIn("pacientes.id", $id_pacientes);
        }
        $antecedente_dentals = $antecedente_dentals->get();
        return response()->JSON([
            "antecedente_dentals" => $antecedente_dentals
        ]);
    }

    public function api(Request $request)
    {
        // Log::debug($request);
        $antecedente_dentals = AntecedenteDental::with(["paciente"])->select("antecedente_dentals.*");
        $antecedente_dentals->join("pacientes", "pacientes.id", "=", "antecedente_dentals.paciente_id");


        if (Auth::user()->tipo == 'DOCTOR ESPECIALISTA') {
            $id_pacientes = Consulta::where("especialista_id", Auth::user()->id)->distinct("paciente_id")->pluck("paciente_id")->toArray();
            $antecedente_dentals->whereIn("pacientes.id", $id_pacientes);
        }
        $antecedente_dentals = $antecedente_dentals->get();
        return response()->JSON(["data" => $antecedente_dentals]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $antecedente_dentals = AntecedenteDental::with(["paciente"])->select("antecedente_dentals.*");

        if (trim($search) != "") {
            $antecedente_dentals->where("nombre", "LIKE", "%$search%");
        }

        $antecedente_dentals = $antecedente_dentals->paginate($request->itemsPerPage);
        return response()->JSON([
            "antecedente_dentals" => $antecedente_dentals
        ]);
    }

    public function create()
    {
        return Inertia::render("AntecedenteDentals/Create");
    }

    public function store(Request $request)
    {

        if ($request->falta_alguno == 'SI') {
            $this->validacion["falta_alguno_d"] = "required";
        }
        if ($request->examinado == 'SI') {
            $this->validacion["examinado_d"] = "required";
        }
        if ($request->aparatos == 'SI') {
            $this->validacion["aparatos_d"] = "required";
        }

        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear el AntecedenteDental
            $request["fecha_registro"] = date("Y-m-d");
            $nuevo_antecedente_dental = AntecedenteDental::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_antecedente_dental, "antecedente_dentals");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN ANTECEDENTE DENTAL',
                'datos_original' => $datos_original,
                'modulo' => 'ANTECEDENTE DENTAL',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("antecedente_dentals.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(AntecedenteDental $antecedente_dental)
    {
        return response()->JSON($antecedente_dental);
    }

    public function edit(AntecedenteDental $antecedente_dental)
    {
        $antecedente_dental = $antecedente_dental->load(["paciente"]);
        return Inertia::render("AntecedenteDentals/Edit", compact("antecedente_dental"));
    }

    public function detalle(AntecedenteDental $antecedente_dental)
    {
        $antecedente_dental = $antecedente_dental->load(["paciente"]);
        return Inertia::render("AntecedenteDentals/Detalle", compact("antecedente_dental"));
    }

    public function update(AntecedenteDental $antecedente_dental, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($antecedente_dental, "antecedente_dentals");
            $antecedente_dental->update(array_map('mb_strtoupper', $request->except(["paciente"])));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($antecedente_dental, "antecedente_dentals");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN ANTECEDENTE DENTAL',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'ANTECEDENTE DENTAL',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("antecedente_dentals.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(AntecedenteDental $antecedente_dental)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($antecedente_dental, "antecedente_dentals");
            $antecedente_dental->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN ANTECEDENTE DENTAL',
                'datos_original' => $datos_original,
                'modulo' => 'ANTECEDENTE DENTAL',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
}
