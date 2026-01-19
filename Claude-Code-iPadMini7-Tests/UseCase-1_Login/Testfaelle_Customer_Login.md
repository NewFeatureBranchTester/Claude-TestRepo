# Testfälle: UseCase-1 – Customer Login

## Übersicht der Einzelanforderungen
| ID | Anforderung | Beschreibung |
|----|-------------|--------------|
| REQ-1.1 | E-Mail-Eingabe | Pflichtfeld zur Identifikation des Benutzers |
| REQ-1.2 | Passwort-Eingabe | Pflichtfeld zur Authentifizierung (maskierte Eingabe) |
| REQ-1.3 | Login-Aktion | Schaltfläche "Anmelden" zum Absenden der Anmeldedaten |
| REQ-1.4 | Passwort-Vergessen-Link | Navigation zur Passwort-Wiederherstellung |
| REQ-1.5 | Registrierungs-Link | Möglichkeit für Neukunden, ein Konto zu erstellen |
| REQ-1.6 | Validierung | E-Mail-Formatprüfung und Datenbank-Abgleich |

---

## Testfälle

### TC-1.1: E-Mail-Eingabe - Positiver Test
**Anforderung:** REQ-1.1
**Vorbedingung:** Login-Seite ist geöffnet
**Testschritte:**
1. Gültige E-Mail-Adresse in das E-Mail-Feld eingeben
2. Prüfen, ob die Eingabe akzeptiert wird

**Erwartetes Ergebnis:** E-Mail wird im Eingabefeld angezeigt und akzeptiert

---

### TC-1.2: E-Mail-Eingabe - Leerfeld-Validierung
**Anforderung:** REQ-1.1, REQ-1.6
**Vorbedingung:** Login-Seite ist geöffnet
**Testschritte:**
1. E-Mail-Feld leer lassen
2. Gültiges Passwort eingeben
3. Auf "Anmelden" klicken

**Erwartetes Ergebnis:** Fehlermeldung erscheint, dass E-Mail erforderlich ist

---

### TC-1.3: E-Mail-Eingabe - Ungültiges Format
**Anforderung:** REQ-1.1, REQ-1.6
**Vorbedingung:** Login-Seite ist geöffnet
**Testschritte:**
1. Ungültiges E-Mail-Format eingeben (z.B. "test@", "test.de", "@test.de")
2. Gültiges Passwort eingeben
3. Auf "Anmelden" klicken

**Erwartetes Ergebnis:** Fehlermeldung erscheint wegen ungültigem E-Mail-Format

---

### TC-2.1: Passwort-Eingabe - Positiver Test
**Anforderung:** REQ-1.2
**Vorbedingung:** Login-Seite ist geöffnet
**Testschritte:**
1. Gültiges Passwort in das Passwort-Feld eingeben
2. Prüfen, ob die Eingabe maskiert angezeigt wird

**Erwartetes Ergebnis:** Passwort wird als maskierte Zeichen (●●●●) angezeigt

---

### TC-2.2: Passwort-Eingabe - Leerfeld-Validierung
**Anforderung:** REQ-1.2, REQ-1.6
**Vorbedingung:** Login-Seite ist geöffnet
**Testschritte:**
1. Gültige E-Mail-Adresse eingeben
2. Passwort-Feld leer lassen
3. Auf "Anmelden" klicken

**Erwartetes Ergebnis:** Fehlermeldung erscheint, dass Passwort erforderlich ist

---

### TC-3.1: Login-Aktion - Erfolgreicher Login
**Anforderung:** REQ-1.3, REQ-1.6
**Vorbedingung:** Login-Seite ist geöffnet, gültiger Benutzer existiert
**Testschritte:**
1. Gültige E-Mail-Adresse eingeben
2. Korrektes Passwort eingeben
3. Auf "Anmelden" klicken

**Erwartetes Ergebnis:**
- Weiterleitung zum Kunden-Dashboard
- Reaktionszeit unter 2 Sekunden

---

### TC-3.2: Login-Aktion - Falsche Anmeldedaten
**Anforderung:** REQ-1.3, REQ-1.6
**Vorbedingung:** Login-Seite ist geöffnet
**Testschritte:**
1. Gültige E-Mail-Adresse eingeben
2. Falsches Passwort eingeben
3. Auf "Anmelden" klicken

**Erwartetes Ergebnis:** Fehlermeldung erscheint (ungültige Anmeldedaten)

---

### TC-3.3: Login-Aktion - Nicht existierender Benutzer
**Anforderung:** REQ-1.3, REQ-1.6
**Vorbedingung:** Login-Seite ist geöffnet
**Testschritte:**
1. E-Mail-Adresse eingeben, die nicht im System registriert ist
2. Beliebiges Passwort eingeben
3. Auf "Anmelden" klicken

**Erwartetes Ergebnis:** Fehlermeldung erscheint (Benutzer nicht gefunden oder ungültige Anmeldedaten)

---

### TC-4.1: Passwort-Vergessen-Link - Navigation
**Anforderung:** REQ-1.4
**Vorbedingung:** Login-Seite ist geöffnet
**Testschritte:**
1. Auf "Passwort vergessen" Link klicken

**Erwartetes Ergebnis:** Weiterleitung zur Passwort-Wiederherstellungsseite

---

### TC-5.1: Registrierungs-Link - Navigation
**Anforderung:** REQ-1.5
**Vorbedingung:** Login-Seite ist geöffnet
**Testschritte:**
1. Auf "Create account" / "Konto erstellen" Link klicken

**Erwartetes Ergebnis:** Weiterleitung zur Registrierungsseite

---

### TC-6.1: Sicherheit - HTTPS-Übertragung
**Anforderung:** Technische Umsetzung (Sicherheit)
**Vorbedingung:** Login-Seite ist geöffnet
**Testschritte:**
1. Browser-Entwicklertools öffnen (Netzwerk-Tab)
2. Login-Formulardaten absenden
3. Überprüfen, ob Daten verschlüsselt übertragen werden

**Erwartetes Ergebnis:** Alle Anfragen erfolgen über HTTPS/TLS

---

### TC-6.2: Performance - Reaktionszeit
**Anforderung:** Erfolgskriterium (Reaktionszeit < 2s)
**Vorbedingung:** Login-Seite ist geöffnet
**Testschritte:**
1. Gültige Anmeldedaten eingeben
2. Zeit messen vom Klick auf "Anmelden" bis zur Weiterleitung

**Erwartetes Ergebnis:** Authentifizierung erfolgt in unter 2 Sekunden
