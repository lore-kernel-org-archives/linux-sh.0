From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 06 Jul 2010 04:32:40 +0000
Subject: [PATCH] sh: modify NR_IRQS from 256 to 512
Message-Id: <4C32B1E8.8000502@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The SH7757 has irq number more than 256. So we must modify the value
of NR_IRQS.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/include/asm/irq.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/asm/irq.h b/arch/sh/include/asm/irq.h
index 02c2f01..45d08b6 100644
--- a/arch/sh/include/asm/irq.h
+++ b/arch/sh/include/asm/irq.h
@@ -9,7 +9,7 @@
  * advised to cap this at the hard limit that they're interested in
  * through the machvec.
  */
-#define NR_IRQS			256
+#define NR_IRQS			512
 #define NR_IRQS_LEGACY		8	/* Legacy external IRQ0-7 */

 /*
-- 
1.7.1

