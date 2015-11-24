From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 24 Nov 2015 14:49:39 +0000
Subject: [PATCH v2 0/2] irqchip/renesas-intc-irqpin: Remove obsolete platform data support
Message-Id: <1448376581-9202-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Thomas, Jason, Marc,

Since commit 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete
setup code"), which is now in v4.4-rc1, all Renesas SoCs with a
renesas-intc-irqpin module are only supported in generic DT-only ARM
multi-platform builds.  The driver doesn't need to use platform data anymore,
hence this series removes platform data configuration, and does a small
cleanup.

Changes since v1:
  - Add Acked-by,
  - Platform dependency has entered mainline.

Thanks for applying!

Geert Uytterhoeven (2):
  irqchip/renesas-intc-irqpin: Remove obsolete platform data support
  irqchip/renesas-intc-irqpin: Remove intc_irqpin_priv.number_of_irqs

 drivers/irqchip/irq-renesas-intc-irqpin.c          | 51 ++++++++--------------
 .../linux/platform_data/irq-renesas-intc-irqpin.h  | 29 ------------
 2 files changed, 18 insertions(+), 62 deletions(-)
 delete mode 100644 include/linux/platform_data/irq-renesas-intc-irqpin.h

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
