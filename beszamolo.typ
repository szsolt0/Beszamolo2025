#set document(
  title: "Beszámoló szakmai gyakorlatról",
  author: "Sebe Zsolt (ACC02G)",
  // the deathline of the report is the closest to an official "creation date"
  // letting this to be set automaticly breaks reproductible builds :(
  date: datetime(year: 2025, month: 9, day: 19),
)

// GDScript support
// https://github.com/dementive/SublimeGodot
#set raw(syntaxes: "GDScript.sublime-syntax")

// nice looking codeblocks
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init

// extra icons
#import "@preview/fontawesome:0.6.0": *

#codly(
  languages: (
    gd: (
      name: [GDScript],
      icon: box(image("images/godot-icon.svg", height: 0.9em)) + h(0.25em),
    ),
    ..codly-languages,
  ),
)

#set heading(
  numbering: "1.1",
)

#set smartquote(
  quotes: sym.quote.l + sym.quote.r
)

// set main font and language
#set text(
  lang: "hu",
  font: "New Computer Modern",
  weight: "medium",
  size: 12pt,
)

// set code font
#show raw: set text(
  font: "IBM Plex Mono",
  weight: "regular",
)

#set par(
  justify: true,
)

// disable justified text inside tables
#show table: set par(
  justify: false,
)

// this prevents having too much empty space because of figures
#set figure(
  placement: top,
)

// make table captions on top (default is bottom)
#show figure.where(kind: table): set figure.caption(position: top)

// links to documentation
#let docs(path, txt) = box(link("https://janossandor2002.github.io/SzakGyak/" + path)[
  #set text(blue)
  #txt
])

#let commit(hash) = box[
  #set text(blue)
  #let short-hash = hash.slice(0, 7)
  #link("https://github.com/JanosSandor2002/SzakGyak/commit/" + hash, text(0.9em, fa-icon("git-alt")) + sym.space.med + raw(short-hash))
]

// cover page
#include "cover.typ"
#pagebreak()

// table of contents
#outline()
#pagebreak()

// page numbering
#set page(
  numbering: "1"
)

// reset page numbering
#counter(page).update(1)

= A feladat bemutatása

A "Túlélés a Szocializmusban" című játék egy túlélés-orientált
szimuláció, amely a szocialista korszak mindennapjainak nehézségeit és
sajátos társadalmi dinamikáját dolgozza fel. A játék célja, hogy a
játékos egy államilag szabályozott, korlátozott lehetőségeket kínáló
rendszerben találja meg a túlélés útját -- akár törvényes, akár
féllegális eszközökkel. A projekt célközönsége a komolyabb hangvételű
szimulációs élményeket kereső játékosok, akik érdeklődnek a történelmi
ihletésű, morális döntéseket is tartalmazó játékmenetek iránt.

A játék cselekménye egy fiktív, ám a valódi szocialista rendszerek
jegyeit idéző világban játszódik. A játékos feladata, hogy saját és
családja mindennapi megélhetését biztosítsa egy gazdaságilag nyomott,
bizonytalanságokkal teli korszakban, ahol a legkisebb döntés is súlyos
következményekkel járhat.

A játékmenet középpontjában a túlélés áll: a játékos folyamatosan
mérlegeli, hogyan ossza be idejét és szűkös erőforrásait a munka, a
család, valamint a saját testi-lelki állapotának megőrzése között.

= Technológia kiválasztása

A projekt fejlesztéséhez csapatunk a Godot Game Engine-t választotta. A
Godot egy nyílt forráskódú, platformfüggetlen játékmotor, amely
támogatja a 2D és 3D játékfejlesztést egyaránt. @salmela2022game @holfeld2023relevance
A motor fő előnyei közé tartozik a könnyű kezelhetőség, a gyors
prototípus-készítés lehetősége, valamint a beépített vizuális
szerkesztő, amely megkönnyíti a jelenetek és erőforrások kezelését.

= A tervezés folyamata

A projekt tervezése során a feladatokat igyekeztünk átláthatóan és egyenletesen
elosztani egymás között, ugyanakkor mindenkinek lehetősége volt a saját érdeklődési
körének és erősségeinek megfelelően hozzájárulni a közös munkához. A folyamat során
a rendszeres megbeszélések és konzultációk biztosították, hogy a dokumentáció és
a fejlesztés egységes irányt kövessen.

== Dokumentáció

Az első időszakban főként az adminisztratív feladatokra koncentráltunk: közösen
megbeszéltük a kezdeti dokumentáció felépítését, valamint felosztottuk a
feladatokat. Ezt követően sor került a verziókövetéshez szükséges eszközök
(git, GitHub) és a dokumentációs környezet (MkDocs) beállítására, illetve
a projekt weboldalának elkészítésére. Ezekhez a munkákhoz személyesen is
hozzájárultam, különösen az MkDocs beüzemelésével (#commit("2534f040bfb43abab5b17724184ebf690d2dd58f")).

A tervezési fázis másik fontos része a közös vízió megalkotása és felosztása volt.
Ezekhez aktívan részt vettem a megbeszéléseken, ahol a felmerülő ötletek alapján
javaslatokat dolgoztunk ki, majd kidolgoztam a rendszer lehetséges
megoldásait és a funkcionális, valamint nem funkcionális követelményeket (#commit("6e34a5ad977cf5f30958ae519f3f9414787c71c6")).
Emellett közreműködtem az SRS dokumentum "Bevezetés", "Áttekintés", és "Használhatóság" részeinek
megírásában (#commit("6dee4b4ac00414dd2861886a3f7e7ea8c1ce2db9")), az @fig:components elkészítésével, valamint a
kezdeti formázási és technikai hibák javításában (#commit("b720b3985090bcfeaf85b58573f83c9c8b35b055")).

#figure(
  caption: [A játék fő alrendszereinek komponensdiagramja és azok kapcsolatai],
  image("images/components.svg"),
) <fig:components>

== Telepítés

A Godot telepítését a `dnf install godot` parancs segítségével végeztem
el.

== Fejlesztés

A későbbiekben a hangsúly fokozatosan a gyakorlati fejlesztés előkészítésére helyeződött.
Részt vettem a Godot mappastruktúrájának megtervezésében és a scenes rendszer
átbeszélésében. Különösen hasznosnak bizonyultak ezek a megbeszélések, hiszen
segítettek abban, hogy a későbbi fejlesztési munkák egységes alapokra épüljenek.

A menürendszer mellett a HUD felület, a mentéskezelő és a beállítási rendszer
(#commit("0225e118ab3397fae12ac6afce762871863283e6"),
#commit("739f471ca3ede44288706c2369f3e5327c9502e9"),
#commit("13674a29b840daab9af4a9b9c3e28d4ec8997546"),
#commit("df1a05dd0e84c8f90475773065d4f31486cb5970"))
kialakítását is én végeztem. Ez utóbbi nemcsak a felhasználói beállítások mentését
biztosította, hanem a hangkezelő rendszert is: a program a felhasználó által választott
hangerőszinteket elmentette, majd automatikusan a megfelelő Godot audióbuszokra állította be,
biztosítva a játék testreszabható és konzisztens hangélményét.

A projekt keretében sajnos nem sikerült a játék teljes funkcionalitását
megvalósítani, így a fejlesztett modulok jelenleg csak a demó jellegű részeket
tartalmazzák.
Ennek ellenére a kialakított rendszerek stabil alapot nyújtanak a további
bővítéshez és teszteléshez, valamint a fejlesztési folyamat során szerzett
tapasztalatok értékesek a jövőbeli munkák szempontjából.

= Implementáció

== Mentési Rendszer

A játékon belüli mentések kezelésére saját mentési rendszert dolgozotunk ki,
amelynek megvalósítását én vállaltam (#commit("4a2df1dde16e45bd6ae0d93febf4776f924d49fc")).
A megoldás alapja két függvény:

```gd
func save_state(
    ns: StringName,
    state: Dictionary[StringName, Variant]
) -> Error

func load_state(ns: StringName) -> Dictionary
```

Az ```gd ns``` paraméter egyfajta névtérként (namespace) működik, így a játék különböző
részei elkülönítve tárolhatják az állapotukat. A ```gd load_state()```
visszaadja az adott névtérhez korábban elmentett adatokat, vagy üres szótárat,
ha még nincs tárolt állapot.

A mentések atomikusan történnek: először ideiglenes fájlba írjuk az adatokat,
majd átnevezés után válnak érvényessé. Így biztosítható, hogy vagy a teljes új
mentés, vagy a korábbi állapot maradjon meg, elkerülve a fájlok részleges
korruptálódását.

A mentések JSON formátumban kerülnek tárolásra. A legfelső szint egy
objektum, amelyben minden kulcs a megfelelő ```gd ns``` névtérnek felel meg.
A `__meta` egy speciális kulcs, amely a mentéshez tartozó metaadatokat
(rögzítés ideje, utolsó módosítás időpontja, felhasználónév stb.) tartalmazza.

```json
{
  "__meta": {
    "ctime": "2025-09-12 19:51:40",
    "mtime": "2025-09-12 19:56:09",
    "name": "LaptopGamer"
  },
  "shop": {
    "correct_answers": 0
  }
}


```

== Menürendszer

A projekt menürendszerét teljes egészében én valósítottam meg a Godot-ban.
A rendszer a játék különböző felületeit kezeli, beleértve a főmenüt,
a beállításokat, a mentések kezelését és a figyelmeztető üzeneteket.

A struktúra a következőképpen épült fel:

#no-codly[#block(breakable: false)[```
/scenes/menu/
├── hud_entry_family.{gd,tscn}
├── hud_entry_player.{gd,tscn}
├── hud.{gd,tscn}
├── main_menu.{gd,tscn}
├── new_save_menu.{gd,tscn}
├── save_delete_confirm.{gd,tscn}
├── save_entry.{gd,tscn}
├── save_select_menu.{gd,tscn}
├── settings_menu.{gd,tscn}
└── warn_menu.{gd,tscn}
```]]

A menük logikáját GDScript-ben implementáltam, a különböző jelenetek
érintkezését és a felhasználói interakciók kezelését biztosítva. A menürendszer
tartalmazza a mentések kiválasztását és létrehozását, a beállítások módosítását,
valamint a különböző HUD elemeket, melyek dinamikusan frissülnek a játék
állapota szerint. A menürendszer vizuális felépítését és egyes nézeteit az
@fig:menu és @fig:hud szemlélteti.

#figure(
  caption: [A játék menürendszerének fő nézetei, beleértve a főmenüt, a mentéskezelőt és a beállítási lehetőségeket],
  grid(
    columns: 3,
    gutter: 1em,
    ..for i in range(1, 7) {
      (image("images/menu-0" + str(i) + ".png"),)
    },
  ),
) <fig:menu>

#figure(
  caption: [A játék futás közben megjelenő HUD felülete Piotr (játékos) és Mihalina (családtag) karakterrel],
  grid(
    columns: 2,
    gutter: 1em,
    image("images/hud-piotr.png"),
    image("images/hud-mihalina.png"),
  ),
) <fig:hud>

=== Menürendszer részletesen

Az egyes elemek a következő feladatokat látják el:

- `hud_entry_family.{gd,tscn}`: Egy családhoz tartozó HUD elemek megjelenítése, az aktuális tag állapotának vizualizálása.
- `hud_entry_player.{gd,tscn}`: A játékos karakterének állapotát mutatja a HUD-on, beleértve életpontokat és egyéb státuszokat.
- `hud.{gd,tscn}`: A teljes HUD menedzsmentjét végzi, összehangolja az összes HUD-elem frissítését.
- `main_menu.{gd,tscn}`: A főmenüt valósítja meg, innen lehet új játékot indítani, betöltést kezdeményezni, vagy a beállításokat elérni.
- `save_delete_confirm.{gd,tscn}`: Mentés törlésének megerősítő párbeszédpanelje, biztonsági ellenőrzéssel.
- `save_entry.{gd,tscn}`: Egyetlen mentés bejegyzésének reprezentációja a mentésválasztó menüben.
- `save_select_menu.{gd,tscn}`: A mentések listázását és kiválasztását biztosító felület.
- `settings_menu.{gd,tscn}`: A játék beállításait kezelő felület, amely a hang-, grafikai és egyéb konfigurációk módosítását teszi lehetővé.
  A menü a ```gd GameSettings``` globális változó segítségével kezeli a beállításokat, és biztosítja azok betöltését és mentését.
  A hangbeállítások (master, SFX, zene, UI) a megfelelő audióbuszokra kerülnek alkalmazásra, így a változtatások azonnal érvényesülnek.
  A grafikai opciók között a videó minősége, animációk engedélyezése és betűtípus választás szerepel.
  A "Back" gomb a módosítások mentése után visszatér a szülő menübe.

- `new_save_menu.{gd,tscn}`: Az új mentés létrehozására szolgáló felület.
  A játékos itt megadhatja a mentés nevét és fájlazonosítóját, amelyeket a rendszer automatikusan megtisztít (szóközök, kis-/nagybetűk kezelése) és ellenőriz egy reguláris kifejezés alapján.
  A menü hibakezelést is biztosít: üres név vagy fájlnév esetén, érvénytelen fájlnév használatakor, illetve már létező mentés esetén a felület hibaüzeneteket jelenít meg.
  Sikeres létrehozáskor a ```gd SaveManager``` új mentést hoz létre, és a szülő menü értesítést kap a lista frissítéséről.

== Beállításkezelő Rendszer

A ```gd GameSettings``` modul felelős a játék globális konfigurációs
paramétereinek kezeléséért, ideértve a hang-, grafikai- és nyelvi beállításokat.
A modul biztosítja, hogy a felhasználó által végrehajtott változtatások a menün
keresztül vagy manuálisan a `settings.ini` fájl szerkesztésével is
érvényesüljenek.

A beállítások mentése atomikusan történik, pont úgy mint a mentéseknél.

A modul felel a hangbeállítások alkalmazásáért is: a felhasználó által megadott
hangerőszinteket automatikusan a megfelelő Godot audióbuszokra állítja.

A ```gd GameSettings``` a @tbl:game-settings által felsorolt beállításokat
kezeli.

#figure(
  caption: [A játék `settings.ini` fájljában tárolt beállítási lehetőségei],
  table(
    columns: (auto, auto, 1fr, auto),
    align: center + horizon,
    [*Név*], [*Típus*], [*Leírás*], [*Alapértelmezett*],

    `[volume]`, [], [Hangerő szabályok], [],
    `master`, `int [0, 100]`, [Master hangerő], `40`,
    `sfx`, `int [0, 100]`, [Effektusok hangereje], `100`,
    `music`, `int [0, 100]`, [Háttérzene hangereje], `100`,
    `ui`, `int [0, 100]`, [UI hangereje], `100`,

    `[video]`, [], [Grafikai beállítások], [],
    `quality`, [`low`, `medium`, `high`], [Grafika minőség], `medium`,
    `animations`, `bool`, [UI animációk engedélyezése], `true`,
    `font`, [`pixel`, `readable`], [Betűtípus], `pixel`,

    `[main]`, [], [Egyéb beállítások], [],
    `lang`, `string`, [Játék nyelve], `ask`,
    `content-warn-ack`, `bool`, [Tartalom figyelmeztetés elfogadva], `false`,
  ),
) <tbl:game-settings>

A `content-warn-ack` beállítás különleges jelentőséggel bír: a játék indításához
a tartalomfigyelmeztetés elfogadása kötelező. Ha a felhasználó még nem fogadta
el, a játék indításakor a figyelmeztetés megjelenik, és elfogadása után többé
nem kerül bemutatásra.

= Tesztelés

A projekt során a csapat kiemelt figyelmet fordított a tesztelésre, hogy a
fejlesztett rendszerek megbízhatóan működjenek, és a hibák korán
felderítésre kerüljenek. A tesztek több szinten valósultak meg, beleértve
a funkcionális ellenőrzéseket, az integrációs teszteket és az állapotmentési
rendszer ellenőrzését.

== Állapotmentési rendszert ellenőrző tesztek

Az általam készített tesztek a ```gd SaveManager``` működését vizsgálták (#commit("a75a868bfc31b29ecabe1a76dfcb875d7305168a")).
A tesztek célja
az volt, hogy ellenőrizzük a mentések létrehozását, betöltését, az adatok
helyes tárolását és a fájlok törlését. Ezek a tesztek biztosították, hogy a
mentések atomikusan történjenek, és a betöltött adatok megegyezzenek a
mentéskor tárolt értékekkel. A tesztek a projekt forrásában a `tests/test_save_manager.gd` fájlban találhatók.

A tesztek főbb ellenőrzéseit a @tbl:tests tartalmazza.


#figure(
  caption: [A ```gd SaveManager``` főbb funkcióit ellenőrző automatizált tesztek],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, left),

    //table.cell(colspan: 2)[*Mentés létrehozása*],
    `test_save_create`, [Ellenőrzi, hogy a ```gd SaveManager``` képes-e új mentésfájlokat létrehozni, és hogy a fájlok valóban megjelennek a mentési könyvtárban.],

    //table.cell(colspan: 2)[*Mentés metaadatok létezése*],
    `test_save_meta_exists`, [Ellenőrzi, hogy a mentésekhez tartozó metaadatok, például a mentés neve és fájlazonosítója, helyesen kerülnek-e nyilvántartásra, és lekérhetők-e a ```gd SaveManager``` listázó függvényével.],

    //table.cell(colspan: 2)[*Mentés betöltése*],
    `test_save_load_file`, [Teszteli, hogy egy meglévő mentésfájl sikeresen betölthető, és a ```gd SaveManager``` a megfelelő státuszkóddal tér vissza.],

    //table.cell(colspan: 2)[*Adatok tárolása és betöltése*],
    `test_store_and_load_data`, [Ellenőrzi, hogy a különböző névterek (namespace) használatával tárolt adatok pontosan visszaállíthatók legyenek, beleértve a számokat és listákat is.],

    //table.cell(colspan: 2)[*Mentések törlése*],
    `test_save_erase`, [Ellenőrzi, hogy a mentések fájljai valóban törlődnek, és a ```gd SaveManager``` nem tartja nyilván a törölt mentéseket.]
  )
) <tbl:tests>

== Egyéb tesztek

Az általam készített ```gd SaveManager``` teszteken kívül a csapat többi tagja is írt
automatizált teszteket, amelyek a játék különböző moduljainak működését
ellenőrzik. Ezek főbb jellemzőit a @tbl:other-tests foglalja össze.

=== Atomikus mentés ellenőrzése (manuális teszt)

Ez a teszt biztosítja, hogy a ```gd SaveManager``` által írt fájlok atomikusan frissülnek:
az adatokat először egy ideiglenes fájlba írja, majd átnevezéssel cseréli le a végleges fájlt.

Linux alatt az alábbi paranccsal ellenőrizhető:

```sh
strace -p $game_pid -e trace=openat,rename,renameat,write
```

Példa a prototípusból, amikor a játék elmenti a `settings.ini` fájlt:

#block(breakable: false)[```strace
openat(AT_FDCWD, "/home/laptopgamer/.local/share/godot/app_userdata/SzakGyak/settings.ini.tmp", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 31
write(31, "[volume]\n\nmaster=0\nsfx=30\nmusic="..., 139) = 139
rename("/home/laptopgamer/.local/share/godot/app_userdata/SzakGyak/settings.ini.tmp", "/home/laptopgamer/.local/share/godot/app_userdata/SzakGyak/settings.ini") = 0
```]

#figure(
  caption: [Összefoglaló a játék moduljait ellenőrző egyéb automatizált tesztekről],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, left),

    `test_family.gd`, [Ellenőrzi a ```gd Family``` objektum létrehozását, a ```gd get_description()``` metódus működését, valamint a getter és setter függvények helyes működését a családtag adatok kezeléséhez.],
    `test_player.gd`, [Ellenőrzi a ```gd Player``` objektum létrehozását, a ```gd get_description()``` metódust, valamint a játékos attribútumok getter és setter függvényeinek helyességét, ideértve az életpontot, éhséget, stresszt, reputációt, pénzt és tárgyakat (kenyér, vodka).],
    `test_game.gd`, [A játék fő logikáját, a ```gd Family``` és ```gd Player``` objektumok integrációját, a UI komponensek betöltését, a jelenetváltás működését, valamint a Boss események és üzenetek megjelenítését ellenőrzi.]
  )
) <tbl:other-tests>

= Összegzés

A fejlesztési folyamat során számos új ismeretre és tapasztalatra tettem szert.
Kiemelt jelentősége volt a csapatmunkának: megtanultam, hogyan lehet hatékonyan
együttműködni másokkal, egységes fejlesztési alapokat lefektetni, valamint közös
döntéseket hozni a projekt irányáról.

Technikai téren sokat fejlődtem a grafikus felhasználói felületek tervezésében
és megvalósításában, valamint a Godot motor scene- és node-alapú
architektúrájának és a GDScript szignálrendszerének mélyebb megértésében.
Emellett új ismereteket szereztem a dinamikus node-kezelés, a nemzetköziesítés
(i18n), illetve a verziókezelési folyamatok kapcsán is.
Utóbbinál különösen hasznosnak bizonyult a git eszköztár mélyebb megismerése,
például a `git stash` és a `git add -p` funkciók alkalmazása.

A projekt egyik legfontosabb tanulsága az volt számomra, hogy a fejlesztési
feladatok időigényét rendszerint könnyű alábecsülni. Ez a felismerés hozzájárult
ahhoz, hogy a jövőben tudatosabban és reálisabban tervezzek a feladatok időbeli
ütemezésével kapcsolatban.

#pagebreak(weak: true)
#bibliography("beszamolo.bib", title: "Hivatkozások")
