From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:01:54 +0000
Subject: [PATCH v3 34/64] ARM: shmobile: marzen: Register pinctrl mappings for LBSC
Message-Id: <1362740544-19164-35-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based LBSC pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 4cdb8e0..053b957 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -349,6 +349,8 @@ static const struct pinctrl_map marzen_pinctrl_map[] = {
 				  "sdhi0_cd", "sdhi0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
 				  "sdhi0_wp", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a7779",
+				  "lbsc_ex_cs0", "lbsc"),
 };
 
 static void __init marzen_init(void)
@@ -363,7 +365,6 @@ static void __init marzen_init(void)
 	r8a7779_pinmux_init();
 
 	/* LAN89218 */
-	gpio_request(GPIO_FN_EX_CS0, NULL); /* nCS */
 	gpio_request(GPIO_FN_IRQ1_B, NULL); /* IRQ + PME */
 
 	r8a7779_add_standard_devices();
-- 
1.8.1.5

