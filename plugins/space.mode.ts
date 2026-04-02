#!/Users/magtastic/.bun/bin/bun
import { $ } from "bun";
import { sketchybar } from "./lib/sketchybar.ts";

const NAME = process.env.NAME!;
const SENDER = process.env.SENDER!;
const INFO = process.env.INFO ?? "";

const DEFAULT = "􀛧";

const APP_ICONS: Record<string, string> = {
  "iTerm2": "􀩼",
  "Terminal": "􀩼",
  "Warp": "􀩼",
  "Xcode": "􀤯",
  "Visual Studio Code": "􀤙",
  "Code": "􀤙",
  "Cursor": "􀤙",
  "SF Symbols": "􁂮",
  "Firefox": "􀎬",
  "Firefox Developer Edition": "􀎬",
  "Arc": "􀎬",
  "Safari": "􀎬",
  "Google Chrome": "􀎬",
  "Brave Browser": "􀎬",
  "Microsoft Edge": "􀎬",
  "Zen Browser": "􀎬",
  "Simulator": "􀟜",
  "App Store": "􀈄",
  "Notion": "􀺴",
  "Obsidian": "􀺴",
  "Notes": "􀓕",
  "1Password": "􀙵",
  "Messages": "􀌤",
  "Messenger": "􀌤",
  "Telegram": "􀌤",
  "WhatsApp": "􀌤",
  "Signal": "􀌤",
  "Mail": "􀍕",
  "Polymail": "􀍕",
  "Spark": "􀍕",
  "Mimestream": "􀍕",
  "Calendar": "􀉉",
  "Cron": "􀉉",
  "Fantastical": "􀉉",
  "Notion Calendar": "􀉉",
  "zoom.us": "􀍉",
  "FaceTime": "􀍉",
  "Asana": "􀷾",
  "Linear": "􀷾",
  "Slack": "􀃪",
  "Discord": "􀃪",
  "Microsoft Teams": "􀃪",
  "System Settings": "􀣋",
  "System Preferences": "􀣋",
  "Postman": "􀪹",
  "Insomnia": "􀪹",
  "RapidAPI": "􀪹",
  "Finder": "􀈕",
  "Spotify": "􀑪",
  "Apple Music": "􀑪",
  "Music": "􀑪",
  "Preview": "􀏅",
  "Photos": "􀏅",
  "Figma": "􀎸",
  "Docker": "􀐛",
  "Docker Desktop": "􀐛",
  "OrbStack": "􀐛",
  "TablePlus": "􀤃",
  "Postico": "􀤃",
  "pgAdmin 4": "􀤃",
  "DataGrip": "􀤃",
  "Activity Monitor": "􀍟",
  "Claude": "􁜟",
  "ChatGPT": "􀫥",
  "Raycast": "􀊫",
  "Alfred": "􀊫",
  "Bear": "􀣠",
  "Things": "􀆅",
  "Reminders": "􀆅",
  "Todoist": "􀆅",
  "TickTick": "􀆅",
  "Keychain Access": "􀟖",
  "Install Command Line Developer Tools": "􀤙",
  "Maps": "􀙊",
  "Podcasts": "􀺺",
};

if (SENDER === "front_app_switched" || SENDER === "space_mode_changed") {
  const query = await $`yabai -m query --windows --window`.quiet().nothrow().text();
  let app = "";
  try {
    app = JSON.parse(query).app;
  } catch {}

  const icon = APP_ICONS[app] ?? DEFAULT;
  sketchybar("--set", NAME, `icon=${icon}`);
} else if (SENDER === "display_change") {
  sketchybar("--set", NAME, `associated_display=${INFO}`);
}
