#!/Users/magtastic/.bun/bin/bun
import { $ } from "bun";
import { env } from "./lib/env.ts";
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = env("NAME");
const source = (await $`/usr/local/bin/xkbswitch -ge`.nothrow().quiet().text()).trim();

const label = source === "Icelandic" ? "ÍS" : "EN";

sketchybar("--set", NAME, `label=${label}`);
