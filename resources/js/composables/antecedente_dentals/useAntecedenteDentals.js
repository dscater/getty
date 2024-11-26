import axios from "axios";
import { onMounted, reactive, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oAntecedenteDental = reactive({
    id: 0,
    paciente_id: "",
    lesiones_cara: "NO",
    ch_pulgar_pasado: "NO",
    ch_dedo_actual: "NO",
    respiracion_bucal: "NO",
    muerde_unia: "NO",
    desgaste_dientes: "NO",
    falta_permanente: "NO",
    falta_alguno: "NO",
    falta_alguno_d: "",
    problema_cabeza: "NO",
    examinado: "NO",
    examinado_d: "",
    aparatos: "NO",
    aparatos_d: "",
    _method: "POST",
});

export const useAntecedenteDentals = () => {
    const { flash } = usePage().props;
    const getAntecedenteDentals = async () => {
        try {
            const response = await axios.get(
                route("antecedente_dentals.listado"),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.antecedente_dentals;
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

    const getAntecedenteDentalsByTipo = async (data) => {
        try {
            const response = await axios.get(
                route("antecedente_dentals.byTipo"),
                {
                    headers: { Accept: "application/json" },
                    params: data,
                }
            );
            return response.data.antecedente_dentals;
        } catch (error) {
            console.error("Error:", error);
            throw error; // Puedes manejar el error según tus necesidades
        }
    };

    const getAntecedenteDentalsApi = async (data) => {
        try {
            const response = await axios.get(
                route("antecedente_dentals.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.antecedente_dentals;
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
    const saveAntecedenteDental = async (data) => {
        try {
            const response = await axios.post(
                route("antecedente_dentals.store", data),
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

    const deleteAntecedenteDental = async (id) => {
        try {
            const response = await axios.delete(
                route("antecedente_dentals.destroy", id),
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

    const setAntecedenteDental = (item = null, paciente = true) => {
        if (item) {
            oAntecedenteDental.id = item.id;
            oAntecedenteDental.paciente_id = item.paciente_id;
            oAntecedenteDental.lesiones_cara = item.lesiones_cara;
            oAntecedenteDental.ch_pulgar_pasado = item.ch_pulgar_pasado;
            oAntecedenteDental.ch_dedo_actual = item.ch_dedo_actual;
            oAntecedenteDental.respiracion_bucal = item.respiracion_bucal;
            oAntecedenteDental.muerde_unia = item.muerde_unia;
            oAntecedenteDental.desgaste_dientes = item.desgaste_dientes;
            oAntecedenteDental.falta_permanente = item.falta_permanente;
            oAntecedenteDental.falta_alguno = item.falta_alguno;
            oAntecedenteDental.falta_alguno_d = item.falta_alguno_d;
            oAntecedenteDental.problema_cabeza = item.problema_cabeza;
            oAntecedenteDental.examinado = item.examinado;
            oAntecedenteDental.examinado_d = item.examinado_d;
            oAntecedenteDental.aparatos = item.aparatos;
            oAntecedenteDental.aparatos_d = item.aparatos_d;
            if (paciente) {
                oAntecedenteDental.paciente = item.paciente;
            }
            oAntecedenteDental._method = "PUT";
            return oAntecedenteDental;
        }
        return false;
    };

    const limpiarAntecedenteDental = () => {
        oAntecedenteDental.id = 0;
        oAntecedenteDental.paciente_id = "";
        oAntecedenteDental.lesiones_cara = "NO";
        oAntecedenteDental.ch_pulgar_pasado = "NO";
        oAntecedenteDental.ch_dedo_actual = "NO";
        oAntecedenteDental.respiracion_bucal = "NO";
        oAntecedenteDental.muerde_unia = "NO";
        oAntecedenteDental.desgaste_dientes = "NO";
        oAntecedenteDental.falta_permanente = "NO";
        oAntecedenteDental.falta_alguno = "NO";
        oAntecedenteDental.falta_alguno_d = "NO";
        oAntecedenteDental.problema_cabeza = "NO";
        oAntecedenteDental.examinado = "NO";
        oAntecedenteDental.examinado_d = "NO";
        oAntecedenteDental.aparatos = "NO";
        oAntecedenteDental.aparatos_d = "NO";
        oAntecedenteDental._method = "POST";
    };

    onMounted(() => {});

    return {
        oAntecedenteDental,
        getAntecedenteDentals,
        getAntecedenteDentalsApi,
        saveAntecedenteDental,
        deleteAntecedenteDental,
        setAntecedenteDental,
        limpiarAntecedenteDental,
        getAntecedenteDentalsByTipo,
    };
};
