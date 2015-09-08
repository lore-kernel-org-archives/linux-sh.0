From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 08 Sep 2015 17:00:34 +0000
Subject: [PATCH 0/2] irqchip: renesas: Propagate wake-up settings to parent
Message-Id: <1441731636-17610-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Thomas, Jason, Marc,

The renesas-intc-irqpin and renesas-irqc interrupt controllers are
cascaded to GICs, but their drivers don't propagate wake-up settings to
their parent interrupt controllers.

Since commit aec89ef72ba6c944 ("irqchip/gic: Enable SKIP_SET_WAKE and
MASK_ON_SUSPEND"), the GIC driver masks interrupts during suspend, and
wake-up through gpio-keys now fails on r8a73a4/ape6evm,
r8a7740/armadillo and sh73a0/kzm9g.

Fix this by propagating wake-up settings to the parent interrupt
controllers. There's no need to handle irq_set_irq_wake() failures, as
the renesas-intc-irqpin and renesas-irqc interrupt controllers are
always cascaded to GICs, and the GIC driver always sets SKIP_SET_WAKE
since the aforementioned commit.

These fixes are meant for v4.3, as commit aec89ef72ba6c944 is already
upstream.

Note that masking GIC interrupts during suspend has another side effect:
before, if no_console_suspend was enabled, the system woke up on console
activity. This is no longer the case, but that's not a bug.

Thanks!

Geert Uytterhoeven (2):
  irqchip: renesas-intc-irqpin: Propagate wake-up settings to parent
  irqchip: renesas-irqc: Propagate wake-up settings to parent

 drivers/irqchip/irq-renesas-intc-irqpin.c | 3 +++
 drivers/irqchip/irq-renesas-irqc.c        | 3 +++
 2 files changed, 6 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
