+++
title = "Server"
description = "Produktserver Einrichten "
path = "server"
+++
## Produktserver einrichten
Ich benutze gern Ubuntu Server, weil ich ihn besser kenne. Wir müssen erst den Ubuntu Server aktualisieren. Wir starten auf dem Rechner das Terminalfenster und geben Folgendes ein: Das ist nur Code.
``` ssh root@beispiel.de
``` 
Jetzt öffnet sich dann ein externer Rechner. Geben Sie Folgendes ein:
```  
apt-get update
apt-get upgrade
```
## Jetzt benutze ich nur zwei Laufumgebungen
Weil die auch noch 20 Jahre ohne Probleme. Auch noch Abwärtskompatibilität. Hier sind und versprechen meine Favoriten:
* Java
* C#
Andere brauchen keine Laufumgebung. Dass die Versprechen einhalten. Dieses brauche ich nicht Server installieren. Weil sie Binär Laufen
* C
* Go
* Rust: leider sind Bibliotheken weder Webframeworks noch Reifegrad genug und Bibliotheken.
* C++
  

### Java
```
# Aktualisiert die Paketquellen
sudo apt update

# Installiert eine aktuelle, schlanke Java-Laufzeitumgebung ohne grafische Komponenten
sudo apt install openjdk-26-jre-headless

# Überprüft die installierte Java-Version
java -version
``` # Aktualisiert die Paketquellen
sudo apt update

# Installiert eine aktuelle, schlanke Java-Laufzeitumgebung ohne grafische Komponenten
sudo apt install openjdk-26-jre-headless

# Überprüft die installierte Java-Version
java -version
``` 
### Dotnet
```   
sudo apt-get update && sudo apt-get install -y aspnetcore-runtime-10.0

``` 

## Webserver
* nginx
## Datenbank
* PostgreSQL


## Weiterführende Links

- [Ubuntu Server: Pakete installieren und verwalten](https://ubuntu.com/server/docs/how-to/software/package-management/): Erklärt `apt update` und `apt upgrade`.
- [.NET auf Ubuntu installieren (Microsoft Learn)](https://learn.microsoft.com/de-de/dotnet/core/install/linux-ubuntu-install): Zeigt die Installation der .NET-Laufzeit.
- [OpenJDK: Download und Installation](https://openjdk.org/install/): Offizielle Seite zu OpenJDK.
