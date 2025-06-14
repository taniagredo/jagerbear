// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EmergencyAlert {
    struct Evidence {
        string description;
        string[] imageHashes;     // Puede contener hashes de IPFS u otra red
        string declarationText;   // Declaración libre escrita por el usuario
    }

    struct Alert {
        address sender;
		string idEvent;
        string userName;
        string latitude;
        string longitude;
        uint256 timestamp;
        string[] contacts;
        Evidence evidence;
    }

    Alert[] public alerts;

    event AlertSent(
        address indexed sender,
		string idEvent,
        string userName,
        string latitude,
        string longitude,
        uint256 timestamp
    );

    event EvidenceAdded(
        uint256 indexed alertIndex,
        address indexed sender,
        string description,
        uint256 timestamp
    );

    /// @notice Envía una alerta básica sin evidencia
            /// @notice Envía una alerta básica sin evidencia
    function sendAlert(
		string memory idEvent,
        string memory userName,
        string memory latitude,
        string memory longitude,
        string[] memory contacts
    ) public {
        // Crear un array vacío de strings
        string[] memory emptyHashes = new string[](0);

        // Crear evidencia vacía
        Evidence memory emptyEvidence = Evidence({
            description: "",
            imageHashes: emptyHashes,
            declarationText: ""
        });

        // Crear alerta completa
        Alert memory newAlert = Alert({
            sender: msg.sender,
			idEvent: idEvent,
            userName: userName,
            latitude: latitude,
            longitude: longitude,
            timestamp: block.timestamp,
            contacts: contacts,
            evidence: emptyEvidence
        });

        alerts.push(newAlert);

        emit AlertSent(msg.sender, idEvent, userName, latitude, longitude, block.timestamp);
    }


    /// @notice Agrega evidencia adicional a una alerta específica
    function addEvidenceToAlert(
        uint256 index,
        string memory description,
        string[] memory imageHashes,
        string memory declarationText
    ) public {
        require(index < alerts.length, "Indice fuera de rango");
        require(alerts[index].sender == msg.sender, "Solo el emisor puede agregar evidencia");

        alerts[index].evidence = Evidence({
            description: description,
            imageHashes: imageHashes,
            declarationText: declarationText
        });

        emit EvidenceAdded(index, msg.sender, description, block.timestamp);
    }

    /// @notice Devuelve cuántas alertas ha creado una dirección específica
    function getTotalAlertsBySender(address sender) public view returns (uint256 count) {
        for (uint256 i = 0; i < alerts.length; i++) {
            if (alerts[i].sender == sender) {
                count++;
            }
        }
        return count;
    }

    /// @notice Devuelve todas las alertas asociadas a una dirección específica
    function getAlertsBySender(address sender) public view returns (Alert[] memory) {
        uint256 count = getTotalAlertsBySender(sender);
        Alert[] memory result = new Alert[](count);
        uint256 j = 0;
        for (uint256 i = 0; i < alerts.length; i++) {
            if (alerts[i].sender == sender) {
                result[j] = alerts[i];
                j++;
            }
        }
        return result;
    }

    /// @notice Devuelve la alerta según índice
    function getAlert(uint256 index) public view returns (
        address,
        string memory,
		string memory,
        string memory,
        string memory,
        uint256,
        string[] memory,
        string memory,
        string[] memory,
        string memory
    ) {
        require(index < alerts.length, "Indice fuera de rango");
        Alert memory a = alerts[index];
        return (
            a.sender,
			a.idEvent,
            a.userName,
            a.latitude,
            a.longitude,
            a.timestamp,
            a.contacts,
            a.evidence.description,
            a.evidence.imageHashes,
            a.evidence.declarationText
        );
    }

    /// @notice Devuelve cuántas alertas existen
    function getTotalAlerts() public view returns (uint256) {
        return alerts.length;
    }
}
