From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 09 Jan 2015 13:08:48 +0000
Subject: [PATCH 0/4] ARM: shmobile: sh73a0/kzm9g: Introduce multiplatform support
Message-Id: <1420808932-3899-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

	Hi Simon, Magnus,

This patch series (by Magnus) introduces multiplatform support for the
sh73a0 platform. After this kzm9g can boot a sh73a0 multiplatform
kernel fine, except for working Ethernet (the ZB clock is disabled by
clk_disable_unused()).

This series has been sent before by Magnus as part of the series
"[PATCH v2 00/05] ARM: shmobile: sh73a0 and kzm9g Multiplatform
revisit" (http://www.spinics.net/lists/linux-sh/msg38384.html).
I've updated the kzm9g DTS sync patch for recent changes to the
kzm9g-reference DTS.

Thanks for applying!

Magnus Damm (4):
  ARM: shmobile: sh73a0: Introduce generic setup callback
  ARM: shmobile: sh73a0: Add Multiplatform support
  ARM: shmobile: kzm9g dts: Sync with kzm9g-reference dts
  ARM: shmobile: kzm9g: Build DTS for Multiplatform

 arch/arm/boot/dts/Makefile            |   3 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts    | 374 +++++++++++++++++++++++++++++++++-
 arch/arm/mach-shmobile/Kconfig        |   5 +
 arch/arm/mach-shmobile/Makefile       |   4 +-
 arch/arm/mach-shmobile/setup-sh73a0.c |  16 +-
 arch/arm/mach-shmobile/smp-sh73a0.c   |   2 +-
 6 files changed, 396 insertions(+), 8 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
