<script setup>
import { useApp } from "@/composables/useApp";
import { computed, onMounted, ref } from "vue";
import { Head, usePage } from "@inertiajs/vue3";
import { useExamenClinicos } from "@/composables/examen_clinicos/useExamenClinicos";
const { getExamenClinicos } = useExamenClinicos();
const { setLoading } = useApp();

onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const obtenerFechaActual = () => {
    const fecha = new Date();
    const anio = fecha.getFullYear();
    const mes = String(fecha.getMonth() + 1).padStart(2, "0"); // Mes empieza desde 0
    const dia = String(fecha.getDate()).padStart(2, "0"); // Día del mes

    return `${anio}-${mes}-${dia}`;
};

const form = ref({
    examen_clinico_id: "todos",
    fecha_ini: obtenerFechaActual(),
    fecha_fin: obtenerFechaActual(),
});

const generando = ref(false);
const txtBtn = computed(() => {
    if (generando.value) {
        return "Generando Reporte...";
    }
    return "Generar Reporte";
});

const listExamenClinicos = ref([]);

const generarReporte = () => {
    generando.value = true;
    const url = route("reportes.r_examen_clinicos", form.value);
    window.open(url, "_blank");
    setTimeout(() => {
        generando.value = false;
    }, 500);
};

onMounted(async () => {
    listExamenClinicos.value = await getExamenClinicos();
});
</script>
<template>
    <Head title="Reporte Examenes clínicos"></Head>
    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:;">Inicio</a></li>
        <li class="breadcrumb-item active">Reportes > Examenes clínicos</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Reportes > Examenes clínicos</h1>
    <!-- END page-header -->
    <div class="row">
        <div class="col-md-6 mx-auto">
            <div class="card">
                <div class="card-body">
                    <form @submit.prevent="generarReporte">
                        <div class="row">
                            <div class="col-md-12">
                                <label>Seleccionar código examen</label>
                                <select
                                    :hide-details="
                                        form.errors?.examen_clinico_id ? false : true
                                    "
                                    :error="
                                        form.errors?.examen_clinico_id ? true : false
                                    "
                                    :error-messages="
                                        form.errors?.examen_clinico_id
                                            ? form.errors?.examen_clinico_id
                                            : ''
                                    "
                                    v-model="form.examen_clinico_id"
                                    class="form-control"
                                >
                                    <option value="todos">TODOS</option>
                                    <option
                                        v-for="item in listExamenClinicos"
                                        :value="item.id"
                                    >
                                        {{ item.cod }} - {{ item.paciente.full_name }} - {{ item.paciente.ci }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-12 mt-2">
                                <div class="row">
                                    <div class="col-md-6">
                                        Fecha inicio
                                        <input
                                            type="date"
                                            class="form-control"
                                            v-model="form.fecha_ini"
                                        />
                                    </div>
                                    <div class="col-md-6">
                                        Fecha fin
                                        <input
                                            type="date"
                                            class="form-control"
                                            v-model="form.fecha_fin"
                                        />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 text-center mt-3">
                                <button
                                    class="btn btn-primary"
                                    block
                                    @click="generarReporte"
                                    :disabled="generando"
                                    v-text="txtBtn"
                                ></button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>
