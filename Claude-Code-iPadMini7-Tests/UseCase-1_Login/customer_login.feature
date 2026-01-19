# language: de
@UseCase-1 @Login @Customer
Feature: Customer Login
  Als Kunde
  Möchte ich mich mit meinen Zugangsdaten anmelden können
  Um Zugriff auf mein Konto und persönliche Funktionen zu erhalten

  Hintergrund:
    Gegeben sei die Login-Seite ist geöffnet

  # ============================================
  # TC-1.1: E-Mail-Eingabe - Positiver Test
  # ============================================
  @REQ-1.1 @Positiv
  Szenario: Gültige E-Mail-Adresse wird akzeptiert
    Wenn ich eine gültige E-Mail-Adresse "kunde@beispiel.de" eingebe
    Dann wird die E-Mail im Eingabefeld angezeigt
    Und das E-Mail-Feld zeigt keinen Validierungsfehler

  # ============================================
  # TC-1.2: E-Mail-Eingabe - Leerfeld-Validierung
  # ============================================
  @REQ-1.1 @REQ-1.6 @Negativ @Pflichtfeld
  Szenario: Leeres E-Mail-Feld zeigt Fehlermeldung
    Wenn ich das E-Mail-Feld leer lasse
    Und ich ein gültiges Passwort "Test1234!" eingebe
    Und ich auf "Anmelden" klicke
    Dann erscheint eine Fehlermeldung "E-Mail ist erforderlich"

  # ============================================
  # TC-1.3: E-Mail-Eingabe - Ungültiges Format
  # (Optimiert mit Scenario Outline)
  # ============================================
  @REQ-1.1 @REQ-1.6 @Negativ @Validierung
  Szenariogrundriss: Ungültige E-Mail-Formate werden abgelehnt
    Wenn ich eine ungültige E-Mail-Adresse "<email>" eingebe
    Und ich ein gültiges Passwort "Test1234!" eingebe
    Und ich auf "Anmelden" klicke
    Dann erscheint eine Fehlermeldung "<fehlermeldung>"

    Beispiele: Ungültige E-Mail-Formate
      | email          | fehlermeldung                    |
      | test@          | Ungültiges E-Mail-Format         |
      | test.de        | Ungültiges E-Mail-Format         |
      | @test.de       | Ungültiges E-Mail-Format         |
      | test@@test.de  | Ungültiges E-Mail-Format         |
      | test @test.de  | Ungültiges E-Mail-Format         |
      |                | E-Mail ist erforderlich          |

  # ============================================
  # TC-2.1: Passwort-Eingabe - Positiver Test
  # ============================================
  @REQ-1.2 @Positiv
  Szenario: Passwort wird maskiert angezeigt
    Wenn ich ein Passwort "GeheimesPasswort123" eingebe
    Dann wird das Passwort als maskierte Zeichen angezeigt
    Und das Passwort-Feld hat den Typ "password"

  # ============================================
  # TC-2.2: Passwort-Eingabe - Leerfeld-Validierung
  # ============================================
  @REQ-1.2 @REQ-1.6 @Negativ @Pflichtfeld
  Szenario: Leeres Passwort-Feld zeigt Fehlermeldung
    Wenn ich eine gültige E-Mail-Adresse "kunde@beispiel.de" eingebe
    Und ich das Passwort-Feld leer lasse
    Und ich auf "Anmelden" klicke
    Dann erscheint eine Fehlermeldung "Passwort ist erforderlich"

  # ============================================
  # TC-3.1: Login-Aktion - Erfolgreicher Login
  # ============================================
  @REQ-1.3 @REQ-1.6 @Positiv @Happy-Path
  Szenariogrundriss: Erfolgreicher Login mit gültigen Anmeldedaten
    Gegeben sei ein registrierter Kunde mit E-Mail "<email>" und Passwort "<passwort>"
    Wenn ich die E-Mail-Adresse "<email>" eingebe
    Und ich das Passwort "<passwort>" eingebe
    Und ich auf "Anmelden" klicke
    Dann werde ich zum Kunden-Dashboard weitergeleitet
    Und die Authentifizierung erfolgt in unter 2 Sekunden

    Beispiele: Gültige Benutzerkonten
      | email                    | passwort       |
      | max.mustermann@test.de   | Passwort123!   |
      | anna.schmidt@beispiel.de | Sicher456$     |
      | peter.mueller@firma.com  | Geheim789#     |

  # ============================================
  # TC-3.2 + TC-3.3: Fehlgeschlagene Authentifizierung
  # (Zusammengefasst gemäß ManuTestStep-2 Analyse)
  # ============================================
  @REQ-1.3 @REQ-1.6 @Negativ @Sicherheit
  Szenariogrundriss: Fehlgeschlagene Authentifizierung zeigt generische Fehlermeldung
    Wenn ich die E-Mail-Adresse "<email>" eingebe
    Und ich das Passwort "<passwort>" eingebe
    Und ich auf "Anmelden" klicke
    Dann erscheint eine Fehlermeldung "Ungültige Anmeldedaten"
    Und ich bleibe auf der Login-Seite

    Beispiele: Ungültige Anmeldeversuche
      | email                      | passwort        | beschreibung                    |
      | kunde@beispiel.de          | FalschesPasswd  | Gültige E-Mail, falsches PW     |
      | nichtexistent@test.de      | BeliebigesPW    | Nicht registrierte E-Mail       |
      | kunde@beispiel.de          | passwort        | Gültige E-Mail, zu einfaches PW |
      | KUNDE@BEISPIEL.DE          | FalschesPasswd  | Groß geschriebene E-Mail        |
      | admin@beispiel.de          | admin123        | Häufig versuchte Kombination    |

  # ============================================
  # TC-4.1: Passwort-Vergessen-Link - Navigation
  # ============================================
  @REQ-1.4 @Navigation
  Szenario: Passwort-Vergessen-Link führt zur Wiederherstellungsseite
    Wenn ich auf den Link "Passwort vergessen" klicke
    Dann werde ich zur Passwort-Wiederherstellungsseite weitergeleitet
    Und die URL enthält "/account/recover"

  # ============================================
  # TC-5.1: Registrierungs-Link - Navigation
  # ============================================
  @REQ-1.5 @Navigation
  Szenario: Registrierungs-Link führt zur Kontoerstellungsseite
    Wenn ich auf den Link "Konto erstellen" klicke
    Dann werde ich zur Registrierungsseite weitergeleitet
    Und die URL enthält "/account/register"

  # ============================================
  # TC-6.1: Sicherheit - HTTPS-Übertragung
  # ============================================
  @Sicherheit @Technik
  Szenario: Login-Daten werden verschlüsselt übertragen
    Wenn ich die Netzwerkanfragen während des Logins überwache
    Und ich gültige Anmeldedaten eingebe
    Und ich auf "Anmelden" klicke
    Dann werden alle Anfragen über HTTPS gesendet
    Und die Verbindung verwendet TLS 1.2 oder höher

  # ============================================
  # TC-6.2: Performance - Reaktionszeit
  # ============================================
  @Performance @NFR
  Szenariogrundriss: Login-Reaktionszeit unter verschiedenen Bedingungen
    Gegeben sei ein registrierter Kunde mit E-Mail "perf.test@beispiel.de" und Passwort "Test1234!"
    Und die Netzwerkbedingung ist "<netzwerk>"
    Wenn ich mich mit gültigen Anmeldedaten anmelde
    Dann erfolgt die Authentifizierung in unter "<max_zeit>" Sekunden

    Beispiele: Netzwerkbedingungen
      | netzwerk   | max_zeit |
      | Schnell    | 1        |
      | Normal     | 2        |
      | Langsam    | 5        |

  # ============================================
  # Zusätzliche Grenzwert-Tests
  # ============================================
  @Grenzwert @Robustheit
  Szenariogrundriss: Eingabefelder mit Grenzwerten testen
    Wenn ich eine E-Mail-Adresse mit <email_laenge> Zeichen eingebe
    Und ich ein Passwort mit <passwort_laenge> Zeichen eingebe
    Und ich auf "Anmelden" klicke
    Dann ist das Systemverhalten "<erwartetes_verhalten>"

    Beispiele: Grenzwert-Konstellationen
      | email_laenge | passwort_laenge | erwartetes_verhalten               |
      | 5            | 8               | Normal (Mindestlänge)              |
      | 254          | 8               | Normal (Max E-Mail RFC 5321)       |
      | 255          | 8               | Fehler oder Abschneiden            |
      | 50           | 1               | Fehler (Passwort zu kurz)          |
      | 50           | 128             | Normal (Langes Passwort)           |
      | 50           | 129             | Abhängig von Systemkonfiguration   |
