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
            cargarGenerals();
            cargarEspecialistas();

            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oPaciente);

            if (form.id == 0) {
                agregarFila();
            }
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

const listGenerals = ref([]);
const listEspecialistas = ref([]);

const foto = ref(null);

function cargaArchivo(e, key) {
    form[key] = null;
    form[key] = e.target.files[0];
}

const tituloDialog = computed(() => {
    return accion.value == 0
        ? `<i class="fa fa-plus"></i> Agregar Registro`
        : `<i class="fa fa-edit"></i> Editar Registro`;
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
const enviarFormulario = () => {
    let url =
        form["_method"] == "POST"
            ? route("pacientes.store")
            : route("pacientes.update", form.id);

    form.post(url, {
        preserveScroll: true,
        forceFormData: true,
        onSuccess: () => {
            dialog.value = false;
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            limpiarPaciente();
            emits("envio-formulario");
        },
        onError: (err) => {
            console.log("ERROR");
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.error
                        ? err.error
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
        },
    });
};

const emits = defineEmits(["cerrar-dialog", "envio-formulario"]);
const cargarGenerals = () => {
    axios
        .get(route("usuarios.byTipo", { tipo: "DOCTOR GENERAL" }))
        .then((response) => {
            listGenerals.value = response.data.usuarios;
        });
};

const cargarEspecialistas = () => {
    axios
        .get(route("usuarios.byTipo", { tipo: "DOCTOR ESPECIALISTA" }))
        .then((response) => {
            listEspecialistas.value = response.data.usuarios;
        });
};

watch(dialog, (newVal) => {
    if (!newVal) {
        emits("cerrar-dialog");
    }
});

const cerrarDialog = () => {
    dialog.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

const agregarFila = () => {
    form.consultas.push({
        id: 0,
        paciente_id: "",
        general_id: "",
        especialista_id: "",
        motivo: "",
    });
};

const eliminarFila = (index) => {
    let id = form.consultas[index].id;
    if (id != 0) {
        form.eliminados.push(id);
    }
    form.consultas.splice(index, 1);
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
                    <form @submit.prevent="enviarFormulario()">
                        <div class="row">
                            <div class="col-md-4">
                                <label>Nombre(s)*</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.nombre,
                                    }"
                                    v-model="form.nombre"
                                />
                                <ul
                                    v-if="form.errors?.nombre"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.nombre }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Ap. Paterno*</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.paterno,
                                    }"
                                    v-model="form.paterno"
                                />

                                <ul
                                    v-if="form.errors?.paterno"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.paterno }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Ap. Materno</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.materno,
                                    }"
                                    v-model="form.materno"
                                />

                                <ul
                                    v-if="form.errors?.materno"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.materno }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Cédula de Identidad</label>
                                <input
                                    type="number"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.ci,
                                    }"
                                    v-model="form.ci"
                                />

                                <ul
                                    v-if="form.errors?.ci"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.ci }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Extensión C.I.</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error': form.errors?.ci_exp,
                                    }"
                                    v-model="form.ci_exp"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option
                                        v-for="item in listExpedido"
                                        :value="item.value"
                                    >
                                        {{ item.label }}
                                    </option>
                                </select>

                                <ul
                                    v-if="form.errors?.ci_exp"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.ci_exp }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Fecha de nacimiento</label>
                                <input
                                    type="date"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.fecha_nac,
                                    }"
                                    v-model="form.fecha_nac"
                                />

                                <ul
                                    v-if="form.errors?.fecha_nac"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.fecha_nac }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Dirección Actual</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.dir,
                                    }"
                                    v-model="form.dir"
                                />

                                <ul
                                    v-if="form.errors?.dir"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.dir }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Teléfono/Celular</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.fono,
                                    }"
                                    v-model="form.fono"
                                />

                                <ul
                                    v-if="form.errors?.fono"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.fono }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Foto</label>
                                <input
                                    type="file"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.foto,
                                    }"
                                    ref="foto"
                                    @change="cargaArchivo($event, 'foto')"
                                />

                                <ul
                                    v-if="form.errors?.foto"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.foto }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label
                                    >Nombre completo del progenitor(Si es menor
                                    de edad)</label
                                >
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.nombre_proge,
                                    }"
                                    v-model="form.nombre_proge"
                                />

                                <ul
                                    v-if="form.errors?.nombre_proge"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.nombre_proge }}
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-12">
                                <h4>CONTACTO PARA CUENTAS</h4>
                            </div>
                            <div class="col-md-4">
                                <label>Señor(a)</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.senior,
                                    }"
                                    v-model="form.senior"
                                />
                                <ul
                                    v-if="form.errors?.senior"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.senior }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <label>Dirección completo</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.dir_s,
                                    }"
                                    v-model="form.dir_s"
                                />
                                <ul
                                    v-if="form.errors?.dir_s"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.dir_s }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <label>Teléfono domicilio</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.fono_dom_s,
                                    }"
                                    v-model="form.fono_dom_s"
                                />
                                <ul
                                    v-if="form.errors?.fono_dom_s"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.fono_dom_s }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <label>Teléfono trabajo</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.fono_trab_s,
                                    }"
                                    v-model="form.fono_trab_s"
                                />
                                <ul
                                    v-if="form.errors?.fono_trab_s"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.fono_trab_s }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <label>Celular</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.cel_s,
                                    }"
                                    v-model="form.cel_s"
                                />
                                <ul
                                    v-if="form.errors?.cel_s"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.cel_s }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <label>Fax</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.fax_s,
                                    }"
                                    v-model="form.fax_s"
                                />
                                <ul
                                    v-if="form.errors?.fax_s"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.fax_s }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <label>Correo electrónico</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.correo_s,
                                    }"
                                    v-model="form.correo_s"
                                />
                                <ul
                                    v-if="form.errors?.correo_s"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.correo_s }}
                                    </li>
                                </ul>
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
                                        <label
                                            >Seleccionar doctor general*</label
                                        >
                                        <select
                                            class="form-select"
                                            v-model="item.general_id"
                                        >
                                            <option value="">
                                                - Seleccione -
                                            </option>
                                            <option
                                                v-for="item in listGenerals"
                                                :value="item.id"
                                            >
                                                {{ item.full_name }}
                                            </option>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <label
                                            >Seleccionar doctor
                                            especialista*</label
                                        >
                                        <select
                                            class="form-select"
                                            v-model="item.especialista_id"
                                        >
                                            <option value="">
                                                - Seleccione -
                                            </option>
                                            <option
                                                v-for="item in listEspecialistas"
                                                :value="item.id"
                                            >
                                                {{ item.full_name }}
                                            </option>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <label>Motivo de Consulta*</label>
                                        <textarea
                                            class="form-control"
                                            rows="1"
                                            v-model="item.motivo"
                                        ></textarea>
                                    </div>
                                    <button
                                        type="button"
                                        class="btn btn-danger btn-sm btn_quitar"
                                        @click.prevent="eliminarFila(index)"
                                    >
                                        <i class="fa fa-times"></i>
                                    </button>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <button
                                            type="button"
                                            class="btn btn-outline-primary w-100 btn-sm"
                                            @click="agregarFila"
                                        >
                                            <i class="fa fa-plus"
                                                >Agregar consulta</i
                                            >
                                        </button>
                                    </div>
                                    <div
                                        class="col-12"
                                        v-if="
                                            form.errors &&
                                            form.errors?.consultas
                                        "
                                    >
                                        <p
                                            class="text-danger w-100 text-center"
                                        >
                                            {{ form.errors?.consultas }}
                                        </p>
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
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.agradecer,
                                    }"
                                    v-model="form.agradecer"
                                />
                                <ul
                                    v-if="form.errors?.agradecer"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.agradecer }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <label>Nombres y edades de hermanos</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.nom_edad_hmnos,
                                    }"
                                    v-model="form.nom_edad_hmnos"
                                />
                                <ul
                                    v-if="form.errors?.nom_edad_hmnos"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.nom_edad_hmnos }}
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <a
                        href="javascript:;"
                        class="btn btn-white"
                        @click="cerrarDialog()"
                        ><i class="fa fa-times"></i> Cerrar</a
                    >
                    <button
                        type="button"
                        @click="enviarFormulario()"
                        class="btn btn-primary"
                    >
                        <i class="fa fa-save"></i>
                        Guardar
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>
<style scoped>
.fila {
    position: relative;
    padding-bottom: 15px;
    padding-top: 10px;
}
.btn_quitar {
    position: absolute;
    top: 0px;
    right: 0;
    width: 32px;
    padding: 5px 0px;
    font-size: 0.8em;
}
.row.bg1 {
    background-color: rgb(234, 243, 250);
}
.row.bg2 {
    background-color: rgb(234, 255, 237);
}
</style>
