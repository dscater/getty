import axios from "axios";
import { onMounted, reactive, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oExamenClinico = reactive({
    id: 0,
    paciente_id: "",
    simetria_facial: "SIMETRIA",
    diccion: "NORMAL",
    patron_facial: "MESOCEFALO",
    respiracion: "NASAL",
    perfil: "RECTO",
    relacion_labial: "NORMAL",
    labios: "NORMALES",
    maxilar_superior: "CLASE I",
    deglucion: "NORMAL",
    lengua_deglucion: "NORMAL",
    habito_bucal: "SUCCIÓN DE DEDOS",
    denticion: "DECIDUA",
    overjet: "NORMAL",
    higiene_bucal: "MALA",
    salud_dental: "MALA",
    relacion_molar: "CLASE I",
    relacion_canina: "CLASE I",
    amigdalas: "NORMALES",
    mordida_cruzada: "DIENTE ANTERIOR",
    linea_sup: "COINCIDE LINEA MEDIA FACIAL",
    linea_sup_mm: "",
    linea_inf: "COINCIDE LINEA MEDIA FACIAL",
    linea_inf_mm: "",
    observacion: "",
    modelo: "",
    examen_imagens: [],
    eliminados: [],
    _method: "POST",
});

export const useExamenClinicos = () => {
    const { flash } = usePage().props;
    const getExamenClinicos = async () => {
        try {
            const response = await axios.get(route("examen_clinicos.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.examen_clinicos;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const getExamenClinicosByTipo = async (data) => {
        try {
            const response = await axios.get(route("examen_clinicos.byTipo"), {
                headers: { Accept: "application/json" },
                params: data,
            });
            return response.data.examen_clinicos;
        } catch (error) {
            console.error("Error:", error);
            throw error; // Puedes manejar el error según tus necesidades
        }
    };

    const getExamenClinicosApi = async (data) => {
        try {
            const response = await axios.get(
                route("examen_clinicos.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.examen_clinicos;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };
    const saveExamenClinico = async (data) => {
        try {
            const response = await axios.post(
                route("examen_clinicos.store", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            return response.data;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const deleteExamenClinico = async (id) => {
        try {
            const response = await axios.delete(
                route("examen_clinicos.destroy", id),
                {
                    headers: { Accept: "application/json" },
                }
            );
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            return response.data;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const setExamenClinico = (item = null, paciente = false) => {
        if (item) {
            oExamenClinico.id = item.id;
            oExamenClinico.paciente_id = item.paciente_id;
            oExamenClinico.simetria_facial = item.simetria_facial;
            oExamenClinico.diccion = item.diccion;
            oExamenClinico.patron_facial = item.patron_facial;
            oExamenClinico.respiracion = item.respiracion;
            oExamenClinico.perfil = item.perfil;
            oExamenClinico.relacion_labial = item.relacion_labial;
            oExamenClinico.labios = item.labios;
            oExamenClinico.maxilar_superior = item.maxilar_superior;
            oExamenClinico.deglucion = item.deglucion;
            oExamenClinico.lengua_deglucion = item.lengua_deglucion;
            oExamenClinico.habito_bucal = item.habito_bucal;
            oExamenClinico.denticion = item.denticion;
            oExamenClinico.overjet = item.overjet;
            oExamenClinico.higiene_bucal = item.higiene_bucal;
            oExamenClinico.salud_dental = item.salud_dental;
            oExamenClinico.relacion_molar = item.relacion_molar;
            oExamenClinico.relacion_canina = item.relacion_canina;
            oExamenClinico.amigdalas = item.amigdalas;
            oExamenClinico.mordida_cruzada = item.mordida_cruzada;
            oExamenClinico.linea_sup = item.linea_sup;
            oExamenClinico.linea_sup_mm = item.linea_sup_mm;
            oExamenClinico.linea_inf = item.linea_inf;
            oExamenClinico.linea_inf_mm = item.linea_inf_mm;
            oExamenClinico.observacion = item.observacion;
            oExamenClinico.modelo = item.modelo;
            oExamenClinico.examen_imagens = item.examen_imagens;
            if (paciente) {
                oExamenClinico.paciente = item.paciente;
            }
            oExamenClinico._method = "PUT";
            return oExamenClinico;
        }
        return false;
    };

    const limpiarExamenClinico = () => {
        oExamenClinico.id = 0;
        oExamenClinico.paciente_id = "";
        oExamenClinico.simetria_facial = "SIMETRIA";
        oExamenClinico.diccion = "NORMAL";
        oExamenClinico.patron_facial = "MESOCEFALO";
        oExamenClinico.respiracion = "NASAL";
        oExamenClinico.perfil = "RECTO";
        oExamenClinico.relacion_labial = "NORMAL";
        oExamenClinico.labios = "NORMALES";
        oExamenClinico.maxilar_superior = "CLASE I";
        oExamenClinico.deglucion = "NORMAL";
        oExamenClinico.lengua_deglucion = "NORMAL";
        oExamenClinico.habito_bucal = "SUCCIÓN DE DEDOS";
        oExamenClinico.denticion = "DECIDUA";
        oExamenClinico.overjet = "NORMAL";
        oExamenClinico.higiene_bucal = "MALA";
        oExamenClinico.salud_dental = "MALA";
        oExamenClinico.relacion_molar = "CLASE I";
        oExamenClinico.relacion_canina = "CLASE I";
        oExamenClinico.amigdalas = "NORMALES";
        oExamenClinico.mordida_cruzada = "DIENTE ANTERIOR";
        oExamenClinico.linea_sup = "COINCIDE LINEA MEDIA FACIAL";
        oExamenClinico.linea_sup_mm = "";
        oExamenClinico.linea_inf = "COINCIDE LINEA MEDIA FACIAL";
        oExamenClinico.linea_inf_mm = "";
        oExamenClinico.observacion = "";
        oExamenClinico.modelo = "";
        oExamenClinico.examen_imagens = [];
        oExamenClinico.eliminados = [];
        oExamenClinico._method = "POST";
    };

    onMounted(() => {});

    return {
        oExamenClinico,
        getExamenClinicos,
        getExamenClinicosApi,
        saveExamenClinico,
        deleteExamenClinico,
        setExamenClinico,
        limpiarExamenClinico,
        getExamenClinicosByTipo,
    };
};
