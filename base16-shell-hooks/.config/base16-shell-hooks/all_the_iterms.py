#!/usr/bin/env python3

import asyncio
import os
import sys
import iterm2

def set_color_preset(change, preset):
    """
    iTerm2's API lacks this functionality.
    """
    for value in preset.values:
        change._color_set(
            value.key,
            iterm2.color.Color(
                value.red,
                value.green,
                value.blue,
                value.alpha,
                value.color_space))

async def main(connection):
    theme_name = 'base16-' + os.getenv('BASE16_THEME')
    preset = await iterm2.ColorPreset.async_get(connection, theme_name)
    profiles = await iterm2.PartialProfile.async_query(connection)

    for partial in profiles:
        profile = await partial.async_get_full_profile()
        await profile.async_set_color_preset(preset)

    app = await iterm2.async_get_app(connection)
    for window in app.terminal_windows:
        for tab in window.tabs:
            for session in tab.sessions:
                profile = await session.async_get_profile()
                change = iterm2.LocalWriteOnlyProfile()
                set_color_preset(change, preset)
                await session.async_set_profile_properties(change)

iterm2.run_until_complete(main)
