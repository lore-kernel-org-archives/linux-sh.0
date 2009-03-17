From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Tue, 17 Mar 2009 05:53:26 +0000
Subject: [PATCH] sh: sh7763rdp: Change IRQ number for sh_eth of sh7763rdp
Message-Id: <49BF3AD6.8090806@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

IRQ for sh_eth of sh7763rdp became multi handling.
Therefore, the IRQ number of sh_eth is changed, too.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/boards/mach-sh7763rdp/setup.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-sh7763rdp/setup.c b/arch/sh/boards/mach-sh7763rdp/setup.c
index 6f926fd..27d1c9e 100644
--- a/arch/sh/boards/mach-sh7763rdp/setup.c
+++ b/arch/sh/boards/mach-sh7763rdp/setup.c
@@ -63,15 +63,19 @@ static struct platform_device sh7763rdp_nor_flash_device = {
 	},
 };

-/* SH-Ether */
+/*
+ * SH-Ether
+ *
+ * SH Ether of SH7763 has multi IRQ handling.
+ * (57,58,59 -> 57)
+ */
 static struct resource sh_eth_resources[] = {
 	{
 		.start  = 0xFEE00800,   /* use eth1 */
 		.end    = 0xFEE00F7C - 1,
 		.flags  = IORESOURCE_MEM,
 	}, {
-		.start  = 58,   /* irq number */
-		.end    = 58,
+		.start  = 57,   /* irq number */
 		.flags  = IORESOURCE_IRQ,
 	},
 };
-- 
1.6.2
