From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 08 Feb 2013 18:38:31 +0000
Subject: [PATCH/RFC v2 7/8] ARM: shmobile: parse DT and configure pinmux early on kzm9g-reference
Message-Id: <1360348712-29255-8-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

GPIOs can be provided by the pinctrl subsystem, which can be initialised
by DT. Therefore DT has to be parsed before requesting GPIOs. Also non-DT
pinmux has to be configured early.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Also a hack, that should be replaced by a proper pinctrl DT support.

 arch/arm/mach-shmobile/board-kzm9g-reference.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 8280d8a..728c810 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -34,6 +34,9 @@
 
 static void __init kzm_init(void)
 {
+	sh73a0_add_standard_devices_dt();
+	sh73a0_pinmux_init();
+
 	/* enable SCIFA4 */
 	gpio_request(GPIO_FN_SCIFA4_TXD, NULL);
 	gpio_request(GPIO_FN_SCIFA4_RXD, NULL);
@@ -81,8 +84,6 @@ static void __init kzm_init(void)
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
 #endif
-
-	sh73a0_add_standard_devices_dt();
 }
 
 static void kzm9g_restart(char mode, const char *cmd)
-- 
1.7.2.5

