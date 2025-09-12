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

// custom note() function for notes
#let note(x) = rect(width: 100%)[
  #align(center)[*Megjegyzés*]

  #x
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

A részfeladatokat úgy általában mindenkinek a saját szemszögéből kellene
bemutatnia, kihangsúlyozva a saját részt.

== Előkészületek

Ezt csak úgy példának írtam, hogy lehet szépen strukturálni a
dokumentumot.

=== Telepítés

A Godot telepítését a `dnf install godot` parancs segítségével végeztem
el.

= Implementáció

== Mentési Rendszer

A játékon belüli mentések kezelésére saját mentési rendszert dolgozotunk ki,
amelynek megvalósítását én vállaltam. A megoldás alapja két függvény:

```gd
func save_state(
    ns: StringName,
    state: Dictionary[StringName, Variant]
) -> Error

func load_state(ns: StringName) -> Dictionary
```

Az `ns` paraméter egyfajta névtérként (namespace) működik, így a játék különböző
részei elkülönítve tárolhatják az állapotukat. A ```gd load_state()```
visszaadja az adott névtérhez korábban elmentett adatokat, vagy üres szótárat,
ha még nincs tárolt állapot.

A mentések atomikusan történnek: először ideiglenes fájlba írjuk az adatokat,
majd átnevezés után válnak érvényessé. Így biztosítható, hogy vagy a teljes új
mentés, vagy a korábbi állapot maradjon meg, elkerülve a fájlok részleges
korruptálódását.

#note[A ```gd load_state()``` korábban ```gd Dictionary[StringName, Variant]``` típust
adott vissza, de a betöltés során felmerülő típusproblémák miatt végül sima
```gd Dictionary```-ként valósítottuk meg. Ez lehetővé tette a hibamentes
betöltést, miközben a különböző névterek elkülönítése továbbra is biztosított
maradt.]

== Menürendszer

A projekt menürendszerét teljes egészében én valósítottam meg a Godot-ban.
A rendszer a játék különböző felületeit kezeli, beleértve a főmenüt,
a beállításokat, a mentések kezelését és a figyelmeztető üzeneteket.

A struktúra a következőképpen épült fel:

#no-codly[```
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
```]

A menük logikáját GDScript-ben implementáltam, a különböző jelenetek
érintkezését és a felhasználói interakciók kezelését biztosítva. A menürendszer
tartalmazza a mentések kiválasztását és létrehozását, a beállítások módosítását,
valamint a különböző HUD elemeket, melyek dinamikusan frissülnek a játék
állapota szerint.

=== Menürendszer részletesen

A projekt menürendszerét teljes egészében én valósítottam meg a Godot-ban.
A rendszer a játék különböző felületeit kezeli, beleértve a főmenüt, a beállításokat,
a mentések kezelését és a figyelmeztető üzeneteket. Az egyes elemek a következő feladatokat látják el:

- `hud_entry_family.{gd,tscn}`: Egy családhoz tartozó HUD elemek megjelenítése, az aktuális tag állapotának vizualizálása.
- `hud_entry_player.{gd,tscn}`: A játékos karakterének állapotát mutatja a HUD-on, beleértve életpontokat és egyéb státuszokat.
- `hud.{gd,tscn}`: A teljes HUD menedzsmentjét végzi, összehangolja az összes HUD-elem frissítését.
- `main_menu.{gd,tscn}`: A főmenüt valósítja meg, innen lehet új játékot indítani, betöltést kezdeményezni, vagy a beállításokat elérni.
- `new_save_menu.{gd,tscn}`: Új mentés létrehozására szolgáló felület, ahol a játékos kiválaszthatja a mentés nevét és helyét.
- `save_delete_confirm.{gd,tscn}`: Mentés törlésének megerősítő párbeszédpanelje, biztonsági ellenőrzéssel.
- `save_entry.{gd,tscn}`: Egyetlen mentés bejegyzésének reprezentációja a mentésválasztó menüben.
- `save_select_menu.{gd,tscn}`: A mentések listázását és kiválasztását biztosító felület.
- `settings_menu.{gd,tscn}`: A játék beállításait kezelő menü, beleértve hang, grafika és egyéb konfigurációk módosítását.
- `warn_menu.{gd,tscn}`: Tartalmi figyelmeztetések megjelenítésére szolgáló felület, amely a játék elején jelenik meg a szocialista témájú tartalom miatt.


= Tesztelés

A projekt során a csapat kiemelt figyelmet fordított a tesztelésre, hogy a
fejlesztett rendszerek megbízhatóan működjenek, és a hibák korán
felderítésre kerüljenek. A tesztek több szinten valósultak meg, beleértve
a funkcionális ellenőrzéseket, az integrációs teszteket és az állapotmentési
rendszer ellenőrzését.

== Állapotmentési rendszert ellenőrző tesztek

Az általam készített tesztek a ```gd SaveManager``` működését vizsgálták. A tesztek célja
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
    `test_save_create`, [Ellenőrzi, hogy a SaveManager képes-e új mentésfájlokat létrehozni, és hogy a fájlok valóban megjelennek a mentési könyvtárban.],

    //table.cell(colspan: 2)[*Mentés metaadatok létezése*],
    `test_save_meta_exists`, [Ellenőrzi, hogy a mentésekhez tartozó metaadatok, például a mentés neve és fájlazonosítója, helyesen kerülnek-e nyilvántartásra, és lekérhetők-e a SaveManager listázó függvényével.],

    //table.cell(colspan: 2)[*Mentés betöltése*],
    `test_save_load_file`, [Teszteli, hogy egy meglévő mentésfájl sikeresen betölthető, és a SaveManager a megfelelő státuszkóddal tér vissza.],

    //table.cell(colspan: 2)[*Adatok tárolása és betöltése*],
    `test_store_and_load_data`, [Ellenőrzi, hogy a különböző névterek (namespace) használatával tárolt adatok pontosan visszaállíthatók legyenek, beleértve a számokat és listákat is.],

    //table.cell(colspan: 2)[*Mentések törlése*],
    `test_save_erase`, [Ellenőrzi, hogy a mentések fájljai valóban törlődnek, és a ```gd SaveManager``` nem tartja nyilván a törölt mentéseket.]
  )
) <tbl:tests>

== Egyéb tesztek

Az általam készített SaveManager teszteken kívül a csapat többi tagja is írt
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

Ide érdemes leírni a munkálatokkal kapcsolatos tapasztalatokat.

#pagebreak(weak: true)
#bibliography("beszamolo.bib", title: "Hivatkozások")
