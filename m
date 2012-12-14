From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 14 Dec 2012 16:45:27 +0000
Subject: [PATCH 3/7] ARM: sh7372: support mixed DT and board code interrupt controller init
Message-Id: <1355503531-7276-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Extend DT interrupt controller initialisation to automatically fall back to
platform data based configuration, if booting without DT. This simplifies
implementing boards, capable of booting in either mode with a single kernel.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/intc-sh7372.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-sh7372.c b/arch/arm/mach-shmobile/intc-sh7372.c
index c923518..9c13ecc 100644
--- a/arch/arm/mach-shmobile/intc-sh7372.c
+++ b/arch/arm/mach-shmobile/intc-sh7372.c
@@ -23,6 +23,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/sh_intc.h>
+#include <mach/common.h>
 #include <mach/intc.h>
 #include <mach/irqs.h>
 #include <asm/mach-types.h>
@@ -629,6 +630,11 @@ static const struct of_device_id irq_of_match[] __initconst = {
 
 void __init sh7372_init_irq_of(void)
 {
+	if (!of_have_populated_dt()) {
+		sh7372_init_irq();
+		return;
+	}
+
 	of_irq_init(irq_of_match);
 
 	sh7372_init_intc(0xe6940000, 0xe6950000, 0xffd20000, 0xffd50000,
-- 
1.7.2.5

