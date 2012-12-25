From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Dec 2012 04:04:20 +0000
Subject: [PATCH 4/4] sh: ecovec: add sample amixer settings
Message-Id: <87licm7p6m.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

FSI - DA7210 needs amixer settings to use it.
This patch adds quick setting guide

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 64559e8a..b20a14e 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -70,6 +70,16 @@
  *                                  OFF-ON : MMC
  */
 
+/*
+ * FSI - DA7210
+ *
+ * it needs amixer settings for playing
+ *
+ * amixer set 'HeadPhone' 80
+ * amixer set 'Out Mixer Left DAC Left' on
+ * amixer set 'Out Mixer Right DAC Right' on
+ */
+
 /* Heartbeat */
 static unsigned char led_pos[] = { 0, 1, 2, 3 };
 
-- 
1.7.9.5

