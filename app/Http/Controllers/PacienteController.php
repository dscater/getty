<?php

namespace App\Http\Controllers;

use App\Models\AntecedenteDental;
use App\Models\ExamenClinico;
use App\Models\HistorialAccion;
use App\Models\Paciente;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class PacienteController extends Controller
{
    public $validacion = [
        "nombre" => "required|min:1",
        "paterno" => "required|min:1",
    ];

    public $mensajes = [
        "nombre.required" => "Este campo es obligatorio",
        "nombre.min" => "Debes ingresar al menos :min caracteres",
        "paterno.required" => "Este campo es obligatorio",
        "paterno.min" => "Debes ingresar al menos :min caracteres",
        "ci.required" => "Este campo es obligatorio",
        "ci.unique" => "Este C.I. ya fue registrado",
        "ci.min" => "Debes ingresar al menos :min caracteres",
        "ci_exp.required" => "Este campo es obligatorio",
        "email.unique" => "El correo electrónico ya fue registrado",
        "dir.required" => "Este campo es obligatorio",
        "dir.min" => "Debes ingresar al menos :min caracteres",
        "fono.required" => "Este campo es obligatorio",
        "fono.min" => "Debes ingresar al menos :min caracteres",
        "tipo.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("Pacientes/Index");
    }

    public function listado(Request $request)
    {
        $pacientes = Paciente::select("pacientes.*");
        $pacientes->where("user_id", Auth::user()->id);
        if ($request->sin_antecedente) {
            if ($request->id && $request->id != '') {
                $pacientes = $pacientes->whereNotExists(function ($query) {
                    $query->select(DB::raw(1))
                        ->from('examen_clinicos')
                        ->whereRaw('examen_clinicos.paciente_id = pacientes.id');
                })->orWhere(function ($subquery) use ($request) {
                    $subquery->whereIn('pacientes.id', [$request->id]);
                });
            } else {
                $pacientes = $pacientes->whereNotExists(function ($query) {
                    $query->select(DB::raw(1))
                        ->from('examen_clinicos')
                        ->whereRaw('examen_clinicos.paciente_id = pacientes.id');
                });
            }
        }

        $pacientes = $pacientes->get();
        return response()->JSON([
            "pacientes" => $pacientes
        ]);
    }

    public function api(Request $request)
    {
        // Log::debug($request);
        $pacientes = Paciente::select("pacientes.*");
        $pacientes->where("user_id", Auth::user()->id);
        $pacientes = $pacientes->get();
        return response()->JSON(["data" => $pacientes]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $pacientes = Paciente::select("pacientes.*");

        if (trim($search) != "") {
            $pacientes->where("nombre", "LIKE", "%$search%");
            $pacientes->orWhere("paterno", "LIKE", "%$search%");
            $pacientes->orWhere("materno", "LIKE", "%$search%");
            $pacientes->orWhere("ci", "LIKE", "%$search%");
        }

        $pacientes = $pacientes->paginate($request->itemsPerPage);
        return response()->JSON([
            "pacientes" => $pacientes
        ]);
    }

    public function store(Request $request)
    {
        if (isset($request["ci"]) && trim($request["ci"] != '')) {
            $this->validacion['ci'] = 'required|min:4|numeric|unique:pacientes,ci';
        }
        if ($request->hasFile('foto')) {
            $this->validacion['foto'] = 'image|mimes:jpeg,jpg,png|max:4096';
        }
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear el Paciente
            $request["fecha_registro"] = date("Y-m-d");
            $request["user_id"] = Auth::user()->id;
            $nuevo_paciente = Paciente::create(array_map('mb_strtoupper', $request->except('foto')));
            $nuevo_paciente->save();
            if ($request->hasFile('foto')) {
                $file = $request->foto;
                $nom_foto = time() . $nuevo_paciente->id . '.' . $file->getClientOriginalExtension();
                $nuevo_paciente->foto = $nom_foto;
                $file->move(public_path() . '/imgs/pacientes/', $nom_foto);
            }
            $nuevo_paciente->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_paciente, "pacientes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN PACIENTE',
                'datos_original' => $datos_original,
                'modulo' => 'PACIENTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("pacientes.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Paciente $paciente)
    {
        return response()->JSON($paciente);
    }

    public function update(Paciente $paciente, Request $request)
    {
        $this->validacion['ci'] = 'required|min:4|numeric|unique:pacientes,ci,' . $paciente->id;
        if ($request->hasFile('foto')) {
            $this->validacion['foto'] = 'image|mimes:jpeg,jpg,png|max:4096';
        }
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($paciente, "pacientes");
            $paciente->update(array_map('mb_strtoupper', $request->except('foto')));
            if ($request->hasFile('foto')) {
                $antiguo = $paciente->foto;
                if ($antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/pacientes/' . $antiguo);
                }
                $file = $request->foto;
                $nom_foto = time() . $paciente->id . '.' . $file->getClientOriginalExtension();
                $paciente->foto = $nom_foto;
                $file->move(public_path() . '/imgs/pacientes/', $nom_foto);
            }
            $paciente->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($paciente, "pacientes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN PACIENTE',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PACIENTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("pacientes.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Paciente $paciente)
    {
        DB::beginTransaction();
        try {
            $usos = ExamenClinico::where("paciente_id", $paciente->id)->get();
            if (count($usos) > 0) {
                throw ValidationException::withMessages([
                    'error' =>  "No es posible eliminar este registro porque esta siendo utilizado por otros registros",
                ]);
            }
            $usos = AntecedenteDental::where("paciente_id", $paciente->id)->get();
            if (count($usos) > 0) {
                throw ValidationException::withMessages([
                    'error' =>  "No es posible eliminar este registro porque esta siendo utilizado por otros registros",
                ]);
            }

            $antiguo = $paciente->foto;
            if ($antiguo != 'default.png') {
                \File::delete(public_path() . '/imgs/pacientes/' . $antiguo);
            }
            $datos_original = HistorialAccion::getDetalleRegistro($paciente, "pacientes");
            $paciente->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN PACIENTE',
                'datos_original' => $datos_original,
                'modulo' => 'PACIENTES',
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
