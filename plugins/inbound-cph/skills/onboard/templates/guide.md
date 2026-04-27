% Guide til Kunde Specialist
% Inbound CPH

# Hvad er det her?

Du har installeret et sæt værktøjer der hjælper dig med at arbejde hurtigere på dine kunder. Du bruger dem inde i Cowork ved at skrive kommandoer som starter med `/inbound-cph:` — for eksempel `/inbound-cph:client-brief`.

Værktøjerne læser fra Google Drive, henter det de skal bruge, og giver dig et udkast eller en analyse tilbage.

Denne guide er din opslagsbog. Den er ikke noget du behøver læse fra ende til anden. Kom tilbage når du er i tvivl.

# Hvor ligger hvad?

Tre steder, tre formål.

## 1. Google Drive — alt om kunderne

Hver kunde har sin egen mappe i Inbound-drevet. Strukturen er den samme for alle:

- `01-brand/` — brand.md, voice.md, kpis.md
- `02-past-reports/` — tidligere leverancer
- `03-meetings/` — mødenoter, navngivet ÅÅÅÅ-MM-DD-emne.md
- `04-memory/client-memory.md` — den vigtigste fil
- `05-data/` — CSV-filer, Semrush-eksporter, snapshots
- `06-decisions/` — beslutninger, navngivet ÅÅÅÅ-MM-DD-emne.md

`04-memory/client-memory.md` er den vigtigste fil. Det er her vi skriver permanente noter om kunden — hvad der virker, hvad der ikke virker, hvad de har sagt på møder, hvad de hader. Det er den fil der gør at vi kan blive bedre over tid.

**Tommelfingerregel:** alt om en specifik kunde hører hjemme i deres Drive-mappe. Aldrig kun her i Cowork.

## 2. Pluginet (inbound-cph) — alt om hvordan vi arbejder

Pluginet er det sæt værktøjer du har installeret. Det indeholder:

- **Værktøjerne** — client-brief, voice-check, weekly-pulse, og så videre.
- **Reglerne** — hvordan agenten skal opføre sig (skriver aldrig uden at spørge, læser kundens voice.md før den skriver, og så videre).
- **Baggrundsviden om Inbound** — hvem vi er, hvilke værktøjer vi bruger, vores egen tone-of-voice.

Når Carl eller andre opdaterer pluginet på GitHub, kan du opdatere det i Cowork ved at trykke "Update" på plugin-kortet. Så får du de nyeste regler og værktøjer.

Du behøver ikke vide hvordan pluginet er bygget. Du skal bare bruge værktøjerne.

## 3. Din arbejdsmappe i Cowork — hvor du står lige nu

Når du arbejder på en kunde, "står" du i kundens mappe i Cowork. Det er der hvor:

- Den lokale `CLAUDE.md` ligger (den onboard skrev til dig). Den fortæller agenten hvilken kunde du arbejder på.
- Denne `guide.docx` ligger (filen du læser nu).
- Dine værktøjer kører fra.

Hvis du skifter til en anden kunde, skifter du mappe i Cowork. Så ved agenten automatisk hvilken kunde der er aktiv.

# De vigtigste regler

1. **Agenten skriver aldrig noget eksternt uden du siger ja først.** Det gælder mails, Drive-filer, opdateringer i kundens hukommelse. Den viser dig altid et udkast og venter på din godkendelse.

2. **Du må gerne lade agenten læse alt.** Den henter selv det den skal bruge fra Drive — du behøver ikke fortælle den hvor tingene ligger. Læsning er gratis og hurtig.

3. **Hver kunde har sin egen tone.** Læs altid kundens `01-brand/voice.md` før du skriver klientvendt copy. Brug `/inbound-cph:voice-check` til at tjekke om et udkast rammer tonen.

4. **Spørg hvis noget ser forkert ud.** Agenten gætter ikke på data. Hvis et tal eller en konklusion virker mærkelig, så spørg den om at vise hvor det kommer fra.

# Værktøjerne kort fortalt

| Kommando | Hvad den gør | Hvornår du bruger den |
|---|---|---|
| `/inbound-cph:client-brief` | En sides brief på kunden — brand, voice, KPIs, sidste 3 møder | Før et kundemøde, eller når en kollega skal tage over |
| `/inbound-cph:proactivity-scan` | Tre proaktive anbefalinger baseret på data og hukommelse | Inden næste call, for at have noget at byde ind med |
| `/inbound-cph:weekly-pulse` | To minutters statusopdatering — hvad har bevæget sig siden sidst | Hver uge, eller når du kommer tilbage efter ferie |
| `/inbound-cph:voice-check` | Tjekker om et udkast rammer kundens tone | Før du sender mails, ads, eller copy ud |
| `/inbound-cph:onboard` | Den her onboarding | Første gang du sætter en ny kundemappe op |

# Når noget ikke virker

- **Værktøjet svarer ikke på dansk:** mind den om det — "svar på dansk".
- **Værktøjet vil skrive noget du ikke har bedt om:** sig "skip" eller "ikke endnu". Den skal have eksplicit "ja" for at skrive.
- **Værktøjet kan ikke finde kundens data:** tjek at du står i den rigtige mappe i Cowork, og at kundens Drive-mappe har de seks undermapper (01-brand, 02-past-reports, og så videre).
- **Værktøjet er forældet:** gå til marketplace, tryk `...` ved siden af `inbound-cph-demo`, vælg "refresh" eller "update". Tryk derefter "Update" på selve pluginet.

# Hvor finder jeg mere?

- **Inbound-specifik baggrund:** spørg agenten "fortæl om Inbound" — den læser fra plugin-dokumentationen.
- **Kunden specifikt:** spørg "brief mig på <kunde>" eller kør `/inbound-cph:client-brief`.
- **Tekniske spørgsmål om pluginet eller Cowork:** spørg Carl.
