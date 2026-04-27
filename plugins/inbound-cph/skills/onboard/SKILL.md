---
name: onboard
description: Onboarder en Inbound CPH-bruger til Kunde Specialist-setup'et. Tager dem gennem en kort dansk samtale, bekræfter at deres cwd er den rigtige generelle arbejdsmappe, og lægger en CLAUDE.md + guide.docx der. Brug når en kollega siger "jeg har lige installeret det her", "hvordan kommer jeg i gang", "onboard mig", "hvad gør pluginet", eller tilsvarende på engelsk.
---

# onboard

Tag en ny Inbound CPH-bruger gennem opsætningen, på dansk, så de kan køre deres første kundeworkflow inden for fem minutter.

## Hvornår skal du bruge denne skill

Triggerudtryk: "onboard mig", "jeg har lige installeret inbound-cph", "hvordan kommer jeg i gang", "hvad gør pluginet", "sæt mig op", "første gang jeg bruger det her", "vis mig rundt", "onboard me", "set me up", "how do I get started".

## Sådan kører du onboarding

Onboarding er en samtale, men kort. Tre trin, ét reelt stoppunkt. Lad ikke brugeren drukne i tekst.

### Trin 1 — Velkomst og hvad det er (én besked, intet stoppunkt)

Skriv:

"Velkommen til Inbound CPH's Kunde Specialist setup. Jeg tager dig gennem det på et par minutter, på dansk.

Det her er et sæt værktøjer der hjælper dig med at arbejde hurtigere på dine kunder — briefs, analyser, ugentlig status, voice-tjek. Værktøjerne læser fra Inbound's Drive (du er allerede koblet på via Cowork), og giver dig udkast tilbage. Du behøver ikke vælge en kunde på forhånd — du nævner bare kundens navn når du kører et værktøj.

To regler at huske:
- Alt der ændrer noget hos kunden (Drive, mail, Slack) skal du godkende først.
- Alt jeg læser er frit. Jeg henter selv det jeg skal bruge fra Drive."

Gå direkte videre til trin 2 — ingen pause her.

### Trin 2 — Bekræft arbejdsmappen (ét stoppunkt)

Find det aktive working directory (cwd) og skriv:

"Jeg vil lægge to filer her: en `CLAUDE.md` (aktiverer reglerne for hver session) og en `guide.docx` (opslagsbog du kan åbne i Word eller Pages).

Mappen jeg står i lige nu er:
  `<cwd>`

Det er meningen at det her er din generelle arbejdsmappe — det sted du arbejder ud fra på tværs af flere kunder. Du behøver ikke en mappe per kunde, fordi kundernes data ligger i Drive.

Er det den rigtige mappe? (ja/nej)"

Vent på `ja` eller `nej`.

- **Hvis `nej`:** skriv "Skift til den rigtige mappe i Cowork og kør `/inbound-cph:onboard` igen." Slut samtalen.
- **Hvis `ja`:** gå videre til trin 3 og skriv filerne.

### Trin 3 — Skriv filerne, vis værktøjerne, klar (én besked)

**Vigtig undtagelse fra write-gate-reglen:** trin 3 skriver to filer uden at spørge om eksplicit godkendelse for hver fil. Brugeren har allerede godkendt setup'et med `ja` i trin 2. De to filer er installation, ikke indhold — de tilhører brugerens egen arbejdsmappe og er genereret fra plugin-templates. Skriv dem direkte.

**Fil 1 — `./CLAUDE.md`** (generisk arbejdsmappe-template):

Kopier `${CLAUDE_PLUGIN_ROOT}/skills/onboard/templates/CLAUDE.md.template` direkte til `./CLAUDE.md` i det aktive working directory. Ingen substitutioner — det er en arbejdsmappe-fil, ikke kundespecifik.

**Fil 2 — `./guide.docx`** (generisk, identisk for alle setups):

Kopier `${CLAUDE_PLUGIN_ROOT}/skills/onboard/templates/guide.docx` direkte til `./guide.docx` i det aktive working directory. Ingen ændringer, ingen rendering — ren filkopi.

**Hvis `./guide.docx` allerede findes:** spørg "Du har allerede en `guide.docx` i mappen. Skal jeg overskrive den med den nyeste version? (ja/nej)" Overskriv kun ved `ja`.

Skriv så én sammenhængende besked:

"Gjort. To filer er nu i din arbejdsmappe:
- `CLAUDE.md` — aktiverer reglerne for hver session du kører her
- `guide.docx` — kort opslagsbog du kan åbne i Word eller Pages

Værktøjerne du kan bruge:
- `/inbound-cph:client-brief` — en sides brief på en kunde
- `/inbound-cph:proactivity-scan` — tre proaktive anbefalinger
- `/inbound-cph:weekly-pulse` — ugentlig statusopdatering
- `/inbound-cph:voice-check` — tjek om en tekst rammer kundens tone
- `/inbound-cph:onboard` — den her samtale

Tre ting at huske:
1. Jeg skriver aldrig noget ud (mail, Drive, ændringer hos kunden) uden du siger ja først.
2. Hver kunde har sin egen tone — læs `<kunde>/01-brand/voice.md` i Drive før du skriver klientvendt copy.
3. Hvis noget ser forkert ud, sig til. Jeg gætter ikke på data.

Du er klar. Prøv `/inbound-cph:client-brief <kundenavn>` for at se det første værktøj i aktion."

## Regler

- Hele samtalen kører på dansk. Skift kun til engelsk hvis brugeren skriver til dig på engelsk eller eksplicit beder om det.
- Brug `ja` og `nej` som bekræftelses-ord — ikke `j/n`.
- Brug ikke AI/ML-jargon. Sig "værktøj" ikke "skill" i forklaringer (slash-kommandoerne hedder selvfølgelig stadig `/inbound-cph:skill-name` fordi det er den faktiske kommando). Sig "instruks" ikke "prompt". Sig "viden om kunden" ikke "context".
- Trin 3 er den eneste undtagelse fra plugin-CLAUDE.md's write-gate — fordi det er installation af brugerens eget setup, ikke indhold der lander hos kunden. Alle andre skills i pluginet (voice-check, client-brief, osv.) overholder write-gate som normalt.
- Det eneste reelle stoppunkt er `ja/nej` i trin 2. Resten flyder.
- Hvis brugeren afbryder eller siger "spring over", respektér det — onboard skal være hurtig, ikke fuldstændig.
- Antag aldrig at brugeren står i en kundespecifik mappe. cwd er en generel arbejdsmappe på tværs af kunder. Kig ikke efter `01-brand/`-undermapper eller noget kundespecifikt på filsystemet — kundernes data ligger i Drive, ikke lokalt.

## Drive-adgang

Pluginet bundler ikke en Drive MCP. Det bruger Cowork's indbyggede Google Drive-connector (`mcp__claude_ai_Google_Drive__*`). Brugeren har allerede autoriseret Drive på Cowork-niveau.

Drive-rodmappen er konfigureret via `userConfig.inbound_root_folder_id` i `plugin.json`. Default er `inbound-cph/`-mappen i agency-Drevet (ID `17JwnWKToZSJUSCURjS9PzzBeqe6_gPfi`). Hvis en bruger spørger til hvilken mappe pluginet læser fra, sig: "Pluginet er sat op til at læse fra `inbound-cph/` i Drive. Hvis du vil pege på en anden mappe, skal du opdatere `inbound_root_folder_id` i plugin-indstillingerne."
