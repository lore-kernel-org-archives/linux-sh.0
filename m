From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 16 Mar 2010 02:01:53 +0000
Subject: [PATCH] sh: ms7724: Add tiny-document for sound
Message-Id: <uwrxdyqge.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-se/7724/setup.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 66cdbc3..ccaa290 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -52,6 +52,13 @@
  * and change SW41 to use 720p
  */
 
+/*
+ * about sound
+ *
+ * This setup.c supports FSI slave mode.
+ * Please change J20, J21, J22 pin to 1-2 connection.
+ */
+
 /* Heartbeat */
 static struct resource heartbeat_resource = {
 	.start  = PA_LED,
@@ -276,6 +283,7 @@ static struct clk fsimcka_clk = {
 	.rate		= 0, /* unknown */
 };
 
+/* change J20, J21, J22 pin to 1-2 connection to use slave mode */
 struct sh_fsi_platform_info fsi_info = {
 	.porta_flags = SH_FSI_BRS_INV |
 		       SH_FSI_OUT_SLAVE_MODE |
-- 
1.6.3.3

