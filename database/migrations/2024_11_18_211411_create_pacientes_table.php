<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('pacientes', function (Blueprint $table) {
            $table->id();
            $table->string("nombre", 155);
            $table->string("paterno", 155);
            $table->string("materno", 155)->nullable();
            $table->string("ci", 155)->nullable();
            $table->string("ci_exp", 155)->nullable();
            $table->date("fecha_nac")->nullable();
            $table->string("dir", 350);
            $table->string("fono", 155)->nullable();
            $table->string("foto")->nullable();
            $table->string("nombre_proge")->nullable();
            $table->string("senior")->nullable();
            $table->string("dir_s")->nullable();
            $table->string("fono_dom_s")->nullable();
            $table->string("fono_trab_s")->nullable();
            $table->string("cel_s")->nullable();
            $table->string("fax_s")->nullable();
            $table->string("correo_s")->nullable();
            $table->string("agradecer");
            $table->string("nom_edad_hmnos", 500)->nullable();
            $table->date("fecha_registro")->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pacientes');
    }
};
