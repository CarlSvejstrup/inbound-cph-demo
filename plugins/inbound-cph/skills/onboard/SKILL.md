---
name: onboard
description: Onboarder en Inbound CPH-bruger til Kunde Specialist-setup'et. Tager dem gennem en kort dansk samtale, og sætter en lokal CLAUDE.md + guide.docx op i deres arbejdsmappe. Brug når en kollega siger "jeg har lige installeret det her", "hvordan kommer jeg i gang", "onboard mig", "hvad gør pluginet", "sæt mig op for <kunde>", eller tilsvarende på engelsk.
---

# onboard

Tag en ny Inbound CPH-bruger gennem opsætningen, på dansk, så de kan køre deres første kundeworkflow inden for ti minutter.

## Hvornår skal du bruge denne skill

Triggerudtryk: "onboard mig", "jeg har lige installeret inbound-cph", "hvordan kommer jeg i gang", "hvad gør pluginet", "sæt mig op", "første gang jeg bruger det her", "vis mig rundt", "onboard me", "set me up", "how do I get started".

## Sådan kører du onboarding

Onboarding er en samtale, ikke en mur af tekst. Kør de syv trin nedenfor i rækkefølge. Vent på et "klar", "ja", "fortsæt" eller lignende efter hvert trin før du går videre. Sig kun det der står — ikke længere forklaringer.

### Trin 1 — Velkomst

Skriv: "Velkommen til Inbound CPH's Kunde Specialist setup. Jeg tager dig gennem det på fem minutter, på dansk. Sig til når du er klar."

Vent på bekræftelse.

### Trin 2 — Hvad er det her?

Skriv:

"Det her er et sæt værktøjer der hjælper dig med at arbejde hurtigere på dine kunder — briefs, analyser, ugentlige status, voice-tjek.

To regler at huske allerede nu:
- Alt der ændrer noget hos kunden (Drive, mail, Slack) skal du godkende først.
- Alt jeg læser er frit. Jeg henter selv det jeg skal bruge.

Klar til næste trin?"

Vent på bekræftelse.

### Trin 3 — Hvor arbejder du?

Tjek det aktive working directory. Hvis der findes en `01-brand/`-undermappe, så er brugeren i en kundemappe, og kundens navn kan udledes fra mappenavnet (eller forældermappen).

- **Hvis i en kundemappe:** skriv "Jeg kan se du står i `<kunde>`-mappen. Skal jeg sætte den op til dig? (j/n)"
- **Hvis ikke i en kundemappe:** skriv "Hvilken kunde arbejder du på lige nu? Når du står i kundens mappe i Cowork, kan jeg sætte alt op." Vent på svar. Hvis brugeren navngiver en kunde men ikke står i mappen, sig: "Skift til kundens mappe i Cowork, og kør `/inbound-cph:onboard` igen — så finder jeg den selv."

Vent på `j`/`ja`/`yes` før du går videre til trin 4. Hvis brugeren siger nej, spring til trin 5.

### Trin 4 — Skriv setup-filerne (auto, ingen write-gate)

**Vigtig undtagelse fra write-gate-reglen:** trin 4 skriver to filer uden at spørge om eksplicit godkendelse for hver fil. Brugeren har allerede godkendt selve setup'et med `j` i trin 3. De to filer er installation, ikke indhold — de tilhører brugerens egen arbejdsmappe og er genereret fra plugin-templates. Skriv dem direkte.

**Fil 1 — `./CLAUDE.md`** (kunde-specifik, genereret fra template):

Læs `${CLAUDE_PLUGIN_ROOT}/skills/onboard/templates/CLAUDE.md.template`, erstat `<KUNDE>` med kundens navn, og skriv resultatet til `./CLAUDE.md` i det aktive working directory.

**Fil 2 — `./guide.docx`** (generisk, identisk for alle setups):

Kopier `${CLAUDE_PLUGIN_ROOT}/skills/onboard/templates/guide.docx` direkte til `./guide.docx` i det aktive working directory. Ingen ændringer, ingen rendering — ren filkopi.

**Hvis `./guide.docx` allerede findes:** spørg "Du har allerede en `guide.docx` i mappen. Skal jeg overskrive den med den nyeste version? (j/n)" Overskriv kun ved `j`.

Bekræft tilbage: "Gjort. To filer er nu i `<kunde>`-mappen:
- `CLAUDE.md` — aktiverer reglerne for hver session du kører her
- `guide.docx` — en kort guide du kan åbne i Word eller Pages og komme tilbage til"

### Trin 5 — Værktøjerne

Skriv:

"Her er værktøjerne du kan bruge:

- `/inbound-cph:client-brief` — en sides brief på en kunde
- `/inbound-cph:proactivity-scan` — tre proaktive anbefalinger
- `/inbound-cph:weekly-pulse` — ugentlig status-opdatering
- `/inbound-cph:voice-check` — tjek om en tekst rammer kundens tone
- `/inbound-cph:onboard` — den her samtale

Du kører dem ved at skrive kommandoen i Cowork. Klar til de sidste to ting?"

Vent på bekræftelse.

### Trin 6 — Tre ting at huske

Skriv:

"Tre ting at huske:

1. Jeg skriver aldrig noget ud (mail, Drive, ændringer hos kunden) uden du siger ja først.
2. Hver kunde har sin egen tone, læs `01-brand/voice.md` før du skriver klientvendt copy.
3. Hvis noget ser forkert ud, sig til. Jeg gætter ikke på data."

### Trin 7 — Klar

Skriv:

"Du er klar. Prøv `/inbound-cph:client-brief` for at se det første værktøj i aktion. Og åbn `guide.docx` hvis du vil have et opslagsværk ved hånden."

## Regler

- Hele samtalen kører på dansk. Skift kun til engelsk hvis brugeren skriver til dig på engelsk eller eksplicit beder om det.
- Brug ikke AI/ML-jargon. Sig "værktøj" ikke "skill" i forklaringer (slash-kommandoerne hedder selvfølgelig stadig `/inbound-cph:skill-name` fordi det er den faktiske kommando). Sig "instruks" ikke "prompt". Sig "viden om kunden" ikke "context".
- Trin 4 er den eneste undtagelse fra plugin-CLAUDE.md's write-gate — fordi det er installation af brugerens eget setup, ikke indhold der lander hos kunden. Alle andre skills i pluginet (voice-check, client-brief, osv.) overholder write-gate som normalt.
- Vent altid på bekræftelse mellem trin. Lad ikke brugeren drukne i tekst.
- Hvis brugeren springer trin over ("bare gå videre"), respektér det — onboard skal være hurtig, ikke fuldstændig.
