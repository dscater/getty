<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Consulta extends Model
{
    use HasFactory;

    protected $fillable = [
        "paciente_id",
        "general_id",
        "especialista_id",
        "motivo",
    ];

    public function paciente()
    {
        return $this->belongsTo(Paciente::class, 'paciente_id');
    }

    public function general()
    {
        return $this->belongsTo(User::class, 'general_id');
    }

    public function especialista()
    {
        return $this->belongsTo(User::class, 'especialista_id');
    }
}
