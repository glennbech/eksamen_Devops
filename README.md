**Beskriv med ord eller skjermbilder hvordan man kan konfigurere GitHub på en måte som gir bedre kontroll på utviklingsprosessen. Spesielt med tanke på å hindre kode som ikke kompilerer og feilende tester fra å bli integrert i main branch.**
Bruke Github Actions til å stoppe kode fra å bli pushet til branchen når den inneholder feil. Dette kan være tester som må bli godkjent før man kan merge brancher.

**Beskriv med ord eller skjermbilder hvordan GitHub kan konfigureres for å sikre at minst ett annet medlem av teamet har godkjent en pull request før den merges**
Dette kan man ganske enkelt gjøre ved å bruke branch protection i github. Dette finner man i settings. I settings velger man “branches”. Her lager du en ny regel på main. Så velger du “Require a pull request before merging”.

**Beskriv hvordan arbeidsflyten for hver enkelt utvikler bør være for å få en effektiv som mulig utviklingsprosess, spesielt hvordan hver enkelt utvikler bør jobbe med Brancher i Github hver gang han eller hun starter en ny oppgave.**
For å optimalisere arbeidsflyten så burde man lage en ny branch når man skal lage en ny funksjon eller oppgave. Da kan man bare lage en pull request for å få den inn i main branchen. Denne pull requesten må så klart bli sjekket av noen andre som kan kvalitets sjekke koden.

**SkalBank har bestemt seg for å bruke DevOps som underliggende prinsipp for all systemutvikling i banken. Er fordeling av oppgaver mellom API-teamet og "Team Dino" problematisk med dette som utgangspunkt? Hvilke prinsipper er det som ikke etterleves her? Hva er i så fall konsekvensen av dette?**
Et problem SkalBank har er en treg applikasjon. Dette problemet er nesten en selvfølge når de ikke har noe telemetri eller feedback. Her kunne de brukt et verktøy for å samle mer informasjon når applikasjonen kjører og når den feiler.
De sender også all koden sin direkte til main. Dette er verste måten å gjøre dette på. Her burde de lage egne branches når de skal løse en oppgave. Dette kalles Trunk Based utvikling. Alle nye commits må så klart bestå alle tester.
De bruker også ikke tester slik de burde. Ved Continous Integration som github actions kan de bare pushe og kjøre alle testene automatisk. Dette hjelper veldig på effektiviteten til teamet. Da slipper de også de manuelle testene de kjører. I hvertfall til en stor grad. Github Actions kan også automatisk lage en JAR fil. Da slipper Jens å lage den manuelt.

**Hvilke spørring(er) kan sensor gjøre mot InfluxDB for å analysere problemet?**
Jeg la ikke til noen spørringer som sensor kunne brukt for å finne problemet, grunnet tid.



**Hvorfor funket terraformkoden i dette repoet for "Jens" første gang det ble kjørt? Og hvorfor feiler det for alle andre etterpå, inkludert Jens etter at han ryddet på disken sin og slettet terraform.tfstate filen?**
Jens har allerede laget en bucket med dette navnet. Dette betyr at han må fjerne bucket.tf. Han prøver altså å lage en bucket med samme navn. Dette går ikke

**Sensor ønsker å lage sin bucket ved hjelp av CLI. Sensor har aws kommandolinje installert på sin lokale maskin. Hva må sensor gjøre for å konfigurere AWS nøkler/Credentials? Anta at Sensor sin AWS bruker ikke har nøkler/credentials fra før.**
Først må sensor kjøre “aws configure” for å få nøklene man trenger senere.
For å lage en bucket her må sensor kjøre denne kommandoen. Her er ACL tilgangsnivået, her satt til private. Det kan også være public-read-write. Bucket er hvor man gir navnet til bucketen. 
Denne kommandoen lager en bucket med region i USA som default. Dette kan man endre med å legge til --create-bucket-configuration.

aws s3api create-bucket --acl "private" --bucket "sensor-bucket"

**Beskriv hva sensor må gjøre etter han/hun har laget en fork for å få pipeline til å fungere for i sin AWS/gitHub konto. Hvilke verdier må endres i koden?Hvilke hemmeligheter må legges inn i repoet. Hvordan gjøres dette?**
For å få dette til å funke må man først bytte kodene i github secrets. Her har jeg lagt til mine nøkler. Slett mine AWS nøkler.
Lag så en AWS_ACCESS_KEY_ID med access key.
Så en AWS_SECRET_ACCESS_KEY med secret access key.

Koden inneholder mange referanser til min AWS bruker, så her må mye endres.

Provider.tf:
	ECR: endre haha029 til sin egen ecr
	Og to steder under backend “s3”
Docker.yml:
	Under run må du endre to steder hvor jeg har ECR navnet mitt.

**Hva vil kommandolinje for å bygge et container image være? Fullfør**
Først må du ha en Dockerfile som inneholder informasjon om docker imaget. Så skriver du enkelt denne koden her:
Docker create -t NAVN

**Hva vil kommando for å starte en container være? Applikasjonen skal lytte på port 7777 på din maskin. Fullfør…**
--name her er navnet på imaget. -p er hvilken port du vil den skal kjøre på.
Docker run -d --name NAVN -p 7777:7777

**Medlemmer av "Team Dino" har av og til behov for å kjøre to ulike versjoner av applikasjonen lokalt på maskinen sin, samtidig .Hvordan kan de gjøre dette uten å få en port-konflikt? Hvilke to kommandoer kan man kjøre for å starte samme applikasjon to ganger, hvor den ene bruker port 7777 og den andre 8888?**
Dette er veldig lett. Man kjører bare samme kommandoen med to forskjellige portnummer.
Docker run -d --name NAVN -p 7777:7777
Docker run -d --name NAVN -p 8888:8888






