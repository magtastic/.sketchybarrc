#!/Users/magtastic/.bun/bin/bun
import { env } from "./lib/env.ts";
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = env("NAME");
const now = new Date();
const hours = String(now.getHours()).padStart(2, "0");
const minutes = String(now.getMinutes()).padStart(2, "0");

sketchybar("--set", NAME, `label=${hours}:${minutes}`);
