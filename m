From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 09 Sep 2015 11:42:53 +0000
Subject: [PATCH 1/2] irqchip: renesas-irqc: Use a separate lockdep class
Message-Id: <1441798974-25716-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1441798974-25716-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1441798974-25716-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The renesas-irqc interrupt controller is cascaded to the GIC. Hence when
propagating wake-up settings to its parent interrupt controller, the
following lockdep warning is printed:

    ======================    [ INFO: possible recursive locking detected ]
    4.2.0-ape6evm-10725-g50fcd7643c034198 #280 Not tainted
    ---------------------------------------------
    s2ram/1072 is trying to acquire lock:
    (&irq_desc_lock_class){-.-...}, at: [<c008d3fc>] __irq_get_desc_lock+0x58/0x98

    but task is already holding lock:
    (&irq_desc_lock_class){-.-...}, at: [<c008d3fc>] __irq_get_desc_lock+0x58/0x98

    other info that might help us debug this:
    Possible unsafe locking scenario:

	  CPU0
	  ----
     lock(&irq_desc_lock_class);
     lock(&irq_desc_lock_class);

    *** DEADLOCK ***

    May be due to missing lock nesting notation

    6 locks held by s2ram/1072:
    #0:  (sb_writers#7){.+.+.+}, at: [<c012eb14>] __sb_start_write+0xa0/0xa8
    #1:  (&of->mutex){+.+.+.}, at: [<c019396c>] kernfs_fop_write+0x4c/0x1bc
    #2:  (s_active#24){.+.+.+}, at: [<c0193974>] kernfs_fop_write+0x54/0x1bc
    #3:  (pm_mutex){+.+.+.}, at: [<c008213c>] pm_suspend+0x10c/0x510
    #4:  (&dev->mutex){......}, at: [<c02af3c4>] __device_suspend+0xdc/0x2cc
    #5:  (&irq_desc_lock_class){-.-...}, at: [<c008d3fc>] __irq_get_desc_lock+0x58/0x98

    stack backtrace:
    CPU: 0 PID: 1072 Comm: s2ram Not tainted 4.2.0-ape6evm-10725-g50fcd7643c034198 #280
    Hardware name: Generic R8A73A4 (Flattened Device Tree)
    [<c0018078>] (unwind_backtrace) from [<c00144f0>] (show_stack+0x10/0x14)
    [<c00144f0>] (show_stack) from [<c0451f14>] (dump_stack+0x88/0x98)
    [<c0451f14>] (dump_stack) from [<c007b29c>] (__lock_acquire+0x15cc/0x20e4)
    [<c007b29c>] (__lock_acquire) from [<c007c6e0>] (lock_acquire+0xac/0x12c)
    [<c007c6e0>] (lock_acquire) from [<c0457c00>] (_raw_spin_lock_irqsave+0x40/0x54)
    [<c0457c00>] (_raw_spin_lock_irqsave) from [<c008d3fc>] (__irq_get_desc_lock+0x58/0x98)
    [<c008d3fc>] (__irq_get_desc_lock) from [<c008ebbc>] (irq_set_irq_wake+0x20/0xf8)
    [<c008ebbc>] (irq_set_irq_wake) from [<c0260770>] (irqc_irq_set_wake+0x20/0x4c)
    [<c0260770>] (irqc_irq_set_wake) from [<c008ec28>] (irq_set_irq_wake+0x8c/0xf8)
    [<c008ec28>] (irq_set_irq_wake) from [<c02cb8c0>] (gpio_keys_suspend+0x74/0xc0)
    [<c02cb8c0>] (gpio_keys_suspend) from [<c02ae8cc>] (dpm_run_callback+0x54/0x124)

Avoid this false positive by using a separate lockdep class for IRQC
interrupts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-renesas-irqc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 49f6c41d94f91d4d..35bf97ba4a3d196d 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -153,6 +153,12 @@ static irqreturn_t irqc_irq_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+/*
+ * This lock class tells lockdep that IRQC irqs are in a different
+ * category than their parents, so it won't report false recursion.
+ */
+static struct lock_class_key irqc_irq_lock_class;
+
 static int irqc_irq_domain_map(struct irq_domain *h, unsigned int virq,
 			       irq_hw_number_t hw)
 {
@@ -160,6 +166,7 @@ static int irqc_irq_domain_map(struct irq_domain *h, unsigned int virq,
 
 	irqc_dbg(&p->irq[hw], "map");
 	irq_set_chip_data(virq, h->host_data);
+	irq_set_lockdep_class(virq, &irqc_irq_lock_class);
 	irq_set_chip_and_handler(virq, &p->irq_chip, handle_level_irq);
 	return 0;
 }
-- 
1.9.1

