/*  ================================================================
    Title:        DOA Gold Encumbrance System
    Author:       Den, Project Lead at Carpe Terra (http://carpeterra.com)
    Version:      1.0
    Features:     + custom Gold Coin Pouch items are automatically added and
                    removed from a player's inventory as the quantity of gold
                    they are carrying changes (each Pouch weighs 5.5 pounds
                    and takes 2 inventory spaces)
                  + each Gold Coin Pouch represents 500 gold and cannot be dropped
                    or transferred
                  + 100% compatible with default gold pieces, containers,
                    merchants/stores, inventory panel information (gold/weight),
                    and encumbrance (movement) penalties
                  + player gold encumbrance state managed by a player
                    pseudo-heartbeat and just one local integer set on each
                    player (PW-friendly with no modifications)
                  + shares common gold container objects with DOA Bashed Loot
                    Breakage 1.1+ which automatically update encumbrance
                  + includes replacement for GiveGoldToCreature function, as
                    well as an enhanced party gold function, which
                    automatically update encumbrance

    ================================================================
    Usage:        Place the following scripts in your module events:
                  onModuleLoad      => gbl_mod_load
                  onClientEnter     => gbl_mod_enter
                  onAcquireItem     => gbl_mod_itemgain
                  onUnacquireItem   => gbl_mod_itemlost

                  There are no other configuration options at this time.

    Packaged:     [required scripts] doa_goldencum, gbl_mod_load, gbl_mod_enter, gbl_mod_itemgain, gbl_mod_itemlost, gbl_pc_heartbeat, doa_gold_death, doa_gold_used, inc_givewtgold
                  [required objects] gold_lg
                  [required items] gold_pouch

    History:      0.90 initial beta release
                  0.91 no gold exploit confirmed and fixed
                  1.0  gold pouches made plot/nodrop to simplify code

    Thanks to:    Cevrin for the pseudo-heartbeat idea, Tigsen for identifying
                  the no gold exploit
    ================================================================ */
//void main() {}
