From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 17 Oct 2014 12:22:37 +0000
Subject: [PATCH] ARM: shmobile: sh7372: Add shmobile_init_late()
Message-Id: <1413548557-11962-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Extend sh7372 SoC machine vector to include shmobile_init_late()
so Suspend-to-RAM and CPUIdle are setup as expected.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This was the last remaining machine_desc not calling
shmobile_init_late().
---
 arch/arm/mach-shmobile/setup-sh7372.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index d646c8d12423a600..769ff008571d6732 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -1012,6 +1012,7 @@ DT_MACHINE_START(SH7372_DT, "Generic SH7372 (Flattened Device Tree)")
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= sh7372_add_standard_devices_dt,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= sh7372_boards_compat_dt,
 MACHINE_END
 
-- 
1.9.1

