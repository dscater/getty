<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AntecedenteDental extends Model
{
    use HasFactory;

    protected $fillable = [
        "paciente_id",
        "lesiones_cara",
        "ch_pulgar_pasado",
        "ch_dedo_actual",
        "respiracion_bucal",
        "muerde_unia",
        "desgaste_dientes",
        "falta_permanente",
        "falta_alguno",
        "falta_alguno_d",
        "problema_cabeza",
        "examinado",
        "examinado_d",
        "aparatos",
        "aparatos_d",
        "fecha_registro",
    ];
    
    protected $appends = ["fecha_registro_t"];

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function paciente()
    {
        return $this->belongsTo(Paciente::class, 'paciente_id');
    }
}
