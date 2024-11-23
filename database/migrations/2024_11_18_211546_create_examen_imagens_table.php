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
        Schema::create('examen_imagens', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("examen_clinico_id");
            $table->string("imagen");
            $table->string("ext");
            $table->timestamps();

            $table->foreign("examen_clinico_id")->on("examen_clinicos")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('examen_imagens');
    }
};
