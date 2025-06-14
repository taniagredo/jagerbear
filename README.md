# 🛡️ Sistema de Alertas de Emergencia - DApp

Aplicación descentralizada que permite registrar, consultar, visualizar y exportar alertas de emergencia, conectada a la blockchain de Ethereum. El sistema incluye autenticación local, conexión con wallet, panel de control, visualización de alertas.

---

## 🚀 Tecnologías Utilizadas

- **Frontend:** React + TailwindCSS
- **Routing:** React Router
- **Blockchain:** Ethereum (Base Sepolia) + Ethers.js
- **Smart Contract:** Solidity (ver `contract.js`)
- **PDF Reports:** jsPDF + autoTable
- **Mapas:** React Leaflet + OpenStreetMap

---

## 📁 Estructura del Proyecto
```
├── components/
│ ├── LoginScreen.jsx # Pantalla de login local + conexión con wallet
│ ├── MainMenu.jsx # Menú principal tras login
│ ├── Landing.jsx # Visualización general de alertas
│ ├── AlertaDetalle.jsx # Detalle completo de una alerta con mapa
│ ├── ConsultarCaso.jsx # Buscar alerta por ID y agregar evidencia
│ ├── Reportes.jsx # Generación de PDFs general y por alerta
│ └── AgregarEvidencia.jsx # (Integrado dentro de otros módulos)
├── contract/
│ └── contract.js # ABI + dirección del contrato en Base Sepolia
├── App.jsx # Definición de rutas y lógica de sesión
├── main.jsx # Entrada principal con ReactDOM
├── index.css # Tailwind CSS base
├── App.css # Estilos adicionales
└── public/images/Logof.png # Logo institucional
```

---

## 🔐 Autenticación

- Login local con usuario y contraseña (mock: `admin` / `1234`).
- Conexión con MetaMask mediante Ethers.js.
- Al iniciar sesión correctamente, se obtiene el signer y la wallet address.

---

## 📌 Funcionalidades Principales

### 🔎 1. Visualización de Alertas
- Ruta: `/alertas`
- Lista todas las alertas registradas en el contrato.
- Muestra datos clave: título, ID, ubicación, fecha, contactos, evidencia.

### 🧭 2. Detalle de Alerta
- Ruta: `/alerta/:index`
- Consulta una alerta por su ID (`idEvent`) y muestra:
  - Coordenadas en mapa.
  - Evidencias registradas.
  - Información de contactos y declaración.
  - Manejador de errores por ID inválido o wallet desconectada.

### 🔍 3. Consultar Caso
- Ruta: `/consultar-caso`
- Permite buscar una alerta por ID.
- Si existe, muestra detalles clave y permite:
  - Ir al detalle completo.
  - Agregar nueva evidencia.

### 📄 4. Generación de Reportes PDF
- Ruta: `/reportes`
- Exporta:
  - Reporte general con ID, nombre y fecha de todas las alertas.
  - Reporte detallado de una alerta específica.
- Usa `jsPDF` y `autoTable`.

---

## 🔗 Contrato Inteligente

Ubicado en `contract.js`, define las siguientes funciones principales:

- `sendAlert`: Registrar una nueva alerta.
- `addEvidenceToAlert`: Agregar evidencia posterior.
- `getAlert(index)`: Obtener alerta por índice.
- `getTotalAlerts()`: Total de alertas en cadena.
- `getAlertsBySender(sender)`: Alertas por dirección.
- `events`: `AlertSent`, `EvidenceAdded`.

**Dirección del contrato (Base Sepolia):**
```

0xcaD16f95EA5137Ef52a26ccA4B6dF1c5aab950FC

````
---

## 🧪 Requisitos para correr localmente

1. Instalar dependencias:
```bash
npm install
````

2. Ejecutar app:

```bash
npm run dev
```

3. Tener MetaMask instalada y conectada a la red **Base Sepolia**.

---

## 👥 Créditos

Este proyecto fue desarrollado para una Hackatón por el equipoo por JägerBear.

---

## 📝 Notas

* Asegúrate de que MetaMask esté habilitada y configurada en la red correcta.
* Se pueden adaptar rutas protegidas y funcionalidades para roles futuros.
* Los errores de validación son informados visualmente con `alerts` o mensajes inline.

```
