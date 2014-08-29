From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 Aug 2014 13:26:17 +0000
Subject: [PATCH 0/5] ARM: shmobile: pm domain improvements and cleanups
Message-Id: <1409318782-28133-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Simon, Magnus,

This patch series improves and cleans up the initialization of power domains
and their devices on sh7372/mackerel and r8a7740/armadillo800eva.

Geert Uytterhoeven (5):
  ARM: shmobile: mackerel: Make domain_devices[] static __initdata
  ARM: shmobile: sh7372: Make domain_devices[] static __initdata
  ARM: shmobile: r8a7740: Use rmobile_add_devices_to_domains()
  ARM: shmobile: armadillo800eva legacy: Use
    rmobile_add_devices_to_domains()
  ARM: shmobile: r8a7740: Clean up pm domain table

 arch/arm/mach-shmobile/board-armadillo800eva.c |    8 ++++++--
 arch/arm/mach-shmobile/board-mackerel.c        |    2 +-
 arch/arm/mach-shmobile/pm-r8a7740.c            |   10 ++++-----
 arch/arm/mach-shmobile/setup-r8a7740.c         |   26 ++++++++++++++----------
 arch/arm/mach-shmobile/setup-sh7372.c          |    2 +-
 5 files changed, 27 insertions(+), 21 deletions(-)

-- 
1.7.9.5

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
