# Analyse: Elementgruppen mit gleicher System-Wirkung
## UseCase-1 – Customer Login

## Ziel
Identifikation von Testfällen mit gleicher System-Wirkung, um den Testaufwand durch sinnvolles Zusammenfassen zu reduzieren.

---

## Identifizierte Elementgruppen

### Gruppe 1: Pflichtfeld-Validierung (Leere Eingaben)
**Betroffene Testfälle:** TC-1.2, TC-2.2

| Testfall | Eingabe | System-Wirkung |
|----------|---------|----------------|
| TC-1.2 | E-Mail leer, Passwort gefüllt | Fehlermeldung: Pflichtfeld fehlt |
| TC-2.2 | E-Mail gefüllt, Passwort leer | Fehlermeldung: Pflichtfeld fehlt |

**Analyse:** Die System-Wirkung ist identisch (Fehlermeldung wegen fehlendem Pflichtfeld). Die Validierungslogik ist jedoch unterschiedlich (verschiedene Felder).

**Empfehlung:** ⚠️ **Nicht zusammenfassen** – Beide Felder müssen separat getestet werden, da unterschiedliche Validierungsregeln greifen könnten.

---

### Gruppe 2: Fehlgeschlagene Authentifizierung
**Betroffene Testfälle:** TC-3.2, TC-3.3

| Testfall | Eingabe | System-Wirkung |
|----------|---------|----------------|
| TC-3.2 | Gültige E-Mail + falsches Passwort | Fehlermeldung: Ungültige Anmeldedaten |
| TC-3.3 | Nicht existierende E-Mail + beliebiges PW | Fehlermeldung: Ungültige Anmeldedaten |

**Analyse:** Aus Sicherheitsgründen sollte die System-Wirkung identisch sein (keine Information, ob E-Mail existiert oder Passwort falsch ist).

**Empfehlung:** ✅ **Zusammenfassen möglich** – Wenn das System aus Sicherheitsgründen dieselbe generische Fehlermeldung anzeigt, können diese Tests zu einem parametrisierten Test zusammengefasst werden. **Reduzierung: 2 → 1 Test mit 2 Datensätzen**

---

### Gruppe 3: Navigation-Links
**Betroffene Testfälle:** TC-4.1, TC-5.1

| Testfall | Aktion | System-Wirkung |
|----------|--------|----------------|
| TC-4.1 | Klick auf "Passwort vergessen" | Navigation zu anderer Seite |
| TC-5.1 | Klick auf "Konto erstellen" | Navigation zu anderer Seite |

**Analyse:** Beide Testfälle prüfen Link-Navigation, aber zu unterschiedlichen Zielseiten.

**Empfehlung:** ⚠️ **Nicht zusammenfassen** – Zielseiten sind unterschiedlich und müssen separat verifiziert werden.

---

### Gruppe 4: Eingabeformat-Validierung
**Betroffene Testfälle:** TC-1.3 (verschiedene ungültige E-Mail-Formate)

| Variante | Eingabe | System-Wirkung |
|----------|---------|----------------|
| 4a | "test@" | Fehlermeldung: Ungültiges E-Mail-Format |
| 4b | "test.de" | Fehlermeldung: Ungültiges E-Mail-Format |
| 4c | "@test.de" | Fehlermeldung: Ungültiges E-Mail-Format |

**Analyse:** Alle Varianten haben dieselbe System-Wirkung (Formatfehler).

**Empfehlung:** ✅ **Zusammenfassen möglich** – Diese können zu einem parametrisierten Test mit mehreren Testdatensätzen zusammengefasst werden. **Reduzierung: 3 → 1 Test mit 3 Datensätzen**

---

## Zusammenfassung der Optimierungspotenziale

| Gruppe | Original-Anzahl | Optimierte Anzahl | Einsparung |
|--------|-----------------|-------------------|------------|
| Pflichtfeld-Validierung | 2 | 2 | 0 |
| Fehlgeschlagene Authentifizierung | 2 | 1 (parametrisiert) | 1 |
| Navigation-Links | 2 | 2 | 0 |
| E-Mail-Format-Validierung | 3 | 1 (parametrisiert) | 2 |

**Gesamteinsparung:** 3 Testfälle können durch Parametrisierung reduziert werden

---

## Empfehlung für Schritt 3

Die folgenden Testfälle sollten in BDD Gherkin mit Datentabellen (Scenario Outline) umgesetzt werden:

1. **TC-3.2 + TC-3.3** → Ein Scenario Outline für fehlgeschlagene Authentifizierung
2. **TC-1.3** → Ein Scenario Outline für E-Mail-Formatvalidierung
3. Alle anderen Testfälle → Einzelne Scenarios
