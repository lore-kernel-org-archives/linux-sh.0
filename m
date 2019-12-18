From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 18 Dec 2019 19:48:06 +0000
Subject: [PATCH 0/6] pinctrl: sh-pfc: More miscellenaous fixes
Message-Id: <20191218194812.12741-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

Recently, I have been adding more runtime validation checks to the
sh-pfc driver, to catch already reported and new unknown bugs in the
various SoC-specific pin control drivers.  While the new checks need
more polishing before publication, I'm already posting 6 fixes
discovered by these checks.

I intend to queue these up in sh-pfc-for v5-6.

Thanks for your comments!

Geert Uytterhoeven (6):
  pinctrl: sh-pfc: r8a7778: Fix duplicate SDSELF_B and SD1_CLK_B
  pinctrl: sh-pfc: sh7264: Fix Port K I/O Register 0 definition
  pinctrl: sh-pfc: sh7264: Fix CAN function GPIOs
  pinctrl: sh-pfc: sh7269: Fix CAN function GPIOs
  sh: sh7264: Remove bogus SSU GPIO function definitions
  sh: sh7269: Remove bogus SSU GPIO function definitions

 arch/sh/include/cpu-sh2a/cpu/sh7264.h |  6 -----
 arch/sh/include/cpu-sh2a/cpu/sh7269.h | 17 ++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c  |  4 +--
 drivers/pinctrl/sh-pfc/pfc-sh7264.c   | 33 +++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-sh7269.c   | 39 ++++++++++++++++++---------
 5 files changed, 54 insertions(+), 45 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
