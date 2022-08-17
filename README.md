# Lobbyreg.no

Vi jobber for å få plass et felles lobbyregister for alle partier som ønsker delta. 

Koden vil lanseres som åpen og fri kildekode under AGPL og være tilgjengelig for alle som ønsker forbedre, videreutvikle, eller sette opp sin egen versjon under samme vilkår.

Ønsker du hjelpe til? Ta kontakt med oss på daniel.jackson@venstre.no - du er velkommen uavhengig av partibakgrunn. Vi vil bygge noe som alle partiene kan bruke.

## Status

Denne kildekoden er høyst ustabil og under utvikling. Det er sannsynlig at alt forandres på kort tid.

## Screenshots av tenkt løsning: 

### Søk og filtrering
![image](https://user-images.githubusercontent.com/14905290/185115339-32d405c7-54db-41bb-b37f-72ff26d577d2.png)

Enkelt søk og filtrering, med mulighet for å se hvilke aktører som møter hvem.

### Enkeltmøter
![image](https://user-images.githubusercontent.com/14905290/185115441-7f7be7da-4f2c-4969-b4ee-e79c418a4e1c.png)

Se hvem som deltok i møtet, hvem de representerte, og hva som var tema. Vi loggfører hvem som deltok utifra e-post-adressene deres. Her kan det være noen vi ikke vet hvem er, som markeres med "ukjent" - og andre som vi vet hvilken organisasjon de tilhører (typisk gjennom domenet i e-posten, f.eks. @nho.no) men ikke hvem de er.

### Representanter, organisasjoner og lobbyister
![image](https://user-images.githubusercontent.com/14905290/185115389-04954bac-ab75-4a44-9f84-037f4cd7b0a7.png)
![image](https://user-images.githubusercontent.com/14905290/185122144-5f61bec3-0c72-4f37-99f3-1b69b223c1dc.png)
![image](https://user-images.githubusercontent.com/14905290/185116051-2eec2f92-ace0-4507-bd8a-047fca298f6d.png)

Se oversikt over møtene til enkelt-representanter, partier eller organisasjoner.

## Løsningen

### Hva skal i registeret?

Alle møter med en "lobbyist" i bred forstand, for eksempel med en organisasjon (liten eller stor) som ønsker å påvirke en politiker eller et politisk parti. Vi registrerer normalt ikke møter med privatpersoner, og aldri møter med varslere eller møter som er en del av prosesser som er unntatt offentlighet (typisk grunnet komitéarbeid eller arbeid med sikkerhetspolitiske spørsmål). 

### Hvordan gjør vi det enklest mulig å slå opp i møtene?

Vi bygger et søk og filter.

### Hvordan gjør vi det enklest mulig å registrere møtene?

Hovedutfordringen er å gjøre det enkelt nok for stortingsrepresentanter og politiske rådgivere å registrere møter som skal i registeret. Uten det, så får vi ikke inn data, og uten data har vi ikke noe lobbyregister å vise frem.

Derfor ønsker vi koble oss på representantenes kalendre og hente ut informasjon derifra. 

Dette gir noen andre utfordringer som må løses:

- Hvordan gjør vi det så enkelt som mulig for representanten å velge hvilke møter som skal i registeret og hvilke som ikke skal i registeret? (Dette jobber vi med nå)
- Hvordan sikrer vi at representantens ikke-registrerte kalender er trygg, selv om Russland skulle bryte seg inn og ta over våre servere? (Vi lagrer ikke  informasjon om møter som ikke skal i registeret, og oAuth-tokens holdes enten kryptert og client side, eller kryptert og tidsbegrenset)
- Hvordan sikrer vi personvernet til de som har møtt med representantene? (Dette jobber vi med nå)

### Hvorfor ikke bare et google sheet?

Partiene [MDG](https://www.mdg.no/lobbyregister) og [Rødt](https://roedt.no/lobbyregister) har lagt ut oversikter over sine møter med lobbyister som regneark. Hvorfor ikke bare gjøre det?

Tre grunner: 

- Et regneark er mer jobb for representantene, som må huske å loggføre der for hvert møte de har. Jo større partigruppe, jo vanskeligere blir det å vedlikeholde og holde oppdatert. Vi håper å lage noe som skalerer til en større partigruppe.
- Et regneark begrenser mulighetene til å vise og samle data, og gir ulike standarder for hvert parti som gjør det vanskelig å se sammenhenger og sammenligne partienes møter. Vi vil gjerne lage noe som kan bli felles for alle partiene.
- Vi ønsker bevise for Stortingets administrasjon og partiene som er mot et lobbyregister at det er teknisk mulig å få til en enkel løsning uten at det krever masse manuelt arbeid og dobbeltføring av møter. Da tror vi at vi trenger mer finesse enn et google sheet.

For øvrig tar vi hatten av til de som fører lobbyregister hos disse partiene, og samarbeider gjerne om å lage noe felles med dem!

## Personvern

Når vi håndterer kalendrene til representantene og partiene er det viktig å ta vare på personvern, både til representanten og ikke minst til de som besøker oss. Ikke alle møter i en jobbkalender handler om jobb, og stortingsrepresentanter har ofte møter med varslere eller andre som det ikke er naturlig å dele i et offentlig lobbyregister. 

Vi jobber med hvordan vi skal få til en god løsning for personvern - men tar utgangspunkt i å lagre minst mulig data som ikke skal publiseres.
