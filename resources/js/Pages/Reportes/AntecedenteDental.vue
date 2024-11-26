<script setup>
import { useApp } from "@/composables/useApp";
import { computed, onMounted, ref } from "vue";
import { Head, usePage } from "@inertiajs/vue3";
import { usePacientes } from "@/composables/pacientes/usePacientes";
const { getPacientes } = usePacientes();
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
    paciente_id: "todos",
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

const listPacientes = ref([]);

const generarReporte = () => {
    generando.value = true;
    const url = route("reportes.r_antecedente_dental", form.value);
    window.open(url, "_blank");
    setTimeout(() => {
        generando.value = false;
    }, 500);
};

onMounted(async () => {
    listPacientes.value = await getPacientes();
});
</script>
<template>
    <Head title="Reporte Antecedente dental"></Head>
    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:;">Inicio</a></li>
        <li class="breadcrumb-item active">Reportes > Antecedente dental</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Reportes > Antecedente dental</h1>
    <!-- END page-header -->
    <div class="row">
        <div class="col-md-6 mx-auto">
            <div class="card">
                <div class="card-body">
                    <form @submit.prevent="generarReporte">
                        <div class="row">
                            <div class="col-md-12">
                                <label>Seleccionar paciente</label>
                                <select
                                    :hide-details="
                                        form.errors?.paciente_id ? false : true
                                    "
                                    :error="
                                        form.errors?.paciente_id ? true : false
                                    "
                                    :error-messages="
                                        form.errors?.paciente_id
                                            ? form.errors?.paciente_id
                                            : ''
                                    "
                                    v-model="form.paciente_id"
                                    class="form-control"
                                >
                                    <option value="todos">TODOS</option>
                                    <option
                                        v-for="item in listPacientes"
                                        :value="item.id"
                                    >
                                        {{ item.full_name }}
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
