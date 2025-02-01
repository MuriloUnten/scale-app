final userTable = (
        table:       "user",
        id:          "id_user",
        firstName:   "first_name",
        lastName:    "lastName",
        height:      "height",
        sex:         "sex",
        dateOfBirth: "date_of_birth",
);

final biaTable = (
        table:      "bia",
        id:         "id_bia",
        userId:     "id_user",
        timestamp:  "timestamp",
        weight:     "weight",
        muscleMass: "muscle_mass",
        fatMass:    "fat_mass",
        waterMass:  "water_mass",
);

final currentUserTable = (
        table: "current_user",
        userId: "id_user",
);
