From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 09 Sep 2015 11:42:52 +0000
Subject: [PATCH 0/2] irqchip: renesas: Use a separate lockdep classes
Message-Id: <1441798974-25716-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Thomas, Jason,

The renesas-intc-irqpin and renesas-irqc interrupt controllers are
cascaded to GICs. Hence when propagating wake-up settings to their parent
interrupt controllers, a lockdep warning is printed.

Avoid these false positive by using separate lockdep classes for IRQC
and INTC External IRQ Pin interrupts.

This depends on "[PATCH 0/2] irqchip: renesas: Propagate wake-up
settings to parent". Initially I didn't see the warnings on all
platforms due to another unrelated lockdep warning.

Thanks!

Geert Uytterhoeven (2):
  irqchip: renesas-irqc: Use a separate lockdep class
  irqchip: renesas-intc-irqpin: Use a separate lockdep class

 drivers/irqchip/irq-renesas-intc-irqpin.c | 7 +++++++
 drivers/irqchip/irq-renesas-irqc.c        | 7 +++++++
 2 files changed, 14 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
