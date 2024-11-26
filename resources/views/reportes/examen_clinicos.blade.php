<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>ExamenClinicos</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 0.5cm;
            margin-bottom: 0.5cm;
            margin-left: 1.5cm;
            margin-right: 0.5cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: 20px;
            page-break-before: avoid;
        }

        table thead tr th,
        tbody tr td {
            padding: 3px;
            word-wrap: break-word;
            text-align: center;
        }

        table thead tr th {
            font-size: 7pt;
        }

        table tbody tr td {
            font-size: 7pt;
        }

        .titleInfo {
            font-size: 0.7em;
        }

        table tbody tr:nth-child(odd) td {
            font-weight: bold;
            font-size: 7.5pt;
        }


        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            height: 100px;
            top: -20px;
            left: 0px;
        }

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 0PX;
            margin-bottom: 15px;
            text-align: center;
            font-size: 14pt;
        }

        .texto {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: bold;
            font-size: 1.1em;
        }

        .fecha {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: normal;
            font-size: 0.85em;
        }

        .total {
            text-align: right;
            padding-right: 15px;
            font-weight: bold;
        }

        table {
            width: 100%;
        }

        table thead {
            background: rgb(236, 236, 236)
        }

        tr {
            page-break-inside: avoid !important;
        }

        .centreado {
            padding-left: 0px;
            text-align: center;
        }

        .datos {
            margin-left: 15px;
            border-top: solid 1px;
            border-collapse: collapse;
            width: 250px;
        }

        .txt {
            font-weight: bold;
            text-align: right;
            padding-right: 5px;
        }

        .txt_center {
            font-weight: bold;
            text-align: center;
        }

        .cumplimiento {
            position: absolute;
            width: 150px;
            right: 0px;
            top: 86px;
        }

        .b_top {
            border-top: solid 1px black;
        }

        .gray {
            background: rgb(202, 202, 202);
        }

        .bg-principal {
            background: #1867C0;
            color: white;
        }

        .izquierda {
            text-align: left;
        }

        .img_celda img {
            width: 45px;
        }

        .nueva_pagina {
            page-break-after: always;
        }
    </style>
</head>

<body>
    @inject('configuracion', 'App\Models\Configuracion')
    @php
        $contador = 0;
    @endphp
    @foreach ($examen_clinicos as $examen_clinico)
        @php
            $contador++;
        @endphp
        <div class="encabezado">
            <div class="logo">
                <img src="{{ $configuracion->first()->logo_b64 }}">
            </div>
            <h2 class="titulo">
                {{ $configuracion->first()->razon_social }}
            </h2>
            <h4 class="texto">EXÁMENES CLÍNICOS DEL PACIENTE</h4>
            <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
        </div>


        <table>
            <tbody>
                <tr>
                    <td>Código</td>
                    <td class="izquierda">Paciente</td>
                </tr>
                <tr>
                    <td>{{ $examen_clinico->cod }}</td>
                    <td class="izquierda">{{ $examen_clinico->paciente->full_name }}</td>
                </tr>
            </tbody>
        </table>

        <!-- info 1 -->
        <h4 class="titleInfo">EXAMEN CLÍNICO EXTRAORAL</h4>
        <table>
            <tbody>
                <tr>
                    <td>SIMETRÍA FACIAL</td>
                    <td>DICCIÓN</td>
                    <td>PATRÓN FACIAL</td>
                    <td>RESPIRACIÓN</td>
                </tr>
                <tr>
                    <td>{{ $examen_clinico->simetria_facial }}</td>
                    <td>{{ $examen_clinico->diccion }}</td>
                    <td>{{ $examen_clinico->patron_facial }}</td>
                    <td>{{ $examen_clinico->respiracion }}</td>
                </tr>
                <tr>
                    <td>PERFIL</td>
                    <td>RELACIÓN LABIAL</td>
                    <td>LABIOS</td>
                    <td>MAXILAR SUPERIOR</td>
                </tr>
                <tr>
                    <td>{{ $examen_clinico->perfil }}</td>
                    <td>{{ $examen_clinico->relacion_labial }}</td>
                    <td>{{ $examen_clinico->labios }}</td>
                    <td>{{ $examen_clinico->maxilar_superior }}</td>
                </tr>
                <tr>
                    <td>DEGLUCIÓN</td>
                    <td>LENGUA Y DEGLUCIÓN</td>
                    <td>HABITOS BUCALES</td>
                    <td></td>
                </tr>
                <tr>
                    <td>{{ $examen_clinico->deglucion }}</td>
                    <td>{{ $examen_clinico->lengua_deglucion }}</td>
                    <td>{{ $examen_clinico->habito_bucal }}</td>
                    <td></td>
                </tr>
            </tbody>
        </table>
        <!-- info 2 -->
        <h4 class="titleInfo">EXAMEN CLÍNICO INTRAORAL</h4>
        <table>
            <tbody>
                <tr>
                    <td>DENTICIÓN</td>
                    <td>OVERJET</td>
                    <td>HIGIENE BUCAL</td>
                    <td>SALUD DENTAL</td>
                </tr>
                <tr>
                    <td>{{ $examen_clinico->denticion }}</td>
                    <td>{{ $examen_clinico->overjet }}</td>
                    <td>{{ $examen_clinico->higiene_bucal }}</td>
                    <td>{{ $examen_clinico->salud_dental }}</td>
                </tr>
                <tr>
                    <td>RELACIÓN MOLAR</td>
                    <td>RELACIÓN CANINA</td>
                    <td>AMIGDALAS</td>
                    <td>MORDIDA CRUZADA</td>
                </tr>
                <tr>
                    <td>{{ $examen_clinico->relacion_molar }}</td>
                    <td>{{ $examen_clinico->relacion_canina }}</td>
                    <td>{{ $examen_clinico->amigdalas }}</td>
                    <td>{{ $examen_clinico->mordida_cruzada }}</td>
                </tr>
                <tr>
                    <td>SUPERIOR</td>
                    <td>MM SUPERIOR</td>
                    <td>INFERIOR</td>
                    <td>MM INFERIOR</td>
                </tr>
                <tr>
                    <td>{{ $examen_clinico->linea_sup }}</td>
                    <td>{{ $examen_clinico->linea_sup_mm }}</td>
                    <td>{{ $examen_clinico->linea_inf }}</td>
                    <td>{{ $examen_clinico->linea_inf_mm }}</td>
                </tr>
            </tbody>
        </table>
        <!-- info 3 -->
        <table>
            <tbody>
                <tr>
                    <td class="izquierda">Observación</td>
                </tr>
                <tr>
                    <td class="izquierda">{{ $examen_clinico->observacion }}</td>
                </tr>
            </tbody>
        </table>

        @if ($contador < count($examen_clinicos))
            <div class="nueva_pagina"></div>
        @endif
    @endforeach

</body>

</html>
