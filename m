From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Apr 2013 06:54:16 +0000
Subject: [PATCH] ARM: shmobile: bockw: add CN9 SCIF/RCAN selection dipswitch explanation
Message-Id: <87y5cs9otn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Debug serial (= SCIF0) is connected to CN9 upper side,
and it is shared by RCAN.
This patch adds SCIF/RCAN dipswitch explanation on
comment area for developers.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index dac4365..0275d14 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -26,6 +26,14 @@
 #include <mach/r8a7778.h>
 #include <asm/mach/arch.h>
 
+/*
+ *	CN9(Upper side) SCIF/RCAN selection
+ *
+ *		1,4	3,6
+ * SW40		SCIF	RCAN
+ * SW41		SCIF	RCAN
+ */
+
 static struct smsc911x_platform_config smsc911x_data = {
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
-- 
1.7.9.5

