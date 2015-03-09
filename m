From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 09 Mar 2015 20:06:53 +0000
Subject: [PATCH 0/4] ARM: shmobile: koelsch / lager regulator updates
Message-Id: <1425931617-5479-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

	Hi Simon, Magnus,

This patch series contains two DTS updates each for r8a7791/koelsch and
r8a7790/lager:
  - add the missing interrupt for the da9210 regulators,
  - add device nodes for the da9063 pmics.

The da9063 pmic allows the system to be restarted when the watchdog
timer times out ("cat > dev/watchdog0", and wait 8 s), or when a system
restart is requested ("reboot").

This series depends on "[PATCH] ARM: shmobile: R-Car Gen2: Add
da9063/da9210 regulator quirk".

An earlier version of patch [2/4] has been posted before as "[PATCH 3/4]
ARM: shmobile: koelsch: Add DA9063 PMIC device node for system
restart", but it caused havoc without the quirk.

This has been tested on r8a7791/koelsch.

Thanks!

Geert Uytterhoeven (4):
  ARM: shmobile: koelsch dts: Add da9210 regulator interrupt
  ARM: shmobile: koelsch: Add da9063 PMIC device node for system restart
  ARM: shmobile: lager dts: Add da9210 regulator interrupt
  ARM: shmobile: lager: Add da9063 PMIC device node for system restart

 arch/arm/boot/dts/r8a7790-lager.dts   | 18 ++++++++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
