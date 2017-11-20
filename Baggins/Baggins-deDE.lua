﻿local L = AceLibrary("AceLocale-2.2"):new("Baggins")


L:RegisterTranslations("deDE", function()
	return {
		--itemtypes, these must match the Type and SubType returns from GetItemInfo for the ItemType rule to work
		["Armor"] = "Rüstung",
			["Cloth"] = "Stoff",
			["Idols"] = "Götze",
			["Leather"] = "Leder",
			["Librams"] = "Buchband",
			["Mail"] = "Schwere Rüstung",
			["Miscellaneous"] = "Verschiedenes",
			["Shields"] = "Schilde",
			["Totems"] = "Totem",
			["Plate"] = "Platte",
		["Consumable"] = "Verbrauchbar",
		["Container"] = "Behälter",
			["Bag"] = "Tasche",
			["Enchanting Bag"] = "Verzauberertasche",
			["Engineering Bag"] = "Ingenieurstasche",
			["Herb Bag"] = "Kräutertasche",
			["Soul Bag"] = "Seelentasche",
		["Key"] = "Schlüssel",
		["Miscellaneous"] = "Verschiedenes",
			["Junk"] = "Plunder",
		["Reagent"] = "Reagenz",
		["Recipe"] = "Rezept",
			["Alchemy"] = "Alchemie",
			["Blacksmithing"] = "Schmiedekunst",
			["Book"] = "Buch",
			["Cooking"] = "Kochkunst",
			["Enchanting"] = "Verzauberungskunst",
			["Engineering"] = "Ingenierskunst",
			["First Aid"] = "Erste Hilfe",
			["Leatherworking"] = "Lederverarbeitung",
			["Tailoring"] = "Schneiderrei",
		["Projectile"] = "Projektil",
			["Arrow"] = "Pfeil",
			["Bullet"] = "Kugel",
		["Quest"] = "Quest",
		["Quiver"] = "Köcher",
			["Ammo Pouch"] = "Munitionsbeutel",
			["Quiver"] = "Köcher",
		["Trade Goods"] = "Handwerkswaren",
			["Devices"] = "Geräte",
			["Explosives"] = "Sprengstoff",
			["Parts"] = "Teile",
			["Gems"] = "Edelsteine",
		["Weapon"] = "Waffe",
			["Bows"] = "Bögen",
			["Crossbows"] = "Armbrüste",
			["Daggers"] = "Dolche",
			["Guns"] = "Schusswaffen",
			["Fishing Pole"] = "Angel",
			["Fist Weapons"] = "Faustkampfwaffen",
			["Miscellaneous"] = "Verschiedenes",
			["One-Handed Axes"] = "Einhandäxte",
			["One-Handed Maces"] = "Einhandstreitkolben",
			["One-Handed Swords"] = "Einhandschwerter",
			["Polearms"] = "Stangenwaffen",
			["Staves"] = "Stäbe",
			["Thrown"] = "Wurfwaffe",
			["Two-Handed Axes"] = "Zweihandäxte",
			["Two-Handed Maces"] = "Zweihandstreitkolben",
			["Two-Handed Swords"] = "Zweihandschwerter",
			["Wands"] = "Zauberstäbe",
		--end of localizations needed for rules to work	
		

		["Baggins"] = "Baggins",
		["Toggle All Bags"] = "Aktiviere alle Taschen.",
		["Columns"] = "Spalten",
		["Number of Columns shown in the bag frames"] = "Anzahl der Spalten in den Taschenfenstern.",
		["Layout"] = "Layout",
		["Layout of the bag frames."] = "Layout des Taschenfensters.",
		["Automatic"] = "Automatisch",
		["Automatically arrange the bag frames as the default ui does"] = "Automatisch die Taschenfenster anordnen wie es die Blizzard Taschen auch tun.",
		["Manual"] = "Manuell",
		["Each bag frame can be positioned manually."] = "Jede Tasche kann manuell positioniert werden.",
		["Show Section Title"] = "Zeige Kategorie Titel",
		["Show a title on each section of the bags"] = "Zeige den Titel von jeder Kategorie auf den Taschen.",
		["Sort"] = "Sortiere",
		["How items are sorted"] = "Wie die Items sortiert werden.",
		["Quality"] = "Qualität",
		["Items are sorted by quality."] = "Items werden nach Qualität sortiert.",
		["Name"] = "Namen",
		["Items are sorted by name."] = "Items werden nach Namen sortiert.",
		["Hide Empty Sections"] = "Verstecke Leere Kategorien",
		["Hide sections that have no items in them."] = "Verstecke Kategorien die keinen Inhalt haben.",
		["Hide Default Bank"] = "Verstecke normale Bank",
		["Hide the default bank window."] = "Verstecke das normale Bankfenster.",
		["FuBar Text"] = "FuBar Text",
		["Options for the text shown on fubar"] = "Optionen für den Text der in Fubar angezeigt wird.",
		["Show empty bag slots"] = "Zeige leere Taschenplätze",
		["Show used bag slots"] = "Zeige benutzte Taschenplätze",
		["Show Total bag slots"] = "Zeige gesammte Taschenplätze",
		["Combine Counts"] = "Kombiniere Anzahl",
		["Show only one count with all the seclected types included"] = "Zeige nur eine Anzahl mit allen ausgewählten Typen darin.",
		["Show Ammo Bags Count"] = "Zeige Munitionstaschenplätze Anzahl",
		["Show Soul Bags Count"] = "Zeige Seelentaschenplätze Anzahl",
		["Show Specialty Bags Count"] = "Zeige Spezielle Taschen Anzahl",
		["Show Specialty (profession etc) Bags Count"] = "Zeige Spezielle (Berufe ect.) Taschen Anzahl.",
		["Set Layout Bounds"]= "Justiere Layoutbestimmungen",
		["Shows a frame you can drag and size to set where the bags will be placed when Layout is automatic"] = "Zeig ein Fenster das du verschieben und in der Größe ändern kannst um zu bestimmen wo die Taschen angezeigt werden wenn das Layout auf 'Automatisch' steht.",
		["Lock"] = "Sperren",
		["Locks the bag frames making them unmovable"] = "Sperrt die Taschenfenster gegen verschieben.",
		["Shrink Width"] = "Verkleinere Breite",
		["Shrink the bag's width to fit the items contained in them"] = "Verkleinere die Breite der Taschen damit die Items in ihnen optimal reinpassen.",
		["Compress"] = "Komprimiere",
		["Compress Multiple stacks into one item button"] = "Komprimiere mehrere Stapel eines Items in ein Item Symbol",
		["Compress All"] = "Komprimiere Alles",
		["Show all items as a single button with a count on it"] = "Zeige alle Gegenstände in einer einzigen Taste mit der Anzahl darin",
		["Compress Empty Slots"] = "Komprimiere leere Felder",
		["Show all empty slots as a single button with a count on it"] = "Zeige alle leeren Felder in einer einzigen Taste mit der Anzahl darin",
		["Compress Soul Shards"] = "Komprimiere Seelensteine",
		["Show all soul shards as a single button with a count on it"] = "Zeige alle Seelensplitter in einer einzigen Taste mit der Anzahl darin",
		["Compress Ammo"] = "Komprimiere Munition",
		["Show all ammo as a single button with a count on it"] = "Zeige alle Munition in einer einzigen Taste mit der Anzahl darin",
		["Quality Colors"]= "Qualitäts Farben",
		["Color item buttons based on the quality of the item"] = "Färbe die Itemtasten nach der Qualität der Items.",
		["Enable"] = "Aktiviere",
		["Enable quality coloring"] = "Aktiviere das einfärben nach Qualität.",
		["Color Threshold"] = "Farben Begrenzung",
		["Only color items of this quality or above"] = "Färbe nur Items ab dieser Qualität und höher.",
		["Color Intensity"] = "Farben Intensität",
		["Intensity of the quality coloring"] = "Intensität des einfärben nach Qualität.",
		["Edit Bags"] = "Editiere Taschen",
		["Edit the Bag Definitions"] = "Editiere die Taschen Definitionen.",
		["Edit Categories"] = "Editiere Kategorieren",
		["Edit the Category Definitions"] = "Editiere die Kategorie Definitionen.",
		["Load Profile"] = "Lade Profil",
		["Load a built-in profile: NOTE: ALL Custom Bags will be lost and any edited built in categories will be lost."] = "Lade ein eingebautes Profil: BEACHTE: ALLE selbst erstellten Taschen gehn verlohren und alle editierten Kategorien in den selbst erstellten Taschen auch.",
		["Default"] = "Grundeinstellung",
		["A default set of bags sorting your inventory into categories"] = "Vorgegebenes Profil an Taschen die nach Kategorien sortiert sind.",
		["All in one"] = "Alle in Einer",
		["A single bag containing your whole inventory, sorted by quality"] = "Eine einzige Tasche die dein gesmmtes Inventar enthält, sortiert nach Qualität.",
		["Scale"] = "Skalierung",
		["Scale of the bag frames"] = "Skalierung des Taschen Fensters.",
		--bagtypes
		["Backpack"] = "Rucksack",
		["Bag1"] = "Tasche 1",
		["Bag2"] = "Tasche 2",
		["Bag3"] = "Tasche 3",
		["Bag4"] = "Tasche 4",
		["Bank Frame"] = "Bank Fenster",
		["Bank Bag1"] = "Banktasche 1",
		["Bank Bag2"] = "Banktasche 2",
		["Bank Bag3"] = "Banktasche 3",
		["Bank Bag4"] = "Banktasche 4",
		["Bank Bag5"] = "Banktasche 5",
		["Bank Bag6"] = "Banktasche 6",
		["Bank Bag7"] = "Banktasche 7",
		["KeyRing"] = "Schlüsselbund",
		
		--qualoty names
		["Poor"] = "Schlecht",
		["Common"] = "Verbreitet",
		["Uncommon"] = "Selten",
		["Rare"] = "Rar",
		["Epic"] = "Episch",
		["Legendary"] = "Legendär",
		["Artifact"] = "Artefakt",
		
		["None"] = "Keins",
		["All"] = "Alle",
		
		["Item Type"] = "Item Typ",
		["Filter by Item type and sub-type as returned by GetItemInfo"] = "Filtere nach Gegenstandstyp und Untertyp wie es GetItemInfo ausgibt.",
		["ItemType - "] = "Gegenstandstyp",
		["Item Type Options"] = "Gegenstandstyp Optionen",
		["Item Subtype"] = "Gegenstands-Untertyp",

		["Container Type"] = "Behälter Typ",
		["Filter by the type of container the item is in."] = "Filtere nach dem Typ des Behälters in dem der Gegenstand ist.",
		["Container : "] = "Behälter : ",
		["Container Type Options"] = "Behälter Typ Optionen.",

		["Item ID"] = "Gegenstand ID",
		["Filter by ItemID, this can be a space delimited list or ids to match."] = "Filtere nach Gegenstands-ID, dies kann eine Leerstellen unlimitierte Liste oder ID's sein.",
		["ItemIDs "] = "Gegenstand-IDs",
		["ItemID Options"] = "Gegenstand-IDs Optionen.",
		["Item IDs (space seperated list)"] = "Gegenstand-IDs (Leerstellen getrennte Liste)",
		["New"] = "Neu",
		["Current IDs, click to remove"] = "Gegenwärtige IDs, klicken um zu entfernen",
		
		["Filter by the bag the item is in"] = "Filtere nach der Tasche in der der Gegenstand ist.",
		["Bag "] = "Tasche ",
		["Bag Options"] = "Taschen Optionen.",
		["Ignore Empty Slots"] = "Ignoriere Leere Felder",
		
		["Item Name"] = "Gegenstandsname",
		["Filter by Name or partial name"] = "Filtere nach Namen oder Teilnamen.",
		["Name: "] = "Name: ",
		["Item Name Options"] = "Gegenstandsnamen Optionen",
		["String to Match"] = "Zeichenkette zum Übereinstimmen",
		
		["PeriodicTable Set"] = "PeriodischerTabellen Satz",
		["Filter by PeriodicTable Set"] = "Filtere nach PeriodischerTabellen Satz",
		["Periodic Table Set Options"] = "PeriodischerTabellen Satz Optionen",
		["Set"] = "Satz",
		
		["Empty Slots"] = "Leere Felder",
		["Empty bag slots"] = "Leere Taschen Felder",
		
		["Ammo Bag"] = "Munitionstasche",
		["Items in an ammo pouch or quiver"] = "Gegenstände in einem Munitionsbeutel oder Köcher",
		["Ammo Bag Slots"] = "Munitionstaschen Felder",
		
		["Quality"] = "Qualität",
		["Filter by Item Quality"] = "Filtere nach Gegenstands-Qualität.",
		["Quality Options"] = "Qualitäts Optionen",
		["Comparison"] = "Vergleichen",
		
		["Equip Location"] = "Ausrüstungsposition",
		["Filter by Equip Location as returned by GetItemInfo"] = "Filtere nach der Ausrüstungsposition wie sie von GetItemInfo ausgegeben wird.",
		
		["Equip Location Options"] = "Ausrüstungsposition Optionen",
		["Location"] = "Position",
		
		["Unfiltered Items"] = "Ungefilterte Gegenstände",
		["Matches all items that arent matched by any other bag, NOTE: this should be the only rule in a category, others will be ignored"] = "Trifft für alle Gegenstände zu bei dehnen nicht der Filter einer anderen Tasche zutrifft. HINWEIS: Dies sollte die einzige Kategorie sein, andere werden ignorierd.",
		["Unfiltered"] = "Ungefiltert",
		
		["Bind"] = "Seelengebunden",
		["Filter based on if the item binds, or if it is already bound"] = "Filter basierend auf Gegestands-Seelen-Verbindungen, oder wenn es bereits gebunden ist.",
		["Bind *unset*"] = "Binden *ungesezt*",
		["Unbound"] = "Ungebunden",
		["Bind Options"] = "Seelengebunden Optionen",
		["Bind Type"] = "Binden Typ",
		["Binds on pickup"] = "Gebunden beim Aufheben",
		["Binds on equip"] = "Gebunden beim Anziehen",
		["Binds on use"] = "Gebunden bei Benutzung",
		["Soulbound"] = "Seelengebunden",

		["Tooltip"] = "Tooltip",
		["Filter based on text contained in its tooltip"] = "Filtere basierend auf dem Text der in dem Tooltip ist.",
		["Tooltip Options"] = "Tooltip Optionen",
		
		["ItemID: "] = "Gegenstands-ID: ",
		["Item Type: "] = "Gegenstandstyp: ",
		["Item Subtype: "] = "Gegenstands-Untertyp: ",
		
		["Click a bag to toggle it. Shift-click to move it up. Alt-click to move it down"] = "Klick auf einen Tasche um sie zu öffnen. Shift-Klick um hoch zu bewegen. Alt-Klick um runter zubewegen.",
		
		["Bags"] = "Taschen",
		["Options"] = "Optionen",
		["Open With All"] = "Öffnen mit Allem",
		["Bank"] = "Bank",
		["Sections"] = "Sektionen",
		["Categories"] = "Kategorie",
		["Add Category"] = "Kategorie hinzufügen",
		["New Section"] = "Neue Sektion",
		["New Bag"] = "Neue Tasche",
		["Close"] = "Schliessen",
		["Click on an entry to open. Shift-Click to move up. Alt-Click to move down. Ctrl-Click to delete."] = "Klick auf Eintrag zum öffnen. Shift-Klick um hoch zu bewegen. Alt-Klick um runter zubewegen. Strg-Klick um zu löschen.",
		["Rules"] = "Regeln",
		["New Rule"] = "Neue Regel",
		["Add Rule"] = "Regel hinzufügen",
		["New Category"] = "Neue Kategorie",
		["Apply"] = "Anwenden",
		["Click on an entry to open. Ctrl-Click to delete."] = "Klick auf einen Eintrag zum öffnen. Strg-klick zum löschen.",
		
		["Editing Rule"] = "Editiere Regel",
		["Type"] = "Typ",
		["Select a rule type to create the rule"] = "Wähle einen Regltyp um die Regel zu erstellen.",
		["Operation"] = "Vorgang",
		["AND"] = "UND",
		["OR"] = "ODER",
		["NOT"] = "NICHT",
		
		["Baggins - New Bag"] = "Baggins - Neue Tasche",
		["Baggins - New Section"] = "Baggins - Neue Sektion",
		["Baggins - New Category"] = "Baggins - Neue Kategorie",
		["Accept"] = "Akzeptieren",
		["Cancel"] = "Abbrechen",
		
		["Are you sure you want to delete this Bag? this cannot be undone"] = "Bist du sicher das du diese Tasche löschen willst? Dies kann nicht rückgängig gemacht werden.",
		["Are you sure you want to delete this Section? this cannot be undone"] = "Bist du sicher das du diese Sektion löschen willst? Dies kann nicht rückgängig gemacht werden.",
		["Are you sure you want to remove this Category? this cannot be undone"] = "Bist du sicher das du diese Kategorie löschen willst? Dies kann nicht rückgängig gemacht werden.",
		["Are you sure you want to remove this Rule? this cannot be undone"] = "Bist du sicher das du diese Regel löschen willst? Dies kann nicht rückgängig gemacht werden.",
		["Delete"] = "Löschen",
		["Cancel"] = "Abbrechen",
		
		["That category is in use by one or more bags, you cannot delete it."] = "Diese Kategorie wird von einer oder mehreren Taschen verwendet, du kannst sie nicht löschen.",
		["A category with that name already exists."] = "Ein Kategorie mit diesem Namen existiert bereits.",
		
		["Drag to Move\nRight-Click to Close"] = "Ziehen zum bewegen\nRechts-Klick zum schliessen",
		["Drag to Size"] = "Ziehen um Größe einzustellen",
		
		["Previous "] = "Vorherige",
		["Next "] = "Nächste",

		["All In One"] = "Alles in Einer",
		["Bank All In One"] = "Bank Alles in Einer",
		["Bank Bags"] = "Bank Taschen",
		
		["Equipment"] = "Ausrüstung",
		["Weapons"] = "Waffen",
		["Quest Items"] = "Quest Gegenstände",
		["Consumables"] = "Verbrauchbares",
		["Water"] = "Wasser",
		["Food"] = "Essen",
		["FirstAid"] = "Erste Hilfe",
		["Potions"] = "Tränke",
		["Scrolls"] = "Schriftrollen",
		["Misc"] = "Verschiedenes",
		["Misc Consumables"] = "Verschiedenes zum verbrauchen",

		["Mats"] = "Materialien",
		["Tradeskill Mats"] = "Handwerks Materialien",
		["Gathered"] = "Gesammelt",
		["BankBags"] = "BankTaschen",
		["Ammo"] = "Munition",
		["AmmoBag"] = "MunitionsTasche",
		["SoulShards"] = "SeelenSplitter",
		["SoulBag"] = "SeelenTasche",
		["Other"] = "Anderes",
		["Trash"] = "Plunder",
		["TrashEquip"] = "PlunderAusrüstung",
		["Empty"] = "Leer",
		["Bank Equipment"] = "Bank Ausrüstung",
		["Bank Quest"] = "Bank Quest",
		["Bank Consumables"] = "Bank Verbrauchbares",
		["Bank Trade Goods"] = "Bank Handwerkswaren",
		["Bank Other"] = "Bank Anderes",
		
		["Add To Category"] = "Hinzufügen zur Kategorie",
		["Exclude From Category"] = "Entfernen von der Kategorie",
		["Item Info"] = "Gegenstands-Info",
		["Quality: "] = "Qualität: ",
		["Level: "] = "Level: ",
		["MinLevel: "] = "MinLevel: ",
		["Stack Size: "] = "Stapel Größe: ",
		["Equip Location: "] = "Trage Position: ",
		["Periodic Table Sets"] = "Periodische Tabelle Sätze",

		["Highlight New Items"] = "Neue Items hervorheben",
		["Add *New* to new items, *+++* to items that you have gained more of."] = "Füge *NEU* zu neuen Gegenständen, *+++* zu Gegenständen von dehnen du noch mehr hast.",
		["Reset New Items"] = "Neue Items resetten",
		["Resets the new items highlights."] = "Resettet die gegenwärtig als neu hervorgehoben Gegenstände.",
		["*New*"] = "*Neu*",

		["Hide Duplicate Items"] = "Verstecke doppelte Gegenstände",
		["Prevents items from appearing in more than one section/bag."] = "Verhindert das Gegenstände mehr als einmal in einer Sektion/Tasche angezeigt werden.",

		["Optimize Section Layout"] = "Optimiere Sektionsanordnung",
		["Change order and layout of sections in order to save display space."] = "Ändere Reihenfolge und die Anordnung der Sektionen um optisch alles platzsparender anzuzeigen.",
		
		["All In One Sorted"]= "Alles in Einer-Sortiert",
		["A single bag containing your whole inventory, sorted into categories"]= "Eine einzige Tasche welche dein gesammtes Inventar enthält, sortiert nach Kategorien.",

		["Compress Stackable Items"]= "Komprimiere stapelbare Gegenstände",
		["Show stackable items as a single button with a count on it"]= "Zeige stapelbare Gegenstände als eine einzige Taste mit einem Zähler darin.",

		["Appearance and layout"]= "Aussehn und Layout",
		["Bags"]= "Taschen",
		["Bag display and layout settings"]= "Taschen Aussehn und Layout Einstellungen.",
		["Layout Type"]= "Layout Typ",
		["Sets how all bags are laid out on screen."]= "Stellt ein wie alle Taschen auf dem Bildschrim angeordnet werden.",
		["Shrink bag title"]= "Verkleinere Taschen Titel",
		["Mangle bag title to fit to content width"]= "Passt den Titeltext der Breite der Tasche an wenn nötig.",
		["Sections"]= "Sektionen",
		["Bag sections display and layout settings."]= "Taschen Sektions Anzeige und Layout Einstellungen.",
		["Items"]= "Gegenstände",
		["Item display settings"]= "Gegennstandsanzeige Einstellungen.",
		["Bag Skin"]= "Taschen Ausssehn",
		["Select bag skin"]= "Wähle das Taschen Aussehn.",

	}
end)