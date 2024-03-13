 // Heartbeat script of area.
    #include "inc_commoner"

    void main()
    {
        struct CommonerSettings settings;
        settings.NumberOfCommonersDuringDay = 5;
        settings.NumberOfCommonersDuringNight = 1;
        settings.NumberOfCommonersDuringRain = 1;
        settings.CommonerResRefPrefix = "commoner";
        settings.NumberOfCommonerTemplates = 4;
        settings.RandomizeClothing = TRUE;
        settings.ClothingResRefPrefix = "cloth02";
        settings.NumberOfClothingTemplates = 3;
        settings.CommonerTag = "Commoner";
        settings.CommonerName = "Plebeyo";
        settings.WaypointTag = "WP_COMMONER";
        settings.MinSpawnDelay = 2.0f;
        settings.MaxSpawnDelay = 30.0f;
        settings.StationaryCommoners = FALSE;
        settings.MaxWalkTime = 30.0f;

        SpawnAndUpdateCommoners(settings);
    }
