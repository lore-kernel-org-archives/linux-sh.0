From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 14 Aug 2020 11:07:28 +0000
Subject: [PATCH 0/3] rtc: rtc-rs5c313: Fix and cleanups
Message-Id: <20200814110731.29029-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, kogiidena <kogiidena@eggplant.ddo.jp>, Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-rtc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Ale{ss,x}andr[oe],

This patch series fixes the RS5C313 RTC driver, which is used on the I-O
DATA USL-5P aka Landisk:

    -rs5c313 rs5c313: rs5c313_rtc_read_time: timeout error
     rs5c313 rs5c313: registered as rtc0
    -rs5c313 rs5c313: rs5c313_rtc_read_time: timeout error
    -rs5c313 rs5c313: hctosys: unable to read the hardware clock
    +rs5c313 rs5c313: setting system clock to 2020-08-14T01:04:12 UTC (1597367052)

and performs a few related code cleanups.

Thanks for your comments!

Geert Uytterhoeven (3):
  rtc: rtc-rs5c313: Drop obsolete platform_set_drvdata() call
  rtc: rtc-rs5c313: Fix late hardware init
  rtc: rtc-rs5c313: Convert to module_platform_driver()

 drivers/rtc/rtc-rs5c313.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
