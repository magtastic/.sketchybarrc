#!/Users/magtastic/.bun/bin/bun
import { env } from "./lib/env.ts";
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = env("NAME");
const now = new Date();
const hours = String(now.getHours()).padStart(2, "0");
const minutes = String(now.getMinutes()).padStart(2, "0");
const day = now.toLocaleDateString("en-US", { weekday: "short" });
const date = now.getDate();
const month = now.toLocaleDateString("en-US", { month: "short" });

sketchybar("--set", NAME, `label=${day} ${date} ${month} ${hours}:${minutes}`);
