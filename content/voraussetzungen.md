+++
title = "Voraussetzungen: Ubuntu 26.10 einrichten"
path = "voraussetzungen"
description = "Voraussetzungen für dieses Projekt: ein Rechner mit Ubuntu 26.10, direkt oder unter Windows mit WSL 2."
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
sudo apt-get install -y dotnet-sdk-11.0
dotnet tool install --global dotnet-ef
dotnet tool install --global dotnet-aspnet-codegenerator
dotnet tool install -g Microsoft.Web.LibraryManager.Cli
echo 'export PATH=$HOME/.dotnet/tools:$PATH' >> ~/.bashrc
source ~/.bashrc 
``` 
### Kompilierte Sprachen
Ein Compiler übersetzt den Programmcode in Binärcode, der ohne Laufumgebung läuft.

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
Folgendes im Terminal ein (siehe auch [Go herunterladen](https://go.dev/dl/)):
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


``` 


## Windows mit WSL 2 und Ubuntu 26.10

Leider habe ich keine Ahnung, wie das geht.


## Weiterführende Links

- [WSL 2 installieren](https://learn.microsoft.com/en-us/windows/wsl/install): Anleitung von Microsoft für Windows mit Ubuntu.
- [Installation von .NET unter Ubuntu](https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install): Offizielle Anleitung zu .NET.
- [Rust installieren](https://rust-lang.org/tools/install/): Offizielle Seite zur Installation von Rust.
- [Go herunterladen](https://go.dev/dl/): Offizielle Downloadseite von Go.
- [PostgreSQL unter Ubuntu](https://www.postgresql.org/download/linux/ubuntu/): Offizielle Anleitung zu PostgreSQL.
