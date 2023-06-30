#!/usr/bin/env python3

import datetime as dt
import hashlib
import json
import os
import re
import subprocess


class TimeRange:
    def __init__(self, start_timestamp: dt.datetime, end_time: dt.datetime):
        self.start_timestamp = start_timestamp
        self.end_time = end_time

    def human_str(self) -> str:
        return f"{self.start_timestamp.strftime('%H:%M')} - {self.end_time.strftime('%H:%M')}"

    def is_happening(self) -> bool:
        return self.start_timestamp <= dt.datetime.now() <= self.end_time

    def is_today(self) -> bool:
        return self.start_timestamp <= dt.datetime.now() <= self.end_time


class Event:
    def __init__(
        self,
        uid: str,
        title: str,
        time_range: TimeRange,
        url: str | None,
        calendar: str,
    ):
        self.uid = uid
        self.sketchybar_item_name = f"upcoming.{self.uid}"
        self.title = title
        self.time_range = time_range
        self.url = url
        self.calendar = calendar
        self.color = f"upcoming.{self.uid}"

    def get_main_title(self) -> str:
        if self.time_range.is_happening():
            return f"{self.title}[NOW]"
        return f"{self.title} [{self.time_range.human_str()}]"

    def is_known_calendar(self) -> bool:
        if self.calendar in ["A - Magnús", "Personal"]:
            return True
        return False

    def get_color(self) -> str:
        if self.calendar == "Personal":
            return "0xffde3d30"
        elif self.calendar == "A - Magnús":
            return "0xff9364f1"
        return "0xff262626"

    def get_dropdown_args(self, drawn_events: list[str]):
        if self.sketchybar_item_name in drawn_events:
            return [
                f'--set {self.sketchybar_item_name} label="{self.title}"',
                f'--set {self.sketchybar_item_name} click_script="open {self.url} ; sketchybar -m --set upcoming popup.drawing=off"',
            ]

        return [
            f"--add item {self.sketchybar_item_name} popup.upcoming",
            f"--set {self.sketchybar_item_name} icon=􀑌",
            f"--set {self.sketchybar_item_name} icon.padding_left=0",
            f"--set {self.sketchybar_item_name} icon.padding_right=4",
            f"--set {self.sketchybar_item_name} icon.color={self.get_color()}",
            f"--set {self.sketchybar_item_name} label.color=0xff7d7865",
            f"--set {self.sketchybar_item_name} background.padding_left=6",
            f"--set {self.sketchybar_item_name} background.padding_right=6",
            f'--set {self.sketchybar_item_name} label="{self.title}"',
            f'--set {self.sketchybar_item_name} click_script="open {self.url} ; sketchybar -m --set upcoming popup.drawing=off"',
        ]

    def set_to_sketchybar(
        self, dropdown_events: list["Event"], drawn_events: list[str]
    ):
        args = [
            f'--set upcoming label="{self.get_main_title()}"',
            "--set upcoming drawing=on",
            f"--set upcoming icon=􀑌",
            f"--set upcoming icon.color={self.get_color()}",
        ]

        for event in dropdown_events:
            args += event.get_dropdown_args(drawn_events)

        os.system("sketchybar -m " + " ".join(args))

    def __repr__(self):
        return f"Event(uid: {self.uid}, title: {self.title}, url: {self.url}, calendar: {self.calendar})"


def get_all_events() -> list[Event]:
    datetime_format = "%d %b %Y %H:%M"
    url_pattern = r"\b((?:https?://)?(?:(?:www\.)?(?:[\da-z\.-]+)\.(?:[a-z]{2,6})|(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(?:(?:[0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,7}:|(?:[0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|(?:[0-9a-fA-F]{1,4}:){1,5}(?::[0-9a-fA-F]{1,4}){1,2}|(?:[0-9a-fA-F]{1,4}:){1,4}(?::[0-9a-fA-F]{1,4}){1,3}|(?:[0-9a-fA-F]{1,4}:){1,3}(?::[0-9a-fA-F]{1,4}){1,4}|(?:[0-9a-fA-F]{1,4}:){1,2}(?::[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:(?:(?::[0-9a-fA-F]{1,4}){1,6})|:(?:(?::[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(?::[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(?:ffff(?::0{1,4}){0,1}:){0,1}(?:(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])|(?:[0-9a-fA-F]{1,4}:){1,4}:(?:(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(?:25[0-5]|(?:2[0-4]|1{0,1}[0-9]){0,1}[0-9])))(?::[0-9]{1,4}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])?(?:/[\w\.-]*)*/?)\b"

    cmd = "icalBuddy -n -nrd -npn -ea -ps '/🛂/' -nnr ' ' -b '' -ab '' -iep 'title,notes,datetime' -uid eventsToday+1"
    output = subprocess.Popen(
        cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE
    ).communicate()[0]
    lines = output.decode("utf-8").strip().split("\n")

    events = []
    if lines == [""]:
        return events

    for line in lines:
        splat = line.split("🛂")

        match = re.search("^(.*?) \((.*?)\)$", splat[0])

        title = match.group(1)
        calendar = match.group(2)

        urlsfound = re.findall(url_pattern, splat[1])

        meetingurls = ["teams.microsoft.com", "us02web.zoom.us", "meet.google.com"]
        urls = []
        for url in urlsfound:
            for meetingurl in meetingurls:
                if meetingurl in url:
                    urls.append(url)

        url = (urls + [None])[0]

        uid = splat[-1].encode("utf-8")

        timerange = splat[-2].replace("at ", "")
        starttime, endtime = timerange.split(" - ")

        endtime = dt.datetime.strptime(starttime[:-5] + endtime, datetime_format)
        starttime = dt.datetime.strptime(starttime, datetime_format)

        time_range = TimeRange(starttime, endtime)

        time = " ".join(timerange.split()[3:])

        uid = hashlib.md5(f"{uid} {time}".encode("utf-8")).hexdigest()

        events.append(Event(uid, title, time_range, url, calendar))
    return events


def clear_sketchybar():
    args = [
        "--set upcoming drawing=off",
    ]
    os.system("sketchybar -m " + " ".join(args))


def get_drawed_events():
    cmd = 'sketchybar --query upcoming | jq ".popup | .items"'
    output = subprocess.Popen(
        cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE
    ).communicate()[0]
    events = json.loads(output.decode("utf-8"))
    if events:
        return events
    return []


if __name__ == "__main__":
    events = get_all_events()
    known_events = [e for e in events if e.is_known_calendar()]

    if len(known_events) == 0:
        clear_sketchybar()
    else:
        drawn_events = get_drawed_events()
        title_event = known_events[0]
        other_events = known_events[1:]
        title_event.set_to_sketchybar(
            dropdown_events=other_events, drawn_events=drawn_events
        )
