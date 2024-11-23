<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ExamenImagen extends Model
{
    use HasFactory;

    protected $fillable = [
        "examen_clinico_id",
        "imagen",
        "ext"
    ];

    protected $appends = ["url_imagen", "url_archivo", "url_file", "name"];


    public function getNameAttribute()
    {
        return $this->imagen;
    }

    public function getUrlFileAttribute()
    {
        $array_imgs = ["jpg", "jpeg", "png", "webp", "gif"];
        if (in_array($this->ext, $array_imgs)) {
            return asset("/imgs/examen_clinicos/" . $this->imagen);
        }
        return asset("/imgs/attach.png");
    }

    public function getUrlArchivoAttribute()
    {
        return asset("imgs/examen_clinicos/" . $this->imagen);
    }


    public function getUrlImagenAttribute()
    {
        return asset("imgs/examen_clinicos/" . $this->imagen);
    }

    public function examen_clinico()
    {
        return $this->belongsTo(ExamenClinico::class, 'examen_clinico_id');
    }
}
