#!/Users/magtastic/.bun/bin/bun
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = process.env.NAME!;
const now = new Date();
const label = `${String(now.getHours()).padStart(2, "0")}:${String(now.getMinutes()).padStart(2, "0")}`;

sketchybar("--set", NAME, `label=${label}`);
