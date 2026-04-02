#!/Users/magtastic/.bun/bin/bun
import { env } from "./lib/env.ts";
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = env("NAME");
const SELECTED = process.env["SELECTED"] === "true";

const parts = NAME.split(".");
const number = parseInt(parts[parts.length - 1] ?? "0", 10);
const SPACE_ICONS = ["􀀺", "􀀼", "􀀾", "􀁀", "􀁂", "􀁄", "􀁆", "􀁈", "􀁊", "􀓵", "􀓶", "􀓷", "􀓸"];
const SELECTED_ICONS = ["􀀻", "􀀽", "􀀿", "􀁁", "􀁃", "􀁅", "􀁇", "􀁉", "􀁋", "􀔔", "􀔕", "􀔖", "􀔗"];

const icon = SELECTED ? SELECTED_ICONS[number - 1] : SPACE_ICONS[number - 1];

sketchybar(
  "-m",
  "--set",
  NAME,
  `icon=${icon}`,
  `icon.highlight=${SELECTED}`,
  `background.drawing=${SELECTED}`,
);
