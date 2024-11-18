import { defineStore } from "pinia";

export const useConfiguracionStore = defineStore("configuracion", {
    state: () => ({
        oConfiguracion: {
            nombre_sistema:"GETTY",
            alias:"LC",
            razon_social:"GETTY S.A.",
            ciudad:"",
            dir:"",
            fono:"",
            correo:"",
            web:"",
            actividad:"",
            // appends
            url_logo: "",
        },
    }),
    actions: {
        setInstiticion(value) {
            this.oConfiguracion = value;
        },
    },
});
