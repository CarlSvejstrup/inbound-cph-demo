---
name: onboard
description: Onboarder en Inbound CPH-bruger til Kunde Specialist-setup'et. Tager dem gennem en kort dansk samtale i tre trin, og sætter en lokal CLAUDE.md + guide.docx op i deres arbejdsmappe. Brug når en kollega siger "jeg har lige installeret det her", "hvordan kommer jeg i gang", "onboard mig", "hvad gør pluginet", "sæt mig op for <kunde>", eller tilsvarende på engelsk.
---

# onboard

Tag en ny Inbound CPH-bruger gennem opsætningen, på dansk, så de kan køre deres første kundeworkflow inden for fem minutter.

## Hvornår skal du bruge denne skill

Triggerudtryk: "onboard mig", "jeg har lige installeret inbound-cph", "hvordan kommer jeg i gang", "hvad gør pluginet", "sæt mig op", "første gang jeg bruger det her", "vis mig rundt", "onboard me", "set me up", "how do I get started".

## Sådan kører du onboarding

Onboarding er en samtale, men kort. Tre trin, ét reelt stoppunkt. Lad ikke brugeren drukne i tekst.

### Trin 1 — Velkomst, hvad det er, og find arbejdsmappen

Skriv én sammenhængende besked:

"Velkommen til Inbound CPH's Kunde Specialist setup. Jeg tager dig gennem det på et par minutter, på dansk.

Det her er et sæt værktøjer der hjælper dig med at arbejde hurtigere på dine kunder — briefs, analyser, ugentlig status, voice-tjek. Værktøjerne læser fra Inbound's Drive (du er allerede koblet på via Cowork), og giver dig udkast tilbage.

To regler at huske:
- Alt der ændrer noget hos kunden (Drive, mail, Slack) skal du godkende først.
- Alt jeg læser er frit. Jeg henter selv det jeg skal bruge.

Lad mig lige finde ud af hvor du arbejder."

Tjek derefter det aktive working directory.

- **Hvis der findes en `01-brand/`-undermappe** i cwd (eller i forældermappen), så er brugeren i en kundemappe. Udled kundens navn fra mappenavnet. Skriv: "Jeg kan se du står i `<kunde>`-mappen. Skal jeg sætte den op til dig? (j/n)"
- **Hvis ikke i en kundemappe:** skriv "Jeg kan ikke se en kundemappe i den mappe du står i. Skift til kundens mappe i Cowork (en af undermapperne i `inbound-cph/` på Drive), og kør `/inbound-cph:onboard` igen. Vil du gerne se værktøjerne i mellemtiden? (j/n)" — hvis `j`, spring direkte til trin 3 uden at skrive filer. Hvis `n`, slut samtalen.

### Trin 2 — Skriv setup-filerne (kun hvis kundemappe + `j`)

**Vigtig undtagelse fra write-gate-reglen:** trin 2 skriver to filer uden at spørge om eksplicit godkendelse for hver fil. Brugeren har allerede godkendt selve setup'et med `j` i trin 1. De to filer er installation, ikke indhold — de tilhører brugerens egen arbejdsmappe og er genereret fra plugin-templates. Skriv dem direkte.

**Fil 1 — `./CLAUDE.md`** (kunde-specifik, genereret fra template):

Læs `${CLAUDE_PLUGIN_ROOT}/skills/onboard/templates/CLAUDE.md.template`, erstat `<KUNDE>` med kundens navn, og skriv resultatet til `./CLAUDE.md` i det aktive working directory.

**Fil 2 — `./guide.docx`** (generisk, identisk for alle setups):

Kopier `${CLAUDE_PLUGIN_ROOT}/skills/onboard/templates/guide.docx` direkte til `./guide.docx` i det aktive working directory. Ingen ændringer, ingen rendering — ren filkopi.

**Hvis `./guide.docx` allerede findes:** spørg "Du har allerede en `guide.docx` i mappen. Skal jeg overskrive den med den nyeste version? (j/n)" Overskriv kun ved `j`.

### Trin 3 — Værktøjerne, reglerne, klar (én besked)

Skriv én sammenhængende besked. Hvis trin 2 kørte, indled med bekræftelsen. Hvis ikke (brugeren ville bare se værktøjerne), spring bekræftelsen over.

"Gjort. To filer er nu i `<kunde>`-mappen:
- `CLAUDE.md` — aktiverer reglerne for hver session du kører her
- `guide.docx` — en kort guide du kan åbne i Word eller Pages og komme tilbage til

Værktøjerne du kan bruge:
- `/inbound-cph:client-brief` — en sides brief på en kunde
- `/inbound-cph:proactivity-scan` — tre proaktive anbefalinger
- `/inbound-cph:weekly-pulse` — ugentlig statusopdatering
- `/inbound-cph:voice-check` — tjek om en tekst rammer kundens tone
- `/inbound-cph:onboard` — den her samtale

Tre ting at huske:
1. Jeg skriver aldrig noget ud (mail, Drive, ændringer hos kunden) uden du siger ja først.
2. Hver kunde har sin egen tone — læs `01-brand/voice.md` før du skriver klientvendt copy.
3. Hvis noget ser forkert ud, sig til. Jeg gætter ikke på data.

Du er klar. Prøv `/inbound-cph:client-brief` for at se det første værktøj i aktion."

## Regler

- Hele samtalen kører på dansk. Skift kun til engelsk hvis brugeren skriver til dig på engelsk eller eksplicit beder om det.
- Brug ikke AI/ML-jargon. Sig "værktøj" ikke "skill" i forklaringer (slash-kommandoerne hedder selvfølgelig stadig `/inbound-cph:skill-name` fordi det er den faktiske kommando). Sig "instruks" ikke "prompt". Sig "viden om kunden" ikke "context".
- Trin 2 er den eneste undtagelse fra plugin-CLAUDE.md's write-gate — fordi det er installation af brugerens eget setup, ikke indhold der lander hos kunden. Alle andre skills i pluginet (voice-check, client-brief, osv.) overholder write-gate som normalt.
- Det eneste reelle stoppunkt er `j/n` i trin 1. Resten flyder.
- Hvis brugeren afbryder eller siger "spring over", respektér det — onboard skal være hurtig, ikke fuldstændig.

## Drive-adgang

Pluginet bundler ikke en Drive MCP. Det bruger Cowork's indbyggede Google Drive-connector (`mcp__claude_ai_Google_Drive__*`). Brugeren har allerede autoriseret Drive på Cowork-niveau.

Drive-rodmappen er konfigureret via `userConfig.inbound_root_folder_id` i `plugin.json`. Default er `inbound-cph/`-mappen i agency-Drevet (ID `17JwnWKToZSJUSCURjS9PzzBeqe6_gPfi`). Hvis en bruger spørger til hvilken mappe pluginet læser fra, sig: "Pluginet er sat op til at læse fra `inbound-cph/` i Drive. Hvis du vil pege på en anden mappe, skal du opdatere `inbound_root_folder_id` i plugin-indstillingerne."
