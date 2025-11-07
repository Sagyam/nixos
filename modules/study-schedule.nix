{ config, lib, ... }:

with lib;

{
  options.studySchedule = {
    enable = mkEnableOption "study schedule configuration";

    windows = mkOption {
      type = types.listOf (types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            description = "Name of the study window (e.g., 'morning', 'afternoon')";
            example = "morning";
          };
          start = mkOption {
            type = types.str;
            description = "Start time in HH:MM format";
            example = "09:00";
          };
          end = mkOption {
            type = types.str;
            description = "End time in HH:MM format";
            example = "11:00";
          };
          warnAt = mkOption {
            type = types.str;
            description = "Warning time in HH:MM format (for study-lock)";
            example = "08:55";
          };
        };
      });
      default = [
        { name = "morning"; start = "09:00"; end = "11:00"; warnAt = "08:55"; }
        { name = "afternoon"; start = "14:00"; end = "16:00"; warnAt = "13:55"; }
      ];
      description = "List of study time windows";
      example = literalExpression ''
        [
          { name = "morning"; start = "09:00"; end = "11:00"; warnAt = "08:55"; }
          { name = "afternoon"; start = "14:00"; end = "16:00"; warnAt = "13:55"; }
          { name = "evening"; start = "19:00"; end = "21:00"; warnAt = "18:55"; }
        ]
      '';
    };
  };

  config = mkIf config.studySchedule.enable {
    # This module only defines options, no implementation
  };
}
