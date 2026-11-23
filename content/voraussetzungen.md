+++
title = "Voraussetzungen: Ubuntu 26.10 einrichten"
path = "voraussetzungen"
description = "Ubuntu 26.10 einrichten: Programmiersprachen, PostgreSQL, Editoren und KI-Tools für dieses Projekt installieren."
+++
Für dieses Projekt brauchen Sie einen Rechner mit Ubuntu 26.10. Unter Windows geht das auch mit [WSL 2](https://learn.microsoft.com/en-us/windows/wsl/install) und Ubuntu 26.10.

Sie haben zwei Möglichkeiten:

- Ubuntu 26.10 direkt auf Ihrem Rechner
- Windows mit WSL 2 und Ubuntu 26.10


## Ubuntu 26.10 direkt auf Ihrem Rechner
Starten Sie das Terminal auf dem Ubuntu-Rechner. Geben Sie Folgendes ein, um den Rechner zu aktualisieren:
``` 
sudo apt-get update
sudo apt-get upgrade
sudo apt install libsecret-1-0 libsecret-tools libsecret-1-dev libglib2.0-dev
sudo ubuntu-drivers install
``` 

### Interpretierte Sprachen
Ein Interpreter führt den Programmcode direkt aus.

#### Python
Geben Sie Folgendes im Terminal ein:
```  
sudo apt install python3 python3-pip python3-venv python-is-python3

``` 
#### Node.js
Geben Sie Folgendes im Terminal ein:
``` 
sudo apt install curl
# nvm herunterladen und installieren:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.41.0/install.sh | bash

# nvm laden, ohne die Shell neu zu starten:
\. "$HOME/.nvm/nvm.sh"

# Node.js herunterladen und installieren:
nvm install 26
```  
### Bytecode-Sprachen
Der Compiler übersetzt den Programmcode in Bytecode. Eine Laufzeitumgebung (bei Java die JVM, bei .NET die CLR) führt ihn aus.

#### Java mit Entwickler-Kit
Geben Sie Folgendes im Terminal ein:
```  
sudo apt install openjdk-26-jdk-headless

``` 
#### .NET mit Entwickler-Kit
Geben Sie Folgendes im Terminal ein (siehe auch [Installation von .NET unter Ubuntu](https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install)):
``` 
sudo apt-get update
sudo apt-get install -y dotnet-sdk-10.0
dotnet tool install --global dotnet-ef
dotnet tool install --global dotnet-aspnet-codegenerator
dotnet tool install -g Microsoft.Web.LibraryManager.Cli
echo 'export PATH=$HOME/.dotnet/tools:$PATH' >> ~/.bashrc
source ~/.bashrc 
``` 
### Kompilierte Sprachen
Ein Compiler übersetzt den Programmcode in Binärcode, der ohne Laufzeitumgebung läuft.

#### C und C++
Das Metapaket build-essential installiert grundlegende Werkzeuge zum Übersetzen von Programmen, zum Beispiel den C- und C++-Compiler (gcc und g++) sowie make. Geben Sie Folgendes im Terminal ein:
```  
sudo apt install build-essential
sudo apt-get install cmake
sudo apt-get install gdb
``` 
#### Rust
Siehe auch: [Rust installieren](https://rust-lang.org/tools/install/).

```  
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

``` 
#### Go
Geben Sie Folgendes im Terminal ein (siehe auch [Go herunterladen](https://go.dev/dl/)):
```
cd $HOME
sudo rm -rf /usr/local/go
wget https://go.dev/dl/go1.27.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.27.4.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
source ~/.bashrc
```

## Daten speichern
Das Programm soll Daten langfristig speichern. Wenn das Programm beendet ist, sind sie nicht mehr da.
### Relationale Datenbanken
Eine relationale Datenbank speichert Daten in Tabellen, die man später abrufen, suchen und abfragen kann.
Ich nehme [PostgreSQL](https://www.postgresql.org/download/linux/ubuntu/), weil die Software Open Source ist und es auch viele Erweiterungen gibt. Geben Sie Folgendes im Terminal ein:

``` 
# Import the repository signing key:
sudo apt install curl ca-certificates
sudo install -d /usr/share/postgresql-common/pgdg
sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc

# Create the repository configuration file:
. /etc/os-release
sudo sh -c "echo 'deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $VERSION_CODENAME-pgdg main' > /etc/apt/sources.list.d/pgdg.list"

# Update the package lists:
sudo apt update

# PostgreSQL installieren
sudo apt install postgresql-18

# PostGIS Erweiterung installieren
sudo apt-get install postgis postgresql-18-postgis-3 postgresql-18
sudo -u postgres -i
createuser thorsten
createdb -E UTF8 -O thorsten thorsten
psql -d thorsten -c "CREATE EXTENSION postgis;"
psql -d thorsten -c "CREATE EXTENSION hstore;"
psql -d thorsten -c "ALTER TABLE geometry_columns OWNER TO thorsten;"
psql -d thorsten -c "ALTER TABLE spatial_ref_sys OWNER TO thorsten;"
psql -d thorsten -c "\password thorsten"
psql -c "ALTER USER thorsten CREATEDB;"
exit
cd $HOME
wget https://download.geofabrik.de/europe/germany/schleswig-holstein-latest.osm.pbf
sudo apt-get install osmosis osm2pgsql
osmosis --read-pbf file=schleswig-holstein-latest.osm.pbf --bounding-box left=10.1141 right=10.3716 top=53.7136 bottom=53.6249 --write-pbf file=ahrensburg.pbf
osm2pgsql -d thorsten -H localhost -U thorsten --create -G --hstore -W ahrensburg.pbf

``` 
#### PostgreSQL Passwort-Authentifizierung konfigurieren nur Entwicklungsrechner
PostgreSQL Passwort-Authentifizierung konfigurieren
Erstelle die .pgpass-Datei in deinem Home-Verzeichnis:
``` 
nano ~/.pgpass
``` 
Füge die Daten im folgenden Format ein:
```
localhost:5432:*:dein_user:dein_passwort
``` 
Setze die korrekten Berechtigungen:
```
chmod 0600 ~/.pgpass
``` 

## Nur auf dem Entwicklungsrechner machen
### Sudo ohne Passwort konfigurieren (NOPASSWD)
Öffnen Sie die Konfigurationsdatei mit:
```  
sudo visudo
``` 
Fügen Sie am Ende der Datei folgende Zeile für Ihren Benutzer hinzu:
```
dein_benutzername ALL=(ALL) NOPASSWD:ALL
``` 
Speichern und schließen Sie den Editor.

## Google Chrome installieren
``` 
cd /tmp
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
``` 
## Git installieren und konfigurieren
``` 
sudo apt-get install git gh
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
``` 
### GitHub CLI (gh) konfigurieren
``` 
gh auth login
```  
## Editoren & IDEs installieren
### Visual Studio Code installieren
* [Visual Studio Code herunterladen](https://code.visualstudio.com/download)
#### Weitere Visual-Studio-Code-Erweiterungen
```
code --install-extension rust-lang.rust-analyzer
code --install-extension Google.google-antigravity
code --install-extension anthropic.claude-code
code --install-extension ms-dotnettools.csdevkit
```
### Neovim installieren
``` 
sudo apt-get install neovim
``` 
### Zed installieren
``` 
curl -f https://zed.dev/install.sh | sh
``` 
## Coding-KI-Tools installieren
### Coding-KI-CLIs installieren
``` 
npm i -g @openai/codex
curl -fsSL https://claude.ai/install.sh | bash
curl -fsSL https://antigravity.google/cli/install.sh | bash

```  


## Windows mit WSL 2 und Ubuntu 26.10

Leider habe ich keine Ahnung, wie das geht.


## Weiterführende Links

- [WSL 2 installieren](https://learn.microsoft.com/en-us/windows/wsl/install): Anleitung von Microsoft für Windows mit Ubuntu.
- [Installation von .NET unter Ubuntu](https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install): Offizielle Anleitung zu .NET.
- [Rust installieren](https://rust-lang.org/tools/install/): Offizielle Seite zur Installation von Rust.
- [Go herunterladen](https://go.dev/dl/): Offizielle Downloadseite von Go.
- [PostgreSQL unter Ubuntu](https://www.postgresql.org/download/linux/ubuntu/): Offizielle Anleitung zu PostgreSQL.
- [nvm-Projektseite auf GitHub](https://github.com/nvm-sh/nvm): Erklärt Installation und Nutzung des Node-Versionsmanagers.
- [Claude-Code-Dokumentation](https://code.claude.com/docs/en/overview): Offizielle Anleitung zu Claude Code.
