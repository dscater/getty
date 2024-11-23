<script setup>
import { useApp } from "@/composables/useApp";
import { Head, Link, router } from "@inertiajs/vue3";
import { useExamenClinicos } from "@/composables/examen_clinicos/useExamenClinicos";
import { initDataTable } from "@/composables/datatable.js";
import { ref, onMounted, onBeforeUnmount } from "vue";
import PanelToolbar from "@/Components/PanelToolbar.vue";
import Detalle from "./Detalle.vue";
const { setLoading } = useApp();
onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const {
    getExamenClinicos,
    setExamenClinico,
    limpiarExamenClinico,
    deleteExamenClinico,
} = useExamenClinicos();

const columns = [
    {
        title: "",
        data: "cod",
    },
    {
        title: "",
        data: "paciente.url_foto",
        render: function (data, type, row) {
            return `<img src="${data}" class="rounded h-30px my-n1 mx-n1"/>`;
        },
    },
    {
        title: "NOMBRE PACIENTE",
        data: "paciente.full_name",
    },
    {
        title: "C.I.",
        data: "paciente.full_ci",
    },
    {
        title: "DIRECCIÓN",
        data: "paciente.dir",
    },
    {
        title: "TELÉFONO",
        data: "paciente.fono",
    },
    {
        title: "ACCIONES",
        data: null,
        render: function (data, type, row) {
            return `
                <button class="mx-0 rounded-0 btn btn-primary detalle" data-id="${
                    row.id
                }"><i class="fa fa-id-card"></i></button>
                <button class="mx-0 rounded-0 btn btn-warning editar" data-id="${
                    row.id
                }"><i class="fa fa-edit"></i></button>
                <button class="mx-0 rounded-0 btn btn-danger eliminar"
                 data-id="${row.id}" 
                 data-nombre="${row.cod} | ${row.paciente.full_name}" 
                 data-url="${route(
                     "examen_clinicos.destroy",
                     row.id
                 )}"><i class="fa fa-trash"></i></button>
            `;
        },
    },
];
const loading = ref(false);
const accion_dialog = ref(0);
const open_dialog = ref(false);
const accion_dialog_det = ref(0);
const open_dialog_det = ref(false);

const agregarRegistro = () => {
    limpiarExamenClinico();
    accion_dialog.value = 0;
    open_dialog.value = true;
};

const accionesRow = () => {
    // detalle
    $("#table-examen_clinico").on("click", "button.detalle", function (e) {
        e.preventDefault();
        let id = $(this).attr("data-id");
        axios.get(route("examen_clinicos.show", id)).then((response) => {
            setExamenClinico(response.data, true);
            accion_dialog_det.value = 1;
            open_dialog_det.value = true;
        });
    });
    // editar
    $("#table-examen_clinico").on("click", "button.editar", function (e) {
        e.preventDefault();
        let id = $(this).attr("data-id");
        router.get(route("examen_clinicos.edit", id));
    });
    // eliminar
    $("#table-examen_clinico").on("click", "button.eliminar", function (e) {
        e.preventDefault();
        let nombre = $(this).attr("data-nombre");
        let id = $(this).attr("data-id");
        Swal.fire({
            title: "¿Quierés eliminar este registro?",
            html: `<strong>${nombre}</strong>`,
            showCancelButton: true,
            confirmButtonColor: "#B61431",
            confirmButtonText: "Si, eliminar",
            cancelButtonText: "No, cancelar",
            denyButtonText: `No, cancelar`,
        }).then(async (result) => {
            /* Read more about isConfirmed, isDenied below */
            if (result.isConfirmed) {
                let respuesta = await deleteExamenClinico(id);
                if (respuesta && respuesta.sw) {
                    updateDatatable();
                }
            }
        });
    });
};

var datatable = null;
const datatableInitialized = ref(false);
const updateDatatable = () => {
    datatable.ajax.reload();
};

onMounted(async () => {
    datatable = initDataTable(
        "#table-examen_clinico",
        columns,
        route("examen_clinicos.api")
    );
    datatableInitialized.value = true;
    accionesRow();
});
onBeforeUnmount(() => {
    if (datatable) {
        datatable.clear();
        datatable.destroy(false); // Destruye la instancia del DataTable
        datatable = null;
        datatableInitialized.value = false;
    }
});
</script>
<template>
    <Head title="Examen Clínico"></Head>

    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:;">Inicio</a></li>
        <li class="breadcrumb-item active">Examen Clínico</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Examen Clínico</h1>
    <!-- END page-header -->

    <div class="row">
        <div class="col-md-12">
            <!-- BEGIN panel -->
            <div class="panel panel-inverse">
                <!-- BEGIN panel-heading -->
                <div class="panel-heading">
                    <h4 class="panel-title btn-nuevo">
                        <Link
                            :href="route('examen_clinicos.create')"
                            class="btn btn-primary d-inline-block"
                        >
                            <i class="fa fa-plus"></i> Nuevo
                        </Link>
                    </h4>
                    <panel-toolbar
                        :mostrar_loading="loading"
                        @loading="updateDatatable"
                    />
                </div>
                <!-- END panel-heading -->
                <!-- BEGIN panel-body -->
                <div class="panel-body">
                    <table
                        id="table-examen_clinico"
                        width="100%"
                        class="table table-striped table-bordered align-middle text-nowrap tabla_datos"
                    >
                        <thead>
                            <tr>
                                <th width="2%"></th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th width="2%"></th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
                <!-- END panel-body -->
            </div>
            <!-- END panel -->
        </div>
    </div>
    <Detalle
        :open_dialog="open_dialog_det"
        :accion_dialog="accion_dialog_det"
        @cerrar-dialog="open_dialog_det = false"
    ></Detalle>
</template>
