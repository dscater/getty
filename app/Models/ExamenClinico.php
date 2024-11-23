<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ExamenClinico extends Model
{
    use HasFactory;

    protected $fillable = [
        "cod",
        "nro",
        "paciente_id",
        "simetria_facial",
        "diccion",
        "patron_facial",
        "respiracion",
        "perfil",
        "relacion_labial",
        "labios",
        "maxilar_superior",
        "deglucion",
        "lengua_deglucion",
        "habito_bucal",
        "denticion",
        "overjet",
        "higiene_bucal",
        "salud_dental",
        "relacion_molar",
        "relacion_canina",
        "amigdalas",
        "mordida_cruzada",
        "linea_sup",
        "linea_sup_mm",
        "linea_inf",
        "linea_inf_mm",
        "observacion",
        "modelo",
        "fecha_registro"
    ];

    protected $appends = ["fecha_registro_t"];

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function examen_imagens()
    {
        return $this->hasMany(ExamenImagen::class, 'examen_clinico_id');
    }

    public function paciente()
    {
        return $this->belongsTo(Paciente::class, 'paciente_id');
    }


    public static function getCodigoNuevo()
    {
        $ultimo = ExamenClinico::get()->last();
        $nro = 1;
        if ($ultimo) {
            $nro = (int)$ultimo->nro_cod + 1;
        }

        $codigo = "EC." . $nro;
        return [$codigo, $nro];
    }
}
