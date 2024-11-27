<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Symfony\Component\Process\Exception\ProcessFailedException;
use Symfony\Component\Process\Process;

class Image3DController extends Controller
{
    public function processImages(Request $request)
    {
        $request->validate([
            'images.*' => 'required|image|mimes:jpg,jpeg,png,webp|min:1',
        ]);

        // Cargar imágenes
        $images = [];
        foreach ($request->file('images') as $image) {
            $images[] = $image;
        }

        // Llamar al script externo para reconstrucción 3D
        $outputPath = public_path('imgs/examen_clinicos/');
        $modelo = $this->run3DScript($images, $outputPath);

        return response()->json([
            'success' => true,
            'modelo' => asset("imgs/examen_clinicos/" . $modelo),
        ]);
    }

    private function run3DScript(array $images, string $outputPath)
    {
        // Crear comando para ejecutar COLMAP o script de reconstrucción
        $imagesList = implode(' ', $images);
        $modelo = time() . '.obj';
        $process = new Process([
            'python3',
            public_path('scripts/reconstruct_3d.py'), // Ruta del script Python
            $imagesList,
            $outputPath,
            $modelo
        ]);

        $process->setTimeout(3600); // 1 hora como límite
        $process->run();

        if (!$process->isSuccessful()) {
            throw new ProcessFailedException($process);
        }

        return $process->getOutput();
    }
}
