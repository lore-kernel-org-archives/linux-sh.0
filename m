From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 11 Jan 2016 18:41:11 +0000
Subject: [PATCH 0/3] ARM: shmobile: Fix loop-based delays
Message-Id: <1452537674-20006-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Simon, Magnus,

I accidentally noticed that on r8a7740/armadillo, "mdelay(1000)" took
only 333 ms with my personal config, while it took 3675 ms with
shmobile_defconfig.

Finding out why brought me an animating journey through obscure code
and kernel config options...

Apparently loop-based delays may complete early on all shmobile SoCs,
which may lead to subtle driver failures. Fortunately(?) this was
mitigated by:
  1. the ARM arch timer on Cortex A7 and A15, which is used instead of
     loop-based delays if available,
  2. shmobile_defconfig having CONFIG_CPU_BPREDICT_DISABLE enabled
     (why?), which makes loops up to 16 times slower.

This patch series fixes both, and removes a related check for Cortex A8
CPU cores, which are no longer supported anyway.

Tested on a collection of shmobile SoCs with Cortex A7, A9, and A15 CPU
cores, with some verification on BeagleBone Black (Cortex A8).

Thanks for applying!

Geert Uytterhoeven (3):
  ARM: shmobile: timer: Fix preset_lpj leading to too short delays
  ARM: shmobile: timer: Drop support for Cortex A8
  ARM: shmobile: defconfig: Do not enable CONFIG_CPU_BPREDICT_DISABLE

 arch/arm/configs/shmobile_defconfig |  1 -
 arch/arm/mach-shmobile/timer.c      | 26 +++++++++-----------------
 2 files changed, 9 insertions(+), 18 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
