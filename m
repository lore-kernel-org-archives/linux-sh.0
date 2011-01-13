From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Date: Thu, 13 Jan 2011 13:17:15 +0000
Subject: [PATCH] ARM: mach-shmobile: fix cpu_base of gic_init() on sh73a0
Message-Id: <4D2EFB5B.70209@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The latest rmobile-latest doesn't run on ag5evm because of a
small mistake on initialization.
Though, I don't have any idea to write them smart.
anyway,

On sh73a0, GIC cpu_base is 0xf0000100 but 0xf0001000.

Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
---
 arch/arm/mach-shmobile/intc-sh73a0.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index 322d8d5..5d0e150 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -252,10 +252,11 @@ static irqreturn_t sh73a0_intcs_demux(int irq, void *dev_id)
 
 void __init sh73a0_init_irq(void)
 {
-	void __iomem *gic_base = __io(0xf0001000);
+	void __iomem *gic_dist_base = __io(0xf0001000);
+	void __iomem *gic_cpu_base = __io(0xf0000100);
 	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
 
-	gic_init(0, 29, gic_base, gic_base);
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
 
 	register_intc_controller(&intcs_desc);
 
-- 1.7.2.2 
