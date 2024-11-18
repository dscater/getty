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
        Schema::create('consultas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("paciente_id");
            $table->unsignedBigInteger("general_id");
            $table->unsignedBigInteger("especialista_id");
            $table->text("motivo");
            $table->timestamps();

            $table->foreign("paciente_id")->on("pacientes")->references("id");
            $table->foreign("general_id")->on("users")->references("id");
            $table->foreign("especialista_id")->on("users")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('consultas');
    }
};
