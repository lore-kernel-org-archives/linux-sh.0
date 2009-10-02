From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 02 Oct 2009 07:52:20 +0000
Subject: [PATCH] sh: mach-ecovec24: Add DS2 switch explain
Message-Id: <upr96mdvv.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index d9f6d3e..2a65a38 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -39,6 +39,20 @@
  *  0x1800_0000  MFI              16bit
  */
 
+/* SWITCH
+ *------------------------------
+ * DS2[1] = FlashROM write protect  ON     : write protect
+ *                                  OFF    : No write protect
+ * DS2[2] = RMII / TS, SCIF         ON     : RMII
+ *                                  OFF    : TS, SCIF3
+ * DS2[3] = Camera / Video          ON     : Camera
+ *                                  OFF    : NTSC/PAL (IN)
+ * DS2[5] = NTSC_OUT Clock          ON     : On board OSC
+ *                                  OFF    : SH7724 DV_CLK
+ * DS2[6-7] = MMC / SD              ON-OFF : SD
+ *                                  OFF-ON : MMC
+ */
+
 /* Heartbeat */
 static unsigned char led_pos[] = { 0, 1, 2, 3 };
 static struct heartbeat_data heartbeat_data = {
-- 
1.6.0.4

