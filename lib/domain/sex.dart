enum Sex {
    M,
    F,
    undefined,
}

extension SexUtil on Sex {
    String get string {
        switch (this) {
            case Sex.M:
                return "M";
            case Sex.F:
                return "F";
            case Sex.undefined:
                return "undefined";
        }
    }
    String get formattedString {
        switch (this) {
            case Sex.M:
                return "Male";
            case Sex.F:
                return "Female";
            case Sex.undefined:
                return "undefined";
        }

    }
    static Sex fromString(string) {
        switch (string) {
            case "M":
                return Sex.M;
            case "Male":
                return Sex.M;
            case "F":
                return Sex.F;
            case "Female":
                return Sex.F;
            default:
                return Sex.undefined;
        }
    }
}
