<?php

namespace App\Http\Controllers;

use App\Models\AntecedenteDental;
use App\Models\Consulta;
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
        "consultas" => "required"
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
        "consultas.required" => "Debes agregar al menos 1 consulta",
    ];

    public function index()
    {
        return Inertia::render("Pacientes/Index");
    }

    public function listado(Request $request)
    {
        $pacientes = Paciente::select("pacientes.*");
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


        if (Auth::user()->tipo == 'DOCTOR ESPECIALISTA') {
            $id_pacientes = Consulta::where("especialista_id", Auth::user()->id)->distinct("paciente_id")->pluck("paciente_id")->toArray();
            $pacientes->whereIn("id", $id_pacientes);
        }

        $pacientes = $pacientes->get();
        return response()->JSON([
            "pacientes" => $pacientes
        ]);
    }

    public function api(Request $request)
    {
        $pacientes = Paciente::select("pacientes.*");

        if (Auth::user()->tipo == 'DOCTOR ESPECIALISTA') {
            $id_pacientes = Consulta::where("especialista_id", Auth::user()->id)->distinct("paciente_id")->pluck("paciente_id")->toArray();
            $pacientes->whereIn("id", $id_pacientes);
        }

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

        $consultas = $request->consultas;
        $errores_consultas = false;
        foreach ($consultas as $consulta) {
            if ($consulta["general_id"] == '' || $consulta["especialista_id"] == '' || trim($consulta["motivo"] == '')) {
                $errores_consultas = true;
                break;
            }
        }

        if ($errores_consultas) {
            return throw ValidationException::withMessages(["consultas" => "Debes completar todos los campos de consultas"]);
        }

        DB::beginTransaction();
        try {
            // crear el Paciente
            $datos_paciente = [
                "nombre" => mb_strtoupper($request["nombre"]),
                "paterno" => mb_strtoupper($request["paterno"]),
                "materno" => mb_strtoupper($request["materno"]),
                "ci" => $request["ci"] ? $request["ci"] : null,
                "ci_exp" => mb_strtoupper($request["ci_exp"]),
                "fecha_nac" => $request["fecha_nac"] ? $request["fecha_nac"] : NULL,
                "dir" => mb_strtoupper($request["dir"]),
                "fono" => mb_strtoupper($request["fono"]),
                "foto" => mb_strtoupper($request["foto"]),
                "nombre_proge" => mb_strtoupper($request["nombre_proge"]),
                "senior" => mb_strtoupper($request["senior"]),
                "dir_s" => mb_strtoupper($request["dir_s"]),
                "fono_dom_s" => mb_strtoupper($request["fono_dom_s"]),
                "fono_trab_s" => mb_strtoupper($request["fono_trab_s"]),
                "cel_s" => mb_strtoupper($request["cel_s"]),
                "fax_s" => mb_strtoupper($request["fax_s"]),
                "correo_s" => mb_strtoupper($request["correo_s"]),
                "agradecer" => mb_strtoupper($request["agradecer"]),
                "nom_edad_hmnos" => mb_strtoupper($request["nom_edad_hmnos"]),
                "user_id" => Auth::user()->id,
                "fecha_registro" => date("Y-m-d")
            ];

            $nuevo_paciente = Paciente::create($datos_paciente);
            $nuevo_paciente->save();
            if ($request->hasFile('foto')) {
                $file = $request->foto;
                $nom_foto = time() . $nuevo_paciente->id . '.' . $file->getClientOriginalExtension();
                $nuevo_paciente->foto = $nom_foto;
                $file->move(public_path() . '/imgs/pacientes/', $nom_foto);
            }
            $nuevo_paciente->save();

            $consultas = $request->consultas;
            foreach ($consultas as $consulta) {
                $data_consulta = [
                    "general_id" => $consulta["general_id"],
                    "especialista_id" => $consulta["especialista_id"],
                    "motivo" => mb_strtoupper($consulta["motivo"]),
                ];

                $nuevo_paciente->consultas()->create($data_consulta);
            }

            if ($errores_consultas) {
                return throw ValidationException::withMessages(["consultas" => "Debes completar todos los campos de consultas"]);
            }

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
        return response()->JSON($paciente->load(["consultas.general", "consultas.especialista"]));
    }

    public function update(Paciente $paciente, Request $request)
    {
        if (trim($request->ci) != '') {
            $this->validacion['ci'] = 'required|min:4|numeric|unique:pacientes,ci,' . $paciente->id;
        }
        if ($request->hasFile('foto')) {
            $this->validacion['foto'] = 'image|mimes:jpeg,jpg,png|max:4096';
        }
        $request->validate($this->validacion, $this->mensajes);
        $consultas = $request->consultas;
        $errores_consultas = false;
        foreach ($consultas as $consulta) {
            if ($consulta["general_id"] == '' || $consulta["especialista_id"] == '' || trim($consulta["motivo"] == '')) {
                $errores_consultas = true;
                break;
            }
        }

        if ($errores_consultas) {
            return throw ValidationException::withMessages(["consultas" => "Debes completar todos los campos de consultas"]);
        }

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($paciente, "pacientes");

            $datos_paciente = [
                "nombre" => mb_strtoupper($request["nombre"]),
                "paterno" => mb_strtoupper($request["paterno"]),
                "materno" => mb_strtoupper($request["materno"]),
                "ci" => $request["ci"] ? $request["ci"] : null,
                "ci_exp" => mb_strtoupper($request["ci_exp"]),
                "fecha_nac" => $request["fecha_nac"] ? $request["fecha_nac"] : NULL,
                "dir" => mb_strtoupper($request["dir"]),
                "fono" => mb_strtoupper($request["fono"]),
                "foto" => mb_strtoupper($request["foto"]),
                "nombre_proge" => mb_strtoupper($request["nombre_proge"]),
                "senior" => mb_strtoupper($request["senior"]),
                "dir_s" => mb_strtoupper($request["dir_s"]),
                "fono_dom_s" => mb_strtoupper($request["fono_dom_s"]),
                "fono_trab_s" => mb_strtoupper($request["fono_trab_s"]),
                "cel_s" => mb_strtoupper($request["cel_s"]),
                "fax_s" => mb_strtoupper($request["fax_s"]),
                "correo_s" => mb_strtoupper($request["correo_s"]),
                "agradecer" => mb_strtoupper($request["agradecer"]),
                "nom_edad_hmnos" => mb_strtoupper($request["nom_edad_hmnos"]),
            ];

            $paciente->update($datos_paciente);
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

            $consultas = $request->consultas;
            foreach ($consultas as $consulta) {
                $data_consulta = [
                    "general_id" => $consulta["general_id"],
                    "especialista_id" => $consulta["especialista_id"],
                    "motivo" => mb_strtoupper($consulta["motivo"]),
                ];

                if ($consulta["id"] == 0) {
                    $paciente->consultas()->create($data_consulta);
                } else {
                    $oConsulta = Consulta::find($consulta["id"]);
                    $oConsulta->update($data_consulta);
                }
            }

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
            // $usos = Consulta::where("paciente_id", $paciente->id)->get();
            // if (count($usos) > 0) {
            //     throw ValidationException::withMessages([
            //         'error' =>  "No es posible eliminar este registro porque esta siendo utilizado por otros registros",
            //     ]);
            // }
            $paciente->consultas()->delete();

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
