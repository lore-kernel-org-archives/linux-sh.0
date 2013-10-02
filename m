From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 08:39:48 +0000
Subject: [PATCH 3/4 v2] ARM: shmobile: marzen: enable INTC IRQ
Message-Id: <877gdwyskv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds missing INTC IRQ settings
which is required from SMSC.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - patch was splited, only reference.c

 arch/arm/mach-shmobile/board-marzen-reference.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 3f4250a..2773936 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -28,6 +28,7 @@
 static void __init marzen_init(void)
 {
 	r8a7779_add_standard_devices_dt();
+	r8a7779_init_irq_extpin_dt(1); /* IRQ1 as individual interrupt */
 }
 
 static const char *marzen_boards_compat_dt[] __initdata = {
-- 
1.7.9.5

