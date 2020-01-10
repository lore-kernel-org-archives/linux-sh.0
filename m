From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jan 2020 13:19:14 +0000
Subject: [PATCH 00/13] pinctrl: sh-pfc: checker: Various improvements
Message-Id: <20200110131927.1029-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

This patch series contains various improvements for the builtin pin
control table runtime checks of the Renesas Pin Function Controller
driver.  These checks are enabled with CONFIG_DEBUG_PINCTRL=y, which can
be combined with CONFIG_COMPILE_TEST=y to increase coverage to all
Renesas ARM and SuperH SoCs..

Note that all issues detected by this have already been fixed in "[PATCH
0/6] pinctrl: sh-pfc: More miscellenaous fixes"[1], and are now part of
linux-next.

I plan to queue this in sh-pfc-for-v5.7.

Thanks for your comments!

[1] https://lore.kernel.org/linux-renesas-soc/20191218194812.12741-1-geert+renesas@glider.be/

Geert Uytterhoeven (13):
  pinctrl: sh-pfc: checker: Move data before code
  pinctrl: sh-pfc: checker: Add helpers for reporting
  pinctrl: sh-pfc: checker: Add helper for safe name comparison
  pinctrl: sh-pfc: checker: Add check for config register conflicts
  pinctrl: sh-pfc: checker: Add check for enum ID conflicts
  pinctrl: sh-pfc: checker: Improve pin checks
  pinctrl: sh-pfc: checker: Improve pin function checks
  pinctrl: sh-pfc: checker: Improve pin group checks
  pinctrl: sh-pfc: checker: Add drive strength register checks
  pinctrl: sh-pfc: checker: Add bias register checks
  pinctrl: sh-pfc: checker: Add ioctrl register checks
  pinctrl: sh-pfc: checker: Add data register checks
  pinctrl: sh-pfc: checker: Add function GPIO checks

 drivers/pinctrl/sh-pfc/core.c | 312 +++++++++++++++++++++++++++-------
 1 file changed, 250 insertions(+), 62 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
