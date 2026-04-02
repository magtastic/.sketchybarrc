#!/Users/magtastic/.bun/bin/bun
import { $ } from "bun";
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = process.env.NAME!;
const source = (await $`/usr/local/bin/xkbswitch -ge`.nothrow().quiet().text()).trim();

const label = source === "Icelandic" ? "ÍS" : "EN";

sketchybar("--set", NAME, `label=${label}`);
