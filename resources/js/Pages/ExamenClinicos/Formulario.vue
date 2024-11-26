<script setup>
import { useForm, usePage, Link } from "@inertiajs/vue3";
import { useExamenClinicos } from "@/composables/examen_clinicos/useExamenClinicos";
import { usePacientes } from "@/composables/pacientes/usePacientes";
import { ref, onMounted, onBeforeUnmount } from "vue";
import MiDropZone from "@/Components/MiDropZone.vue";
import * as THREE from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";
import { OBJLoader } from "three/examples/jsm/loaders/OBJLoader";
import axios from "axios";

const propsPage = defineProps({
    detalle: {
        type: Boolean,
        default: false,
    },
});

const { oExamenClinico, limpiarExamenClinico } = useExamenClinicos();
const { getPacientes } = usePacientes();
let form = useForm(oExamenClinico);
const listPacientes = ref([]);

const info1 = ref(false);
const info2 = ref(false);
const info3 = ref(true);

const { flash, url_assets } = usePage().props;
const enviando = ref(false);
const modeloGenerado = ref(false);
const generando = ref(false);
const enviarFormulario = () => {
    enviando.value = true;
    let url =
        form["_method"] == "POST"
            ? route("examen_clinicos.store")
            : route("examen_clinicos.update", form.id);

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
            limpiarExamenClinico();
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

const detectaArchivos = (files) => {
    form.examen_imagens = files;
    if (form.examen_imagens.length <= 0) {
        modeloGenerado.value = false;
    }
};

const detectaEliminados = (eliminados) => {
    form.eliminados = eliminados;
    if (form.examen_imagens.length <= 0) {
        modeloGenerado.value = false;
    }
};

const cargarPacientes = async () => {
    listPacientes.value = await getPacientes();
};

// MODELO
const rendererContainer = ref(null);
const nom_mod = ref("m1.obj");
var controls = null;
var renderer = null;
var scene = null;
var camera = null;
var container = null;
var widthContainer = null;
var heightContainer = null;
const initModelo = () => {
    container = rendererContainer.value;
    if (!container) {
        return;
    }

    widthContainer = container.offsetWidth;
    heightContainer = container.offsetHeight;

    camera = new THREE.PerspectiveCamera(
        70,
        widthContainer / heightContainer,
        0.1,
        1000
    );
    camera.position.set(0, 0, 200); //x,y,z

    // Limpiar escena previa
    if (scene) {
        while (scene.children.length > 0) {
            scene.remove(scene.children[0]);
        }
    } else {
        scene = new THREE.Scene();
    }

    // Verifica y ajusta el renderer
    if (!renderer) {
        renderer = new THREE.WebGLRenderer();
        renderer.setSize(container.offsetWidth, container.offsetHeight);
        container.appendChild(renderer.domElement);
    } else {
        renderer.setSize(container.offsetWidth, container.offsetHeight);
    }

    controls = new OrbitControls(camera, renderer.domElement);
    controls.enableDamping = true;
    controls.dampingFactor = 0.35; // Si es demasiado alto, puede hacer que los controles se vean poco naturales.
    controls.enableZoom = true;
    controls.maxDistance = 1200; // Limita la distancia máxima a la que puedes alejar la cámara.
    controls.minDistance = 100; // Limita la distancia mínima a la que puedes acercar la cámara.
    controls.target.set(0, 0, 0);

    // fondo
    scene.background = new THREE.Color(0x666666);

    var keyLight = new THREE.DirectionalLight(
        new THREE.Color("hsl(30, 100%, 75%)"),
        1.0
    );
    keyLight.position.set(-100, 0, 100);

    var fillLight = new THREE.DirectionalLight(
        new THREE.Color("hsl(240, 100%, 75%)"),
        0.75
    );
    fillLight.position.set(100, 0, 100);

    var backLight = new THREE.DirectionalLight(0xffffff, 1.0);
    backLight.position.set(100, 0, -100).normalize();
    scene.add(keyLight);
    scene.add(fillLight);

    var objLoader = new OBJLoader();
    const path = url_assets + "imgs/examen_clinicos/";
    objLoader.setPath(path);
    objLoader.load(nom_mod.value, function (object) {
        object.traverse((child) => {
            if (child.isMesh) {
                // Asegúrate de que el material sea correcto
                child.material.side = THREE.DoubleSide; // Si es necesario visualizar ambas caras
            }
        });
        const box = new THREE.Box3().setFromObject(object);
        const center = box.getCenter(new THREE.Vector3());
        object.position.sub(center);
        // Ajusta la cámara para que el objeto sea visible de forma adecuada
        const size = box.getSize(new THREE.Vector3()).length();
        const distance = size / (3 * Math.tan((Math.PI * camera.fov) / 360)); // Calcula la distancia a la que debe estar la cámara
        camera.position.z = distance * 1.2; // Ajusta la cámara un poco más lejos para ver todo el objeto

        // Establece el rango de distancia de los controles de órbita
        controls.minDistance = distance / 2; // Puedes ajustar esto para permitir acercamientos más cercanos
        controls.maxDistance = distance * 3;
        scene.add(object);
        generando.value = false;
        modeloGenerado.value = true;
    });
    animate();
};
const resize = () => {
    if (!container) return;
    widthContainer = container.offsetWidth;
    heightContainer = container.offsetHeight;
    renderer.setSize(widthContainer, heightContainer);
    camera.aspect = widthContainer / heightContainer;
    camera.updateProjectionMatrix(); // Actualiza la relación de aspecto de la cámara
};

var animate = function () {
    if (rendererContainer.value) {
        requestAnimationFrame(animate);
        controls.update();
        renderer.render(scene, camera);
    }
};
// FIN MODELO

const generarModelo = () => {
    modeloGenerado.value = false;
    if (form.examen_imagens.length > 0) {
        generando.value = true;
        axios
            .get(route("examen_clinicos.obtienem", { antiguo: form.modelo }))
            .then((response) => {
                nom_mod.value = response.data;
                form.modelo = nom_mod.value;
                setTimeout(() => {
                    initModelo();
                }, 4000);
            });
    } else {
        Swal.fire({
            icon: "info",
            title: "Error",
            text: `Debes cargar las imagenes para la generación del modelo`,
            confirmButtonColor: "#3085d6",
            confirmButtonText: `Aceptar`,
        });
    }
};

onMounted(() => {
    if (form.id != 0) {
        nom_mod.value = form.modelo;
        modeloGenerado.value = true;
        initModelo();
    }

    cargarPacientes();
    // initModelo();
    window.addEventListener("resize", resize);
});

onBeforeUnmount(() => {
    window.removeEventListener("resize", resize);
});
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
                        EXAMEN CLÍNICO EXTRAORAL
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
                            <div class="col-md-4 mb-3">
                                <label>SIMETRIA FACIAL</label>
                                <select
                                    class="form-select"
                                    v-model="form.simetria_facial"
                                >
                                    <option
                                        v-for="item in [
                                            'SIMETRIA',
                                            'ASIMETRIA',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>DICCIÓN</label>
                                <select
                                    class="form-select"
                                    v-model="form.diccion"
                                >
                                    <option
                                        v-for="item in ['NORMAL', 'ALTERADA']"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>PATRÓN FACIAL</label>
                                <select
                                    class="form-select"
                                    v-model="form.patron_facial"
                                >
                                    <option
                                        v-for="item in [
                                            'MESOCEFALO',
                                            'BRAQUICEFALO',
                                            'DOLICOCEFALO',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>RESPIRACIÓN</label>
                                <select
                                    class="form-select"
                                    v-model="form.respiracion"
                                >
                                    <option
                                        v-for="item in [
                                            'NASAL',
                                            'BUCAL',
                                            'AMBAS',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>PERFIL</label>
                                <select
                                    class="form-select"
                                    v-model="form.perfil"
                                >
                                    <option
                                        v-for="item in [
                                            'RECTO',
                                            'CONCAVO',
                                            'CONVEXO',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>RELACIÓN LABIAL</label>
                                <select
                                    class="form-select"
                                    v-model="form.relacion_labial"
                                >
                                    <option
                                        v-for="item in [
                                            'NORMAL',
                                            'CLASE II',
                                            'CLASE III',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>LABIOS</label>
                                <select
                                    class="form-select"
                                    v-model="form.labios"
                                >
                                    <option
                                        v-for="item in [
                                            'NORMALES',
                                            'HIPERTONICOS',
                                            'HIPOTONICOS',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>MAXILAR SUPERIOR</label>
                                <select
                                    class="form-select"
                                    v-model="form.maxilar_superior"
                                >
                                    <option
                                        v-for="item in [
                                            'CLASE I',
                                            'CLASE II',
                                            'CLASE III',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>DEGLUCIÓN</label>
                                <select
                                    class="form-select"
                                    v-model="form.deglucion"
                                >
                                    <option
                                        v-for="item in ['NORMAL', 'ATIPICA']"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>LENGUA Y DEGLUCIÓN</label>
                                <select
                                    class="form-select"
                                    v-model="form.lengua_deglucion"
                                >
                                    <option
                                        v-for="item in [
                                            'NORMAL',
                                            'INTERPOSICIÓN',
                                            'INTERPOSICIÓN EN REPOSO',
                                            'HIPOTONICA',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>HABITOS BUCALES</label>
                                <select
                                    class="form-select"
                                    v-model="form.habito_bucal"
                                >
                                    <option
                                        v-for="item in [
                                            'SUCCIÓN DE DEDOS',
                                            'SUCCIÓN DE LABIOS',
                                            'ONICOFAGIA',
                                            'BRUXISMO',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- info 2 -->
            <div class="col-12">
                <div class="card">
                    <div
                        class="bg-primary text-white card-header header_info"
                        @click="info2 = !info2"
                    >
                        EXAMEN CLÍNICO INTRAORAL
                        <i
                            class="fa"
                            :class="info2 ? 'fa-minus' : 'fa-plus'"
                        ></i>
                    </div>
                    <div
                        class="card-body collapse"
                        :class="[info2 ? 'show' : '']"
                    >
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label>DENTICIÓN</label>
                                <select
                                    class="form-select"
                                    v-model="form.denticion"
                                >
                                    <option
                                        v-for="item in [
                                            'DECIDUA',
                                            'MIXTA',
                                            'PERMANENTE',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>OVERJET</label>
                                <select
                                    class="form-select"
                                    v-model="form.overjet"
                                >
                                    <option
                                        v-for="item in ['NORMAL', 'ALTERADA']"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>HIGIENE BUCAL</label>
                                <select
                                    class="form-select"
                                    v-model="form.higiene_bucal"
                                >
                                    <option
                                        v-for="item in [
                                            'MALA',
                                            'REGULAR',
                                            'BUENA',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>SALUD DENTAL</label>
                                <select
                                    class="form-select"
                                    v-model="form.salud_dental"
                                >
                                    <option
                                        v-for="item in [
                                            'MALA',
                                            'REGULAR',
                                            'BUENA',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>RELACIÓN MOLAR</label>
                                <select
                                    class="form-select"
                                    v-model="form.relacion_molar"
                                >
                                    <option
                                        v-for="item in [
                                            'CLASE I',
                                            'CLASE II',
                                            'CLASE III',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>RELACIÓN CANINA</label>
                                <select
                                    class="form-select"
                                    v-model="form.relacion_canina"
                                >
                                    <option
                                        v-for="item in [
                                            'CLASE I',
                                            'CLASE II',
                                            'CLASE III',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label>AMIGDALAS</label>
                                <select
                                    class="form-select"
                                    v-model="form.amigdalas"
                                >
                                    <option
                                        v-for="item in [
                                            'NORMALES',
                                            'PRESENTES',
                                            'AUSENTES',
                                            'NO',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label>MORDIDA CRUZADA</label>
                                <select
                                    class="form-select"
                                    v-model="form.mordida_cruzada"
                                >
                                    <option
                                        v-for="item in [
                                            'DIENTE ANTERIOR',
                                            'POST. BILATERAL',
                                            'POST. DERECHO',
                                            'POST IZQUIERDO',
                                            'LINEA',
                                            'MEDIA',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label>SUPERIOR</label>
                                <select
                                    class="form-select"
                                    v-model="form.linea_sup"
                                >
                                    <option
                                        v-for="item in [
                                            'COINCIDE LINEA MEDIA FACIAL',
                                            'A LA DERECHA MM',
                                            'A LA IZQUIERDA MM',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div
                                class="col-md-4"
                                v-if="
                                    form.linea_sup == 'A LA DERECHA MM' ||
                                    form.linea_sup == 'A LA IZQUIERDA MM'
                                "
                            >
                                <label>MM SUPERIOR</label>
                                <input
                                    type="number"
                                    class="form-select"
                                    v-model="form.linea_sup_mm"
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>INFERIOR</label>
                                <select
                                    class="form-select"
                                    v-model="form.linea_inf"
                                >
                                    <option
                                        v-for="item in [
                                            'COINCIDE LINEA MEDIA FACIAL',
                                            'A LA DERECHA MM',
                                            'A LA IZQUIERDA MM',
                                        ]"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                            </div>
                            <div
                                class="col-md-4 mb-3"
                                v-if="
                                    form.linea_inf == 'A LA DERECHA MM' ||
                                    form.linea_inf == 'A LA IZQUIERDA MM'
                                "
                            >
                                <label>MM INFERIOR</label>
                                <input
                                    type="number"
                                    class="form-select"
                                    v-model="form.linea_inf_mm"
                                />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- info 3 -->
            <div class="col-12">
                <div class="card">
                    <div
                        class="bg-primary text-white card-header header_info"
                        @click="info3 = !info3"
                    >
                        IMAGÉNES EN YESOS DEL PACIENTE
                        <i
                            class="fa"
                            :class="info3 ? 'fa-minus' : 'fa-plus'"
                        ></i>
                    </div>
                    <div
                        class="card-body collapse"
                        :class="[info3 ? 'show' : '']"
                    >
                        <div class="row">
                            <div class="col-md-6">
                                <MiDropZone
                                    :files="form.examen_imagens"
                                    @UpdateFiles="detectaArchivos"
                                    @addEliminados="detectaEliminados"
                                ></MiDropZone>
                                <div class="col-12">
                                    <ul
                                        v-if="form.errors?.examen_imagens"
                                        class="parsley-errors-list filled"
                                    >
                                        <li class="parsley-required">
                                            {{ form.errors?.examen_imagens }}
                                        </li>
                                    </ul>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 offset-md-4">
                                        <button
                                            type="button"
                                            class="btn btn-outline-primary w-100 mt-1 rounded-0"
                                            @click="generarModelo"
                                            :disabled="generando"
                                        >
                                            {{
                                                generando
                                                    ? "Generando..."
                                                    : "Generar modelo"
                                            }}
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 contenedor_loading">
                                <div class="loading" v-if="generando">
                                    <p class="text-body-1 text-white">
                                        Analizando imagenes...
                                    </p>
                                    <div class="loader"></div>
                                    <p class="text-caption text-white">
                                        ¡Espere porfavor!
                                    </p>
                                </div>
                                <div
                                    ref="rendererContainer"
                                    class="renderer-container"
                                ></div>
                            </div>
                            <div class="col-12">
                                <label>Observación</label>
                                <textarea class="form-control" v-model="form.observacion" rows="2"></textarea>
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
                    :disabled="enviando || !modeloGenerado"
                >
                    <i class="fa fa-save"></i> Guardar
                </button>
            </div>
        </div>
    </form>
    <div v-else>
        <div class="row">
            <div class="col-12 mb-3">
                <input
                    type="text"
                    :value="form.paciente?.full_name"
                    class="form-control"
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
                        EXAMEN CLÍNICO EXTRAORAL
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
                            <div class="col-md-4 mb-3">
                                <label>SIMETRIA FACIAL</label>
                                <input
                                    type="text"
                                    v-model="form.simetria_facial"
                                    class="form-control"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>DICCIÓN</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.diccion"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>PATRÓN FACIAL</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.patron_facial"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>RESPIRACIÓN</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.respiracion"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>PERFIL</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.perfil"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>RELACIÓN LABIAL</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.relacion_labial"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>LABIOS</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.labios"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>MAXILAR SUPERIOR</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.maxilar_superior"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>DEGLUCIÓN</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.deglucion"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>LENGUA Y DEGLUCIÓN</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.lengua_deglucion"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>HABITOS BUCALES</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.habito_bucal"
                                    readonly
                                />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- info 2 -->
            <div class="col-12">
                <div class="card">
                    <div
                        class="bg-primary text-white card-header header_info"
                        @click="info2 = !info2"
                    >
                        EXAMEN CLÍNICO INTRAORAL
                        <i
                            class="fa"
                            :class="info2 ? 'fa-minus' : 'fa-plus'"
                        ></i>
                    </div>
                    <div
                        class="card-body collapse"
                        :class="[info2 ? 'show' : '']"
                    >
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label>DENTICIÓN</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.denticion"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>OVERJET</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.overjet"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>HIGIENE BUCAL</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.higiene_bucal"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>SALUD DENTAL</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.salud_dental"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>RELACIÓN MOLAR</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.relacion_molar"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>RELACIÓN CANINA</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.relacion_canina"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4">
                                <label>AMIGDALAS</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.amigdalas"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4">
                                <label>MORDIDA CRUZADA</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.mordida_cruzada"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4">
                                <label>SUPERIOR</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.linea_sup"
                                    readonly
                                />
                            </div>
                            <div
                                class="col-md-4"
                                v-if="
                                    form.linea_sup == 'A LA DERECHA MM' ||
                                    form.linea_sup == 'A LA IZQUIERDA MM'
                                "
                            >
                                <label>MM SUPERIOR</label>
                                <input
                                    type="number"
                                    class="form-select"
                                    v-model="form.linea_sup_mm"
                                    readonly
                                />
                            </div>
                            <div class="col-md-4 mb-3">
                                <label>INFERIOR</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    v-model="form.linea_inf"
                                    readonly
                                />
                            </div>
                            <div
                                class="col-md-4 mb-3"
                                v-if="
                                    form.linea_inf == 'A LA DERECHA MM' ||
                                    form.linea_inf == 'A LA IZQUIERDA MM'
                                "
                            >
                                <label>MM INFERIOR</label>
                                <input
                                    type="number"
                                    class="form-select"
                                    v-model="form.linea_inf_mm"
                                    readonly
                                />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- info 3 -->
            <div class="col-12">
                <div class="card">
                    <div
                        class="bg-primary text-white card-header header_info"
                        @click="info3 = !info3"
                    >
                        IMAGÉNES EN YESOS DEL PACIENTE
                        <i
                            class="fa"
                            :class="info3 ? 'fa-minus' : 'fa-plus'"
                        ></i>
                    </div>
                    <div
                        class="card-body collapse"
                        :class="[info3 ? 'show' : '']"
                    >
                        <div class="row">
                            <div class="col-md-6">
                                <div class="row">
                                    <div
                                        class="col-md-4"
                                        v-for="item in form.examen_imagens"
                                    >
                                        <img
                                            :src="item.url_imagen"
                                            alt=""
                                            width="100%"
                                        />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 contenedor_loading">
                                <h4>Modelo generado</h4>
                                <div
                                    ref="rendererContainer"
                                    class="renderer-container"
                                ></div>
                            </div>
                            <div class="col-12">
                                <label>Observación</label>
                                <textarea class="form-control" v-model="form.observacion" rows="2" readonly></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row my-3">
            <div class="col-md-4">
                <Link
                    :href="route('examen_clinicos.index')"
                    class="btn btn-primary"
                >
                    <i class="fa fa-arrow-left"></i> Volver
                </Link>
            </div>
        </div>
    </div>
</template>
<style scoped>
.header_info {
    font-weight: bold;
    cursor: pointer;
}

.renderer-container {
    min-width: 500px;
    min-width: 100%;
    min-height: 50vh;
}

canvas {
    height: 100%;
    width: 100%;
}

/* LOADING */
.contenedor_loading {
    position: relative;
}

.contenedor_loading .loading {
    position: absolute;
    display: flex;
    gap: 10px;
    width: 100%;
    height: 100%;
    background-color: var(--principal);
    z-index: 400;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

.contenedor_loading .loader {
    width: 64px;
    height: 64px;
    position: relative;
    background: #f4f4f4;
    border-radius: 4px;
    overflow: hidden;
}

.contenedor_loading .loader:before {
    content: "";
    position: absolute;
    left: 0;
    bottom: 0;
    width: 40px;
    height: 40px;
    transform: rotate(45deg) translate(30%, 40%);
    background: #2e86de;
    box-shadow: 32px -34px 0 5px #0097e6;
    animation: slide 2s infinite ease-in-out alternate;
}

.contenedor_loading .loader:after {
    content: "";
    position: absolute;
    left: 10px;
    top: 10px;
    width: 16px;
    height: 16px;
    border-radius: 50%;
    background: #0097e6;
    transform: rotate(0deg);
    transform-origin: 35px 145px;
    animation: rotate 2s infinite ease-in-out;
}

@keyframes slide {
    0%,
    100% {
        bottom: -35px;
    }

    25%,
    75% {
        bottom: -2px;
    }

    20%,
    80% {
        bottom: 2px;
    }
}

@keyframes rotate {
    0% {
        transform: rotate(-15deg);
    }

    25%,
    75% {
        transform: rotate(0deg);
    }

    100% {
        transform: rotate(25deg);
    }
}
</style>
