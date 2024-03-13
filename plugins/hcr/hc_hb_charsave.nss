// sr5.3
// changed to 5 minutes.
// thanks to Zivilyn for this code.
// exports and sets char variables every 5 minutes..can be changed
// to any number of minutes.
// place anywhere in module to use.


void save_characters (int minutes)
{
    int current = GetLocalInt(GetModule(), "cyclestill");
    if (current < ((minutes * 60) / 6))
        SetLocalInt(GetModule(), "cyclestill", current + 1);
    else
    {
        ExportAllCharacters();
        SetLocalInt(GetModule(), "cyclestill", 0);

    }
    return;
}

void main () {
save_characters(5);
}

