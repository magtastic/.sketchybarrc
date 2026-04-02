#!/Users/magtastic/.bun/bin/bun
import { $ } from "bun";
import { APP_ICONS, DEFAULT_ICON } from "./lib/app-icons.ts";
import { env } from "./lib/env.ts";
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = env("NAME");
const SELECTED = process.env["SELECTED"] === "true";

const parts = NAME.split(".");
const spaceIndex = parseInt(parts[parts.length - 1] ?? "0", 10);

const SPACE_ICONS = ["􀀺", "􀀼", "􀀾", "􀁀", "􀁂", "􀁄", "􀁆", "􀁈", "􀁊", "􀓵", "􀓶", "􀓷", "􀓸"];
const SELECTED_ICONS = ["􀀻", "􀀽", "􀀿", "􀁁", "􀁃", "􀁅", "􀁇", "􀁉", "􀁋", "􀔔", "􀔕", "􀔖", "􀔗"];

// Query yabai for all windows on this space
const query = await $`yabai -m query --windows --space ${spaceIndex}`.quiet().nothrow().text();

let appIcons = "";
try {
  const windows = JSON.parse(query) as { app: string }[];
  // Deduplicate apps and map to icons
  const seen = new Set<string>();
  const icons: string[] = [];
  for (const win of windows) {
    const icon = APP_ICONS[win.app] ?? DEFAULT_ICON;
    if (!seen.has(icon)) {
      seen.add(icon);
      icons.push(icon);
    }
  }
  appIcons = icons.join(" ");
} catch {}

// If no apps on this space, show a dash
if (appIcons.length === 0) {
  appIcons = "—";
}

sketchybar(
  "-m",
  "--set",
  NAME,
  `icon=${SELECTED ? SELECTED_ICONS[spaceIndex - 1] : SPACE_ICONS[spaceIndex - 1]}`,
  `icon.highlight=${SELECTED}`,
  `label=${appIcons}`,
  `label.highlight=${SELECTED}`,
  `background.drawing=${SELECTED}`,
);
