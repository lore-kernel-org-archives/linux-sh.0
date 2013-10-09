From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 09 Oct 2013 06:51:06 +0000
Subject: [PATCH 14/14] ARM: shmobile: marzen: enable INTC IRQ
Message-Id: <7d4bde88e1135c4a3106b79650d3b85335f35717.1381299817.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1381299817.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1381299817.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds missing INTC IRQ settings
which is required from SMSC.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 1 +
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
1.8.4

