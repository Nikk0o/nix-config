{
	config,
	pkgs,
	lib,
	...
}:

let
	hyprland-pkg = pkgs.hyprland;
	cfg = config.options.windowManager.hyprland;
in
{
	options.windowManager.hyprland = {
		enable = lib.mkEnableOption "Enable Hyprland";
	};

	config = with lib; mkIf cfg.enable (rec {
		useCustomConfig = mkEnableOption "Whether to use a custom configuration file";

		settings = mkIf (!useCustomConfig){
			border_size = mkOption {
				type = types.int;
				default = 1;
			};

			no_border_on_floating = mkOption {
				type = with types; either int str;
				default = types.either.left 5;
			};

			gaps_in = mkOption {
				type = with types; either int str;
				default = types.either.left 20;
			};

			float_gaps = mkOption {
				type = with types; either int str;
				default = types.either.left 0;
			};

			gaps_workspaces = mkOption {
				type = types.int;
				default = 0;
			};

			col = {
				active_border = mkOption {
					type = with types; listOf str;
					default = [ "0xffffffff" ];
				};

				inactive_border = mkOption {
					type = with types; listOf str;
					default = [ "0xff444444" ];
				};

				nogroup_border = mkOption {
					type = with types; listOf str;
					default = [ "0xffffaaff" ];
				};

				nogroup_border_active = mkOption {
					type = with types; listOf str;
					default = [ "0xffff00ff" ];
				};
			};

			layout = mkOption {
				type = types.str;
				default = "dwindle";
			};

			no_focus_fallback = mkOption {
				type = types.bool;
				default = false;
			};

			resize_on_border = mkOption {
				type = types.bool;
				default = false;
			};

			extend_border_grab_area = mkOption {
				type = types.int;
				default = 15;
			};

			hover_icon_on_border = mkOption {
				type = types.bool;
				default = true;
			};

			allow_tearing = mkOption {
				type = types.bool;
				default = false;
			};

			resize_corner = mkOption {
				type = types.int;
				default = 0;
			};
		};

		extraConfig = lib.mkOption {
			type = lib.types.str;
			default = "";
		};
	});
}
