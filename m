From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Feb 2013 14:16:33 +0000
Subject: [PATCH 02/02] ARM: shmobile: Temporarily use emev2_map_io() for SMP
Message-Id: <20130213141633.12474.34597.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

To run SMP together with DT we need to use emev2_map_io
on EMEV2. This due to some early requirements for ioremap().

Instead of blindly applying this I believe we should spend
time looking into why the common ARM ioremap() code dies
early instead of behaving sanely and returning NULL.

So for now I prefer not to merge this. Anyone wanting
to use and/or develop code for KZM9D can instead make
use of the code in board-kzm9d.c.

Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-emev2.c |    1 +
 1 file changed, 1 insertion(+)

--- 0002/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-02-13 17:08:33.000000000 +0900
@@ -454,6 +454,7 @@ static const char *emev2_boards_compat_d
 
 DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.smp		= smp_ops(emev2_smp_ops),
+	.map_io		= emev2_map_io,
 	.init_early	= emev2_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= irqchip_init,
