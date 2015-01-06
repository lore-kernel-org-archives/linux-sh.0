From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 06 Jan 2015 19:56:04 +0000
Subject: [PATCH v2 0/2] ARM: shmobile: sh73a0: CCF conversion fallout
Message-Id: <1420574166-14979-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Simon, Magnus,

This patch series contains two missing pieces for the sh73a0 common
clock framework conversion.

Both patches are independent of each other, but please note that "ARM:
shmobile: sh73a0 dtsi: Add missing INTCA0 clock for irqpin module"
(con)textually depends on "ARM: shmobile: sh73a0 dtsi: Set
control-parent for all irqpin nodes", which is a fix for a crash and
thus had higher priority.

Thanks for applying!

Geert Uytterhoeven (1):
  ARM: shmobile: sh73a0 dtsi: Add missing INTCA0 clock for irqpin module

Ulrich Hecht (1):
  ARM: shmobile: sh73a0 dtsi: Add selectable sources to DIV6 clocks

 arch/arm/boot/dts/sh73a0.dtsi            | 79 ++++++++++++++++++++++++--------
 include/dt-bindings/clock/sh73a0-clock.h |  3 ++
 2 files changed, 63 insertions(+), 19 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
