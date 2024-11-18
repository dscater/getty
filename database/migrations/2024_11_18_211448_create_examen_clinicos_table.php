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
        Schema::create('examen_clinicos', function (Blueprint $table) {
            $table->id();
            $table->string("cod")->unique();
            $table->unsignedBigInteger("paciente_id");
            $table->string("simetria_facial");
            $table->string("diccion");
            $table->string("patron_facial");
            $table->string("respiracion");
            $table->string("perfil");
            $table->string("relacion_labial");
            $table->string("labios");
            $table->string("maxilar_superior");
            $table->string("deglucion");
            $table->string("lengua_deglucion");
            $table->string("habito_bucal");
            $table->string("denticion");
            $table->string("overjet");
            $table->string("higiene_bucal");
            $table->string("salud_dental");
            $table->string("relacion_molar");
            $table->string("relacion_canina");
            $table->string("amigdalas");
            $table->string("mordida_cruzada");
            $table->string("linea_sup");
            $table->string("linea_sup_mm")->nullable();
            $table->string("linea_inf");
            $table->string("linea_inf_mm")->nullable();
            $table->timestamps();

            $table->foreign("paciente_id")->on("pacientes")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('examen_clinicos');
    }
};
