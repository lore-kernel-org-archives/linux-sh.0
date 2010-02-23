From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 23 Feb 2010 03:51:09 +0000
Subject: Re: Problem when testing current git on sh3 + hp6xx
Message-Id: <20100223035108.GC4356@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100223025042.GA28763@rafazurita.homelinux.net>
In-Reply-To: <20100223025042.GA28763@rafazurita.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 22, 2010 at 11:50:42PM -0300, Rafael Ignacio Zurita wrote:
> Hello, 
>   I am testing current sh-2.6.git on SH7709 based hp6xx,
> using earlyprintk as Paul suggested me.
> 
> When booting, kernel shows an
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> and then 
> Kernel panic - not syncing: Fatal exception in interrupt
> 
> I built using arch/sh/configs/hp6xx_defconfig, and enabling
> Verbose BUG() reporting and KALLSYMS_ALL as well.
> 
Can you boot this with ignore_loglevel on the command line also please,
it would be helpful to see what the sparse IRQ mapping looks like.

> Unable to handle kernel NULL pointer dereference at virtual address 00000000
[snip]
> PR is at sh_tmu_interrupt+0x20/0x50
> PC  : 00000000 SP  : 8d1c7ebc SR  : 400001f0 TEA : 00000000
> R0  : 00000000 R1  : 00000000 R2  : 00000020 R3  : 00000100
> R4  : 8dc06e9c R5  : 8dc06e60 R6  : 00000000 R7  : 00000010
> R8  : 8dc06e68 R9  : 00000000 R10 : 00000000 R11 : 00000010
> R12 : 8d003c80 R13 : 000000f0 R14 : 8d003cb0
> MACH: 09127064 MACL: 00000ea0 GBR : 8c009800 PR  : 8d162ab0
> 
> Call trace:
>  [<8d03cbb2>] handle_IRQ_event+0x42/0x150
>  [<8d03ea14>] handle_level_irq+0x44/0xd0
>  [<8d003cb0>] __raw_local_save_flags+0x0/0x10
>  [<8d003c80>] raw_local_irq_restore+0x0/0x30
>  [<8d0039f0>] do_IRQ+0x30/0x60
>  [<8d0080ec>] ret_from_exception+0x0/0xc
>  [<8d0039c0>] do_IRQ+0x0/0x60
>  [<8d003c80>] raw_local_irq_restore+0x0/0x30
>  [<8d003cb0>] __raw_local_save_flags+0x0/0x10
>  [<8d003c92>] raw_local_irq_restore+0x12/0x30
>  [<8d03d45a>] __setup_irq+0xea/0x350
>  [<8d1656ba>] sh_tmu_probe+0x24a/0x330
>  [<8d1ee11c>] early_platform_driver_probe+0x250/0x2cc
>  [<8d1ee11c>] early_platform_driver_probe+0x250/0x2cc
> 
Based on this it would seem that you are entering the kernel with pending
timer IRQs and are racing against the clockevent setup, as no one has set
up the event handler yet. Try this:

---

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 93c2322..961f5b5 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -323,15 +323,15 @@ static void sh_tmu_register_clockevent(struct sh_tmu_priv *p,
 	ced->set_next_event = sh_tmu_clock_event_next;
 	ced->set_mode = sh_tmu_clock_event_mode;
 
+	pr_info("sh_tmu: %s used for clock events\n", ced->name);
+	clockevents_register_device(ced);
+
 	ret = setup_irq(p->irqaction.irq, &p->irqaction);
 	if (ret) {
 		pr_err("sh_tmu: failed to request irq %d\n",
 		       p->irqaction.irq);
 		return;
 	}
-
-	pr_info("sh_tmu: %s used for clock events\n", ced->name);
-	clockevents_register_device(ced);
 }
 
 static int sh_tmu_register(struct sh_tmu_priv *p, char *name,
