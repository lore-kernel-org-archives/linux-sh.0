From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Fri, 18 Jan 2013 07:16:13 +0000
Subject: [PATCH v2 2/2] ARM: shmobile: kzm9g: Don't use gic_handle_irq()
Message-Id: <1358493373-28722-2-git-send-email-thierry.reding@avionic-design.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1358493373-28722-1-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1358493373-28722-1-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This function is no longer publicly available. However, the sh73a0 setup
code now uses the generic irqchip infrastructure which will implicitly
set the IRQ handler, so it's fine to drop its initialization from the
machine definition.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v2:
- new patch with kzm9g board changes

 arch/arm/mach-shmobile/board-kzm9g-reference.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 04e9ae5..08c95dd 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -90,7 +90,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.init_early	= sh73a0_add_early_devices_dt,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh73a0_init_irq_dt,
-	.handle_irq	= gic_handle_irq,
 	.init_machine	= kzm_init,
 	.init_late	= shmobile_init_late,
 	.init_time	= shmobile_timer_init,
-- 
1.8.1.1

