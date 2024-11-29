<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { usePacientes } from "@/composables/pacientes/usePacientes";
import { watch, ref, computed, defineEmits, onMounted, nextTick } from "vue";
const props = defineProps({
    open_dialog: {
        type: Boolean,
        default: false,
    },
    accion_dialog: {
        type: Number,
        default: 0,
    },
});

const { oPaciente, limpiarPaciente } = usePacientes();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
let form = useForm(oPaciente);
let switcheryInstance = null;
watch(
    () => props.open_dialog,
    async (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            const accesoCheckbox = $("#acceso");
            if (oPaciente.acceso == 1) {
                accesoCheckbox.prop("checked", false).trigger("click");
            } else {
                accesoCheckbox.prop("checked", true).trigger("click");
            }

            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oPaciente);
        }
    }
);
watch(
    () => props.accion_dialog,
    (newValue) => {
        accion.value = newValue;
    }
);

const { flash } = usePage().props;

const listTipos = ["DOCTOR GENERAL", "DOCTOR ESPECIALISTA"];
const listExpedido = [
    { value: "LP", label: "La Paz" },
    { value: "CB", label: "Cochabamba" },
    { value: "SC", label: "Santa Cruz" },
    { value: "CH", label: "Chuquisaca" },
    { value: "OR", label: "Oruro" },
    { value: "PT", label: "Potosi" },
    { value: "TJ", label: "Tarija" },
    { value: "PD", label: "Pando" },
    { value: "BN", label: "Beni" },
];

const foto = ref(null);

function cargaArchivo(e, key) {
    form[key] = null;
    form[key] = e.target.files[0];
}

const tituloDialog = computed(() => {
    return accion.value == 0
        ? `<i class="fa fa-plus"></i> Agregar Registro`
        : `<i class="fa fa-edit"></i> Detalle Registro`;
});

const initializeSwitcher = () => {
    const accesoCheckbox = document.getElementById("acceso");
    if (accesoCheckbox) {
        // Destruye la instancia previa si existe
        // Inicializa Switchery
        switcheryInstance = new Switchery(accesoCheckbox, {
            color: "#0078ff",
        });
    }
};

const emits = defineEmits(["cerrar-dialog", "envio-formulario"]);

watch(dialog, (newVal) => {
    if (!newVal) {
        emits("cerrar-dialog");
    }
});

const cerrarDialog = () => {
    dialog.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

onMounted(() => {
    initializeSwitcher();
});
</script>

<template>
    <div
        class="modal fade"
        :class="{
            show: dialog,
        }"
        id="modal-dialog-form"
        :style="{
            display: dialog ? 'block' : 'none',
        }"
    >
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h4 class="modal-title" v-html="tituloDialog"></h4>
                    <button
                        type="button"
                        class="btn-close"
                        @click="cerrarDialog()"
                    ></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4">
                            <label>Nombre(s)</label>
                            {{ form.nombre }}
                        </div>
                        <div class="col-md-4 mt-2">
                            <label>Ap. Paterno</label>
                            {{ form.paterno }}
                        </div>
                        <div class="col-md-4 mt-2">
                            <label>Ap. Materno</label>
                            {{ form.materno }}
                        </div>
                        <div class="col-md-4 mt-2">
                            <label>Cédula de Identidad</label>
                            {{ form.ci }}
                        </div>
                        <div class="col-md-4 mt-2">
                            <label>Extensión C.I.</label>
                            {{ form.ci_exp }}
                        </div>
                        <div class="col-md-4 mt-2">
                            <label>Fecha de nacimiento</label>
                            {{ form.fecha_nac }}
                        </div>
                        <div class="col-md-4 mt-2">
                            <label>Dirección Actual</label>
                            {{ form.dir }}
                        </div>
                        <div class="col-md-4 mt-2">
                            <label>Teléfono/Celular</label>
                            {{ form.fono }}
                        </div>
                        <div class="col-md-4 mt-2">
                            <label>Foto</label>
                            <img :src="form.url_foto" alt="Foto" />
                        </div>
                        <div class="col-md-4 mt-2">
                            <label
                                >Nombre completo del progenitor(Si es menor de
                                edad)</label
                            >
                            {{ form.nombre_proge }}
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-12">
                            <h4>CONTACTO PARA CUENTAS</h4>
                        </div>
                        <div class="col-md-4">
                            <label>Señor(a)</label>
                            {{ form.senior }}
                        </div>
                        <div class="col-md-4">
                            <label>Dirección completo</label>
                            {{ form.dir_s }}
                        </div>
                        <div class="col-md-4">
                            <label>Teléfono domicilio</label>
                            {{ form.fono_dom_s }}
                        </div>
                        <div class="col-md-4">
                            <label>Teléfono trabajo</label>
                            {{ form.fono_trab_s }}
                        </div>
                        <div class="col-md-4">
                            <label>Celular</label>
                            {{ form.cel_s }}
                        </div>
                        <div class="col-md-4">
                            <label>Fax</label>
                            {{ form.fax_s }}
                        </div>
                        <div class="col-md-4">
                            <label>Correo electrónico</label>
                            {{ form.correo_s }}
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-12">
                            <h4>CONSULTA</h4>
                        </div>
                        <div class="col-12">
                            <div
                                class="row fila"
                                v-for="(item, index) in form.consultas"
                                :class="[index % 2 == 0 ? 'bg1' : 'bg2']"
                            >
                                <div class="col-md-4">
                                    <label>Doctor general</label>
                                    {{ item.general.full_name }}
                                </div>
                                <div class="col-md-4">
                                    <label
                                        >Doctor especialist*</label
                                    >
                                    {{ item.especialista.full_name }}
                                </div>
                                <div class="col-md-4">
                                    <label>Motivo de Consulta</label>
                                    {{ item.motivo }}
                                </div>
                            </div>
                        </div>
                        <div class="col-12">
                            <hr />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <label
                                >¿A quién debemos agradecer que hayasido
                                referido?</label
                            >
                            {{ form.agradecer }}
                        </div>
                        <div class="col-md-6">
                            <label>Nombres y edades de hermanos</label>
                            {{ form.nom_edad_hmnos }}
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <a
                        href="javascript:;"
                        class="btn btn-white"
                        @click="cerrarDialog()"
                        ><i class="fa fa-times"></i> Cerrar</a
                    >
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
label {
    display: block;
    font-weight: bold;
}

.col-md-4 {
    margin-bottom: 10px;
}
img {
    max-width: 100px;
}

.fila {
    position: relative;
    padding-bottom: 15px;
    padding-top: 10px;
}
.row.bg1 {
    background-color: rgb(234, 243, 250);
}
.row.bg2 {
    background-color: rgb(234, 255, 237);
}
</style>
