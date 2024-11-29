import axios from "axios";
import { onMounted, reactive } from "vue";
import { usePage } from "@inertiajs/vue3";

const oPaciente = reactive({
    id: 0,
    nombre: "",
    paterno: "",
    materno: "",
    ci: "",
    ci_exp: "",
    fecha_nac: "",
    dir: "",
    fono: "",
    foto: "",
    nombre_proge: "",
    senior: "",
    dir_s: "",
    fono_dom_s: "",
    fono_trab_s: "",
    cel_s: "",
    fax_s: "",
    correo_s: "",
    agradecer: "",
    nom_edad_hmnos: "",
    consultas: [],
    eliminados: [],
    _method: "POST",
});

export const usePacientes = () => {
    const { flash } = usePage().props;
    const getPacientes = async (data) => {
        try {
            const response = await axios.get(route("pacientes.listado", data), {
                headers: { Accept: "application/json" },
            });
            return response.data.pacientes;
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

    const getPacientesByTipo = async (data) => {
        try {
            const response = await axios.get(route("pacientes.byTipo"), {
                headers: { Accept: "application/json" },
                params: data,
            });
            return response.data.pacientes;
        } catch (error) {
            console.error("Error:", error);
            throw error; // Puedes manejar el error según tus necesidades
        }
    };

    const getPacientesApi = async (data) => {
        try {
            const response = await axios.get(
                route("pacientes.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.pacientes;
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
    const savePaciente = async (data) => {
        try {
            const response = await axios.post(route("pacientes.store", data), {
                headers: { Accept: "application/json" },
            });
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

    const deletePaciente = async (id) => {
        try {
            const response = await axios.delete(
                route("pacientes.destroy", id),
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

    const setPaciente = (item = null, foto = false) => {
        if (item) {
            oPaciente.id = item.id;
            oPaciente.nombre = item.nombre;
            oPaciente.paterno = item.paterno;
            oPaciente.materno = item.materno;
            oPaciente.ci = item.ci;
            oPaciente.ci_exp = item.ci_exp;
            oPaciente.fecha_nac = item.fecha_nac;
            oPaciente.dir = item.dir;
            oPaciente.fono = item.fono;
            oPaciente.foto = item.foto;
            oPaciente.nombre_proge = item.nombre_proge;
            oPaciente.senior = item.senior;
            oPaciente.dir_s = item.dir_s;
            oPaciente.fono_dom_s = item.fono_dom_s;
            oPaciente.fono_trab_s = item.fono_trab_s;
            oPaciente.cel_s = item.cel_s;
            oPaciente.fax_s = item.fax_s;
            oPaciente.correo_s = item.correo_s;
            oPaciente.agradecer = item.agradecer;
            oPaciente.nom_edad_hmnos = item.nom_edad_hmnos;
            oPaciente.consultas = item.consultas;
            if (foto) {
                oPaciente.url_foto = item.url_foto;
            }
            oPaciente.eliminados = [];
            oPaciente._method = "PUT";
            return oPaciente;
        }
        return false;
    };

    const limpiarPaciente = () => {
        oPaciente.id = 0;
        oPaciente.nombre = "";
        oPaciente.paterno = "";
        oPaciente.materno = "";
        oPaciente.ci = "";
        oPaciente.ci_exp = "";
        oPaciente.fecha_nac = "";
        oPaciente.dir = "";
        oPaciente.fono = "";
        oPaciente.foto = "";
        oPaciente.nombre_proge = "";
        oPaciente.senior = "";
        oPaciente.dir_s = "";
        oPaciente.fono_dom_s = "";
        oPaciente.fono_trab_s = "";
        oPaciente.cel_s = "";
        oPaciente.fax_s = "";
        oPaciente.correo_s = "";
        oPaciente.agradecer = "";
        oPaciente.nom_edad_hmnos = "";
        oPaciente.consultas = [];
        oPaciente.eliminados = [];
        oPaciente._method = "POST";
    };

    onMounted(() => {});

    return {
        oPaciente,
        getPacientes,
        getPacientesApi,
        savePaciente,
        deletePaciente,
        setPaciente,
        limpiarPaciente,
        getPacientesByTipo,
    };
};
