<?php

namespace App\Http\Controllers;

use App\Models\Consulta;
use App\Models\ExamenClinico;
use App\Models\ExamenImagen;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class ExamenClinicoController extends Controller
{
    public $validacion = [
        "paciente_id" => "required",
        "examen_imagens" => "required|array|min:1"
    ];

    public $mensajes = [
        "paciente_id.required" => "Este campo es obligatorio",
        "examen_imagens.required" => "Debes cargar las imagenes",
        "examen_imagens.min" => "Debes cargar al menos :min imagen"
    ];

    public function index()
    {
        return Inertia::render("ExamenClinicos/Index");
    }

    public function listado()
    {
        $examen_clinicos = ExamenClinico::with(["paciente"])->select("examen_clinicos.*");

        $examen_clinicos->join("pacientes", "pacientes.id", "=", "examen_clinicos.paciente_id");
        if (Auth::user()->tipo == 'DOCTOR ESPECIALISTA') {
            $id_pacientes = Consulta::where("especialista_id", Auth::user()->id)->distinct("paciente_id")->pluck("paciente_id")->toArray();
            $examen_clinicos->whereIn("pacientes.id", $id_pacientes);
        }

        $examen_clinicos = $examen_clinicos->get();
        return response()->JSON([
            "examen_clinicos" => $examen_clinicos
        ]);
    }

    public function api(Request $request)
    {
        // Log::debug($request);
        $examen_clinicos = ExamenClinico::with(["paciente"])->select("examen_clinicos.*");
        $examen_clinicos->join("pacientes", "pacientes.id", "=", "examen_clinicos.paciente_id");
        if (Auth::user()->tipo == 'DOCTOR ESPECIALISTA') {
            $id_pacientes = Consulta::where("especialista_id", Auth::user()->id)->distinct("paciente_id")->pluck("paciente_id")->toArray();
            $examen_clinicos->whereIn("pacientes.id", $id_pacientes);
        }
        $examen_clinicos = $examen_clinicos->get();
        return response()->JSON(["data" => $examen_clinicos]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $examen_clinicos = ExamenClinico::with(["paciente"])->select("examen_clinicos.*");

        if (trim($search) != "") {
            $examen_clinicos->where("nombre", "LIKE", "%$search%");
        }

        $examen_clinicos = $examen_clinicos->paginate($request->itemsPerPage);
        return response()->JSON([
            "examen_clinicos" => $examen_clinicos
        ]);
    }

    public function create()
    {
        return Inertia::render("ExamenClinicos/Create");
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        // verificar formato
        $imagenes = ["jpg", "jpeg", "png", "webp"];
        $errors = [];
        $examen_imagens = $request->examen_imagens;
        foreach ($request->examen_imagens as $file) {
            $extension = $file["file"]->getClientOriginalExtension();
            if (!in_array($extension, $imagenes)) {
                $errors["examen_imagens"] = "Solo puedes ingresar imagenes jpg, jpeg, png y webp";
                break;
            }
        }
        if (count($errors) > 0) {
            return throw ValidationException::withMessages($errors);
        }

        DB::beginTransaction();
        try {
            // crear el ExamenClinico
            $request["fecha_registro"] = date("Y-m-d");
            $a_cod = ExamenClinico::getCodigoNuevo();
            $request["cod"] = $a_cod[0];
            $request["nro"] = $a_cod[1];
            $nuevo_examen_clinico = ExamenClinico::create(array_map('mb_strtoupper', $request->except('examen_imagens', 'eliminados')));

            foreach ($examen_imagens as $key => $file) {
                $extension = $file["file"]->getClientOriginalExtension();
                $nom_img = $key . time() . "." . $extension;
                $path = public_path("imgs/examen_clinicos/");
                $file["file"]->move($path, $nom_img);
                ExamenImagen::create([
                    "examen_clinico_id" => $nuevo_examen_clinico->id,
                    "imagen" => $nom_img,
                    "ext" => $extension,
                ]);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_examen_clinico, "examen_clinicos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN EXAMEN CLÍNICO',
                'datos_original' => $datos_original,
                'modulo' => 'EXAMEN CLÍNICO',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("examen_clinicos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(ExamenClinico $examen_clinico)
    {
        return response()->JSON($examen_clinico);
    }

    public function edit(ExamenClinico $examen_clinico)
    {
        $examen_clinico = $examen_clinico->load(["examen_imagens"]);
        return Inertia::render("ExamenClinicos/Edit", compact("examen_clinico"));
    }

    public function detalle(ExamenClinico $examen_clinico)
    {
        $examen_clinico = $examen_clinico->load(["paciente", "examen_imagens"]);
        return Inertia::render("ExamenClinicos/Detalle", compact("examen_clinico"));
    }

    public function update(ExamenClinico $examen_clinico, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        // verificar formato
        $imagenes = ["jpg", "jpeg", "png", "webp"];
        $errors = [];
        $examen_imagens = $request->examen_imagens;
        foreach ($request->examen_imagens as $file) {
            if (isset($file["file"]) && !is_string($file["file"])) {
                $extension = $file["file"]->getClientOriginalExtension();
                if (!in_array($extension, $imagenes)) {
                    $errors["examen_imagens"] = "Solo puedes ingresar imagenes jpg, jpeg, png y webp";
                    break;
                }
            }
        }
        if (count($errors) > 0) {
            return throw ValidationException::withMessages($errors);
        }

        DB::beginTransaction();
        try {
            $anterior_modelo = $examen_clinico->modelo;
            $datos_original = HistorialAccion::getDetalleRegistro($examen_clinico, "examen_clinicos");
            $examen_clinico->update(array_map('mb_strtoupper', $request->except('examen_imagens', 'eliminados', 'paciente')));
            $examen_clinico->modelo = $request->modelo;
            $examen_clinico->save();

            // eliminados
            if ($request->eliminados) {
                foreach ($request->eliminados as $el) {
                    $examen_imagen = ExamenImagen::find($el);
                    \File::delete(public_path("imgs/examen_clinicos/" . $examen_imagen->imagen));
                    $examen_imagen->delete();
                }
            }

            foreach ($examen_imagens as $key => $file) {
                if (isset($file["file"]) && !is_string($file["file"])) {
                    if ($file["id"] != 0) {
                        $examen_imagen = ExamenImagen::find($file["id"]);
                        \File::delete(public_path("imgs/examen_clinicos/" . $examen_imagen->imagen));
                        $extension = $file["file"]->getClientOriginalExtension();
                        $nom_img = $key . time() . "." . $extension;
                        $path = public_path("imgs/examen_clinicos/");
                        $file["file"]->move($path, $nom_img);
                        ExamenImagen::create([
                            "examen_clinico_id" => $examen_clinico->id,
                            "imagen" => $nom_img,
                            "ext" => $extension,
                        ]);
                    } else {
                        $extension = $file["file"]->getClientOriginalExtension();
                        $nom_img = $key . time() . "." . $extension;
                        $path = public_path("imgs/examen_clinicos/");
                        $file["file"]->move($path, $nom_img);
                        ExamenImagen::create([
                            "examen_clinico_id" => $examen_clinico->id,
                            "imagen" => $nom_img,
                            "ext" => $extension,
                        ]);
                    }
                }
            }

            if ($anterior_modelo != $examen_clinico->modelo) {
                \File::delete(public_path("imgs/examen_clinicos/" . $anterior_modelo));
            }

            $datos_nuevo = HistorialAccion::getDetalleRegistro($examen_clinico, "examen_clinicos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN EXAMEN CLÍNICO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'EXAMEN CLÍNICO',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("examen_clinicos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(ExamenClinico $examen_clinico)
    {
        DB::beginTransaction();
        try {

            foreach ($examen_clinico->examen_imagens as $key => $examen_imagen) {
                \File::delete(public_path("imgs/examen_clinicos/" . $examen_imagen->imagen));
                $examen_imagen->delete();
            }
            $datos_original = HistorialAccion::getDetalleRegistro($examen_clinico, "examen_clinicos");
            \File::delete(public_path("imgs/examen_clinicos/" . $examen_clinico->modelo));
            $examen_clinico->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN EXAMEN CLÍNICO',
                'datos_original' => $datos_original,
                'modulo' => 'EXAMEN CLÍNICO',
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

    public function obtienem(Request $request)
    {
        $total_modelos = 3;
        $numeroAleatorio = rand(1, $total_modelos);
        $nom_m = "m" . $numeroAleatorio . ".obj";
        $path = public_path("imgs/examen_clinicos/");
        $nom_nuevo = time() . ".obj";
        copy($path . $nom_m, $path . $nom_nuevo);
        return response()->JSON($nom_nuevo);
    }
}
