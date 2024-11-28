<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>AntecedenteDental</title>
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

        .bold {
            font-weight: bold;
        }

        .celdainfo {
            border: solid 0.8px black;
            border-radius: 2px;
        }

        .textoinfo {
            padding: 0px;
        }

        .tableinfos {
            border-collapse: separate;
            border-spacing: 20px 0px;
        }

        .boder_bottom {
            font-size: 9pt;
            margin-left: 20px;
            border-bottom: solid 1px black;
            padding-bottom: 0px;
            margin-bottom: 0px;
            width: 158px;
        }
    </style>
</head>

<body>
    @inject('configuracion', 'App\Models\Configuracion')
    @php
        $contador = 0;
    @endphp
    @foreach ($antecedente_dentals as $antecedente_dental)
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
            <h4 class="texto">ANTECEDENTES DENTALES DEL PACIENTE</h4>
            <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
        </div>


        <table class="tableinfos">
            <tbody>
                <tr>
                    <td class="izquierda bold textoinfo">PACIENTE</td>
                </tr>
                <tr>
                    <td class="izquierda celdainfo">{{ $antecedente_dental->paciente->full_name }}</td>
                </tr>
            </tbody>
        </table>

        <!-- info 1 -->
        <table>
            <tbody>
                <tr>
                    <td colspan="3" class="izquierda bold">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;¿A TENIDO ALGUNA VEZ LESIONES EN LA CARA, EN LA
                        BOCA O EN LOS DIENTES?</td>
                    <td class="celdainfo izquierda">{{ $antecedente_dental->lesiones_cara }}</td>
                    <td></td>
                </tr>
            </tbody>
        </table>

        <h4 class="bold izquierda boder_bottom">*OTRAS INFORMACIONES:</h4>
        <table class="tableinfos">
            <tbody>
                <tr>
                    <td class="bold">CHUPARSE EL PULGAR U OTRO DEDO (EN EL
                        PASDO)</td>
                    <td class="bold">CHUPARSE EL PULGAR Y OTRO DEDO
                        (ACTUALMENTE)
                    </td>
                    <td class="bold">RESPIRACIÓN BUCAL</td>
                    <td class="bold">¿SE MUERDE LAS UÑAS O LOS LABIOS EN LA
                        ACTUALIDAD?</td>
                </tr>
                <tr>
                    <td class="celdainfo">{{ $antecedente_dental->ch_pulgar_pasado }}</td>
                    <td class="celdainfo">{{ $antecedente_dental->ch_dedo_actual }}</td>
                    <td class="celdainfo">{{ $antecedente_dental->respiracion_bucal }}</td>
                    <td class="celdainfo">{{ $antecedente_dental->muerde_unia }}</td>
                </tr>
                <tr>
                    <td class="bold">¿DESGASTA O RECHINA LOS DIENTES?</td>
                    <td class="bold">¿SE LE HA INFORMADO ALGUNA VEZ QUE LE FALTA UN
                        DIENTE PERMANENTE?</td>
                    <td class="bold">¿SE LE HA INFORMADO ALGUNA VEZ QUE LE FALTA UN
                        DIENTE PERMANENTE O TENGA ALGUNO DEMAS?</td>
                    <td class="bold">EN CASO AFIRMATIVO CONCRETE</td>
                </tr>
                <tr>
                    <td class="celdainfo">{{ $antecedente_dental->desgaste_dientes }}</td>
                    <td class="celdainfo">{{ $antecedente_dental->falta_permanente }}</td>
                    <td class="celdainfo">{{ $antecedente_dental->falta_alguno }}</td>
                    <td class="celdainfo">{{ $antecedente_dental->falta_alguno_d }}</td>
                </tr>
                <tr>
                    <td class="bold">¿TIENE ALGÚN ANTECEDENTE DE PROBLEMAS DE
                        CABEZA, CUELLO O ARTICULACIÓN DE LA
                        MANDIBULA?</td>
                    <td class="bold">¿HA SIDO EXAMINADO POR ALGÚN
                        ORTODOCISTA?</td>
                    <td class="bold">EN CASO AFIRMATIVO, CUANDO?</td>
                    <td class="bold">¿HA LLEVADO ALGUNA VEZ APARATOS DE
                        ORTODONCIA?</td>
                </tr>
                <tr>
                    <td class="celdainfo">{{ $antecedente_dental->problema_cabeza }}</td>
                    <td class="celdainfo">{{ $antecedente_dental->examinado }}</td>
                    <td class="celdainfo">{{ $antecedente_dental->examinado_d }}</td>
                    <td class="celdainfo">{{ $antecedente_dental->aparatos }}</td>
                </tr>
                <tr>
                    <td class="bold">EN CASO AFIRMATIVO, CUANDO?</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="celdainfo">
                        @if ($antecedente_dental->aparatos_d)
                            {{ $antecedente_dental->aparatos_d }}
                        @else
                            &nbsp;
                        @endif
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>

        @if ($contador < count($antecedente_dentals))
            <div class="nueva_pagina"></div>
        @endif
    @endforeach

</body>

</html>
