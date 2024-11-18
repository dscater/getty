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
        Schema::create('antecedente_dentals', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("paciente_id");
            $table->string("lesiones_cara");
            $table->string("ch_pulgar_pasado");
            $table->string("ch_dedo_actual");
            $table->string("respiracion_bucal");
            $table->string("muerde_unia");
            $table->string("desgaste_dientes");
            $table->string("falta_permanente");
            $table->string("falta_alguno");
            $table->string("falta_alguno_d");
            $table->string("problema_cabeza");
            $table->string("examinado");
            $table->string("examinado_d", 300);
            $table->string("aparatos");
            $table->string("aparatos_d", 300);
            $table->date("fecha_registro");
            $table->timestamps();
            $table->foreign("paciente_id")->on("pacientes")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('antecedente_dentals');
    }
};
