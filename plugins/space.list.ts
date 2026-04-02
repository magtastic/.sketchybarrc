#!/Users/magtastic/.bun/bin/bun
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = process.env.NAME!;
const SELECTED = process.env.SELECTED === "true";

const number = parseInt(NAME.split(".").pop()!);
const SPACE_ICONS = ["􀀺", "􀀼", "􀀾", "􀁀", "􀁂", "􀁄", "􀁆", "􀁈", "􀁊", "􀓵", "􀓶", "􀓷", "􀓸"];
const SELECTED_ICONS = ["􀀻", "􀀽", "􀀿", "􀁁", "􀁃", "􀁅", "􀁇", "􀁉", "􀁋", "􀔔", "􀔕", "􀔖", "􀔗"];

const icon = SELECTED ? SELECTED_ICONS[number - 1] : SPACE_ICONS[number - 1];

sketchybar("-m", "--set", NAME, `icon=${icon}`, `icon.highlight=${SELECTED}`, `background.drawing=${SELECTED}`);
