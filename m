From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 04 Jun 2015 18:22:24 +0000
Subject: [PATCH 00/11] ARM: shmobile: R-Mobile / R-Car PM Domain improvements
Message-Id: <1433442155-19492-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Simon, Magnus,

This patch series contains various cleanups, improvements, and minor
fixes for the R-Mobile and R-Car PM Domain implementations.

Thanks!

Geert Uytterhoeven (11):
  ARM: shmobile: R-Mobile: Move to_rmobile_pd from header to source file
  ARM: shmobile: R-Mobile: Use BIT() macro instead of open coding
  ARM: shmobile: R-Car: Improve documentation
  ARM: shmobile: R-Car: Shrink rcar_sysc_ch size
  ARM: shmobile: R-Car: Break infinite loop
  ARM: shmobile: R-Car: Make struct rcar_sysc_ch * parameters const
  ARM: shmobile: R-Car: Use BIT() macro instead of open coding
  ARM: shmobile: R-Car: Get rid of on_off_fn() function pointer
  ARM: shmobile: r8a7779: Remove GENPD_FLAG_PM_CLK flag
  ARM: shmobile: r8a7779: Make struct rcar_sysc_ch const
  ARM: shmobile: r8a7790: Make struct rcar_sysc_ch const

 arch/arm/mach-shmobile/pm-r8a7779.c  |   4 +-
 arch/arm/mach-shmobile/pm-rcar.c     | 105 ++++++++++++++++++++++-------------
 arch/arm/mach-shmobile/pm-rcar.h     |  12 ++--
 arch/arm/mach-shmobile/pm-rmobile.c  |  10 +++-
 arch/arm/mach-shmobile/pm-rmobile.h  |   6 --
 arch/arm/mach-shmobile/smp-r8a7779.c |  12 ++--
 arch/arm/mach-shmobile/smp-r8a7790.c |   4 +-
 7 files changed, 90 insertions(+), 63 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
