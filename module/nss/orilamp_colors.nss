void main()
{
if (GetObjectByTag("ZEP_OLANTERN001") == OBJECT_SELF)
    {
if (GetLocalInt(OBJECT_SELF,"iLiOn") != 1)
    {
    effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_RED_5);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, OBJECT_SELF);
    SetLocalInt(OBJECT_SELF,"iLiOn",1);
    }
}
else if (GetObjectByTag("ZEP_OLANTERN003") == OBJECT_SELF)
    {
if (GetLocalInt(OBJECT_SELF,"iLiOn") != 1)
    {
    effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_BLUE_5);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, OBJECT_SELF);
    SetLocalInt(OBJECT_SELF,"iLiOn",1);
    }
}
else if (GetObjectByTag("ZEP_OLANTERN007") == OBJECT_SELF)
    {
if (GetLocalInt(OBJECT_SELF,"iLiOn") != 1)
    {
    effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_5);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, OBJECT_SELF);
    SetLocalInt(OBJECT_SELF,"iLiOn",1);
    }
}
else if (GetObjectByTag("ZEP_OLANTERN005") == OBJECT_SELF)
    {
if (GetLocalInt(OBJECT_SELF,"iLiOn") != 1)
    {
    effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_BLUE_5);
    effect eLight2 = EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_5);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight2, OBJECT_SELF);
    SetLocalInt(OBJECT_SELF,"iLiOn",1);
    }
}
else return;
}
