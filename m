From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 13 Aug 2014 11:59:59 +0000
Subject: [PATCH 0/4] ARM: shmobile: Remove unneeded nr_irqs initialization
Message-Id: <1407931199-11756-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series removes the remaining initializations of
machine_desc.nr_irqs, which are unneeded as they match the default value.

As per arch_probe_nr_irqs(), the default value is NR_IRQS, which maps to
NR_IRQS_LEGACY if CONFIG_SPARSE_IRQ=y.

Since SPARSE_IRQ is selected by both ARCH_MULTIPLATFORM and
ARCH_SHMOBILE_LEGACY, it's always enabled on shmobile.

Geert Uytterhoeven (4):
  ARM: shmobile: sh7372: Remove unneeded nr_irqs initialization
  ARM: shmobile: sh73a0: Remove unneeded nr_irqs initialization
  ARM: shmobile: kzm9g-reference: Remove unneeded nr_irqs initialization
  ARM: shmobile: kzm9g: Remove unneeded nr_irqs initialization

 arch/arm/mach-shmobile/board-kzm9g-reference.c | 1 -
 arch/arm/mach-shmobile/board-kzm9g.c           | 1 -
 arch/arm/mach-shmobile/setup-sh7372.c          | 1 -
 arch/arm/mach-shmobile/setup-sh73a0.c          | 1 -
 4 files changed, 4 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
