import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oPaciente = ref({
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
            oPaciente.value.id = item.id;
            oPaciente.value.nombre = item.nombre;
            oPaciente.value.paterno = item.paterno;
            oPaciente.value.materno = item.materno;
            oPaciente.value.ci = item.ci;
            oPaciente.value.ci_exp = item.ci_exp;
            oPaciente.value.fecha_nac = item.fecha_nac;
            oPaciente.value.dir = item.dir;
            oPaciente.value.fono = item.fono;
            oPaciente.value.foto = item.foto;
            oPaciente.value.nombre_proge = item.nombre_proge;
            oPaciente.value.senior = item.senior;
            oPaciente.value.dir_s = item.dir_s;
            oPaciente.value.fono_dom_s = item.fono_dom_s;
            oPaciente.value.fono_trab_s = item.fono_trab_s;
            oPaciente.value.cel_s = item.cel_s;
            oPaciente.value.fax_s = item.fax_s;
            oPaciente.value.correo_s = item.correo_s;
            oPaciente.value.agradecer = item.agradecer;
            oPaciente.value.nom_edad_hmnos = item.nom_edad_hmnos;
            if (foto) {
                oPaciente.value.url_foto = item.url_foto;
            }
            oPaciente.value._method = "PUT";
            return oPaciente;
        }
        return false;
    };

    const limpiarPaciente = () => {
        oPaciente.value.id = 0;
        oPaciente.value.nombre = "";
        oPaciente.value.paterno = "";
        oPaciente.value.materno = "";
        oPaciente.value.ci = "";
        oPaciente.value.ci_exp = "";
        oPaciente.value.fecha_nac = "";
        oPaciente.value.dir = "";
        oPaciente.value.fono = "";
        oPaciente.value.foto = "";
        oPaciente.value.nombre_proge = "";
        oPaciente.value.senior = "";
        oPaciente.value.dir_s = "";
        oPaciente.value.fono_dom_s = "";
        oPaciente.value.fono_trab_s = "";
        oPaciente.value.cel_s = "";
        oPaciente.value.fax_s = "";
        oPaciente.value.correo_s = "";
        oPaciente.value.agradecer = "";
        oPaciente.value.nom_edad_hmnos = "";
        oPaciente.value._method = "POST";
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
