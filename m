From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Wed, 18 Jun 2008 09:32:03 +0000
Subject: [PATCH] sh: Clean up code of Solution Engine 770x
Message-Id: <4858D613.3090902@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/boards/se/770x/setup.c |    4 +---
 include/asm-sh/se.h            |    2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/se/770x/setup.c b/arch/sh/boards/se/770x/setup.c
index 25767cc..cf4a5ba 100644
--- a/arch/sh/boards/se/770x/setup.c
+++ b/arch/sh/boards/se/770x/setup.c
@@ -14,8 +14,6 @@
 #include <asm/smc37c93x.h>
 #include <asm/heartbeat.h>

-void init_se_IRQ(void);
-
 /*
  * Configure the Super I/O chip
  */
@@ -73,7 +71,7 @@ static struct resource cf_ide_resources[] = {
 	},
 	[1] = {
 		.start  = PA_MRSHPC_IO + 0x1f0 + 0x206,
-		.end    = PA_MRSHPC_IO + 0x1f0 +8 + 0x206 + 8,
+		.end    = PA_MRSHPC_IO + 0x1f0 + 8 + 0x206 + 8,
 		.flags  = IORESOURCE_MEM,
 	},
 	[2] = {
diff --git a/include/asm-sh/se.h b/include/asm-sh/se.h
index 0e2f720..eb23000 100644
--- a/include/asm-sh/se.h
+++ b/include/asm-sh/se.h
@@ -91,6 +91,8 @@
 #define SH_ETH1_IRQ	81
 #define SH_TSU_IRQ	82

+void init_se_IRQ(void);
+
 #define __IO_PREFIX	se
 #include <asm/io_generic.h>

-- 
1.5.5.1


