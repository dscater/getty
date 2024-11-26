<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useAntecedenteDentals } from "@/composables/antecedente_dentals/useAntecedenteDentals";
import { usePacientes } from "@/composables/pacientes/usePacientes";
import { ref, onMounted, onBeforeUnmount } from "vue";

const propsPage = defineProps({
    detalle: {
        type: Boolean,
        default: false,
    },
});

const { oAntecedenteDental, limpiarAntecedenteDental } =
    useAntecedenteDentals();
const { getPacientes } = usePacientes();
let form = useForm(oAntecedenteDental);
const listPacientes = ref([]);

const info1 = ref(true);

const { flash, url_assets } = usePage().props;
const enviando = ref(false);
const enviarFormulario = () => {
    enviando.value = true;
    let url =
        form["_method"] == "POST"
            ? route("antecedente_dentals.store")
            : route("antecedente_dentals.update", form.id);

    form.post(url, {
        preserveScroll: true,
        forceFormData: true,
        onSuccess: () => {
            enviando.value = false;
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            limpiarAntecedenteDental();
        },
        onError: (err) => {
            enviando.value = false;
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

const cargarPacientes = async () => {
    if (form.id != 0) {
        listPacientes.value = await getPacientes({
            sin_antecedente: true,
            id: form.paciente_id,
        });
    } else {
        listPacientes.value = await getPacientes({
            sin_antecedente: true,
        });
    }
};

onMounted(() => {
    if (form.id != 0) {
    }
    cargarPacientes();
});

onBeforeUnmount(() => {});
</script>

<template>
    <form @submit.prevent="enviarFormulario()" v-if="!propsPage.detalle">
        <div class="row">
            <div class="col-12 mb-3">
                <select class="form-select" v-model="form.paciente_id">
                    <option value="">- Seleccionar Paciente -</option>
                    <option v-for="item in listPacientes" :value="item.id">
                        {{ item.full_name }}
                    </option>
                </select>
                <ul
                    v-if="form.errors?.paciente_id"
                    class="parsley-errors-list filled"
                >
                    <li class="parsley-required">
                        {{ form.errors?.paciente_id }}
                    </li>
                </ul>
            </div>
            <!-- info 1 -->
            <div class="col-12">
                <div class="card">
                    <div
                        class="bg-primary text-white card-header header_info"
                        @click="info1 = !info1"
                    >
                        ANTECEDENTES DENTALES DEL PACIENTE
                        <i
                            class="fa"
                            :class="info1 ? 'fa-minus' : 'fa-plus'"
                        ></i>
                    </div>
                    <div
                        class="card-body collapse"
                        :class="[info1 ? 'show' : '']"
                    >
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label
                                    >¿A TENIDO ALGUNA VEZ LESIONES EN LA CARA,
                                    EN LA BOCA O EN LOS DIENTES?</label
                                >
                                <select
                                    class="form-select"
                                    v-model="form.lesiones_cara"
                                >
                                    <option
                                        v-for="item in ['SI', 'NO']"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-12">
                                <h4 class="font-weight-bold border-bottom">
                                    *OTRAS INFORMACIONES:
                                </h4>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label
                                    >CHUPARSE EL PULGAR U OTRO DEDO (EN EL
                                    PASDO)</label
                                >
                                <select
                                    class="form-select"
                                    v-model="form.ch_pulgar_pasado"
                                >
                                    <option
                                        v-for="item in ['SI', 'NO']"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label
                                    >CHUPARSE EL PULGAR Y OTRO DEDO
                                    (ACTUALMENTE)</label
                                >
                                <select
                                    class="form-select"
                                    v-model="form.ch_dedo_actual"
                                >
                                    <option
                                        v-for="item in ['SI', 'NO']"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>RESPIRACIÓN BUCAL</label>
                                <select
                                    class="form-select"
                                    v-model="form.respiracion_bucal"
                                >
                                    <option
                                        v-for="item in ['SI', 'NO']"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label
                                    >¿SE MUERDE LAS UÑAS O LOS LABIOS EN LA
                                    ACTUALIDAD?</label
                                >
                                <select
                                    class="form-select"
                                    v-model="form.muerde_unia"
                                >
                                    <option
                                        v-for="item in ['SI', 'NO']"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>¿DESGASTA O RECHINA LOS DIENTES?</label>
                                <select
                                    class="form-select"
                                    v-model="form.desgaste_dientes"
                                >
                                    <option
                                        v-for="item in ['SI', 'NO']"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label
                                    >¿SE LE HA INFORMADO ALGUNA VEZ QUE LE FALTA
                                    UN DIENTE PERMANENTE?</label
                                >
                                <select
                                    class="form-select"
                                    v-model="form.falta_permanente"
                                >
                                    <option
                                        v-for="item in ['SI', 'NO']"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label
                                    >¿SE LE HA INFORMADO ALGUNA VEZ QUE LE FALTA
                                    UN DIENTE PERMANENTE O TENGA ALGUNO
                                    DEMAS?</label
                                >
                                <select
                                    class="form-select"
                                    v-model="form.falta_alguno"
                                >
                                    <option
                                        v-for="item in ['SI', 'NO']"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div
                                class="col-md-4 mb-3"
                                v-if="form.falta_alguno == 'SI'"
                            >
                                <label>EN CASO AFIRMATIVO CONCRETE</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.falta_alguno_d"
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label
                                    >¿TIENE ALGÚN ANTECEDENTE DE PROBLEMAS DE
                                    CABEZA, CUELLO O ARTICULACIÓN DE LA
                                    MANDIBULA?</label
                                >
                                <select
                                    class="form-select"
                                    v-model="form.problema_cabeza"
                                >
                                    <option
                                        v-for="item in ['SI', 'NO']"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label
                                    >¿HA SIDO EXAMINADO POR ALGÚN
                                    ORTODOCISTA?</label
                                >
                                <select
                                    class="form-select"
                                    v-model="form.examinado"
                                >
                                    <option
                                        v-for="item in ['SI', 'NO']"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div
                                class="col-md-4 mb-3"
                                v-if="form.examinado == 'SI'"
                            >
                                <label>EN CASO AFIRMATIVO, CUANDO?</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.examinado_d"
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label
                                    >¿HA LLEVADO ALGUNA VEZ APARATOS DE
                                    ORTODONCIA?</label
                                >
                                <select
                                    class="form-select"
                                    v-model="form.aparatos"
                                >
                                    <option
                                        v-for="item in ['SI', 'NO']"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div
                                class="col-md-4 mb-3"
                                v-if="form.aparatos == 'SI'"
                            >
                                <label>EN CASO AFIRMATIVO, CUANDO?</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.aparatos_d"
                                />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row my-3">
            <div class="col-md-4">
                <button
                    class="btn btn-primary"
                    @click="enviarFormulario"
                    :disabled="enviando"
                >
                    <i class="fa fa-save"></i> Guardar
                </button>
            </div>
        </div>
    </form>
    <div class="row" v-else>
        <div class="col-12 mb-3">
            <input
                type="text"
                class="form-control"
                v-model="form.paciente.full_name"
                readonly
            />
        </div>
        <!-- info 1 -->
        <div class="col-12">
            <div class="card">
                <div
                    class="bg-primary text-white card-header header_info"
                    @click="info1 = !info1"
                >
                    ANTECEDENTES DENTALES DEL PACIENTE
                    <i class="fa" :class="info1 ? 'fa-minus' : 'fa-plus'"></i>
                </div>
                <div class="card-body collapse" :class="[info1 ? 'show' : '']">
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label
                                >¿A TENIDO ALGUNA VEZ LESIONES EN LA CARA, EN LA
                                BOCA O EN LOS DIENTES?</label
                            >
                            <input
                                type="text"
                                class="form-control"
                                v-model="form.lesiones_cara"
                                readonly
                            />
                        </div>
                        <div class="col-12">
                            <h4 class="font-weight-bold border-bottom">
                                *OTRAS INFORMACIONES:
                            </h4>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label
                                >CHUPARSE EL PULGAR U OTRO DEDO (EN EL
                                PASDO)</label
                            >
                            <input
                                type="text"
                                class="form-control"
                                v-model="form.ch_pulgar_pasado"
                                readonly
                            />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label
                                >CHUPARSE EL PULGAR Y OTRO DEDO
                                (ACTUALMENTE)</label
                            >
                            <input
                                type="text"
                                class="form-control"
                                v-model="form.ch_dedo_actual"
                                readonly
                            />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>RESPIRACIÓN BUCAL</label>
                            <input
                                type="text"
                                class="form-control"
                                v-model="form.respiracion_bucal"
                                readonly
                            />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label
                                >¿SE MUERDE LAS UÑAS O LOS LABIOS EN LA
                                ACTUALIDAD?</label
                            >
                            <input
                                type="text"
                                class="form-control"
                                v-model="form.muerde_unia"
                                readonly
                            />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>¿DESGASTA O RECHINA LOS DIENTES?</label>
                            <input
                                type="text"
                                class="form-control"
                                v-model="form.desgaste_dientes"
                                readonly
                            />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label
                                >¿SE LE HA INFORMADO ALGUNA VEZ QUE LE FALTA UN
                                DIENTE PERMANENTE?</label
                            >
                            <input
                                type="text"
                                class="form-control"
                                v-model="form.falta_permanente"
                                readonly
                            />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label
                                >¿SE LE HA INFORMADO ALGUNA VEZ QUE LE FALTA UN
                                DIENTE PERMANENTE O TENGA ALGUNO DEMAS?</label
                            >
                            <input
                                type="text"
                                class="form-control"
                                v-model="form.falta_alguno"
                                readonly
                            />
                        </div>
                        <div
                            class="col-md-4 mb-3"
                            v-if="form.falta_alguno == 'SI'"
                        >
                            <label>EN CASO AFIRMATIVO CONCRETE</label>
                            <input
                                type="text"
                                class="form-control"
                                v-model="form.falta_alguno_d"
                            />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label
                                >¿TIENE ALGÚN ANTECEDENTE DE PROBLEMAS DE
                                CABEZA, CUELLO O ARTICULACIÓN DE LA
                                MANDIBULA?</label
                            >
                            <input
                                type="text"
                                class="form-control"
                                v-model="form.problema_cabeza"
                                readonly
                            />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label
                                >¿HA SIDO EXAMINADO POR ALGÚN
                                ORTODOCISTA?</label
                            >
                            <input
                                type="text"
                                class="form-control"
                                v-model="form.examinado"
                                readonly
                            />
                        </div>
                        <div
                            class="col-md-4 mb-3"
                            v-if="form.examinado == 'SI'"
                        >
                            <label>EN CASO AFIRMATIVO, CUANDO?</label>
                            <input
                                type="text"
                                class="form-control"
                                v-model="form.examinado_d"
                            />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label
                                >¿HA LLEVADO ALGUNA VEZ APARATOS DE
                                ORTODONCIA?</label
                            >
                            <input
                                type="text"
                                class="form-control"
                                v-model="form.aparatos"
                                readonly
                            />
                        </div>
                        <div class="col-md-4 mb-3" v-if="form.aparatos == 'SI'">
                            <label>EN CASO AFIRMATIVO, CUANDO?</label>
                            <input
                                type="text"
                                class="form-control"
                                v-model="form.aparatos_d"
                            />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<style scoped></style>
