From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 May 2009 14:34:43 +0000
Subject: [PATCH] video: stop sh_mobile_lcdcfb only if started
Message-Id: <20090520143443.8362.79529.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch fixes the LCDC driver to avoid calling the
function sh_mobile_lcdc_start_stop(priv, 0) unless the
same function has been called before to start the LCDC
hardware.

Triggered when sh_mobile_lcdcfb.c failed to probe() due to
missing MSTP clocks.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/sh_mobile_lcdcfb.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2009-05-20 22:26:40.000000000 +0900
@@ -47,6 +47,7 @@ struct sh_mobile_lcdc_priv {
 #endif
 	unsigned long lddckr;
 	struct sh_mobile_lcdc_chan ch[2];
+	int started;
 };
 
 /* shared registers */
@@ -451,6 +452,7 @@ static int sh_mobile_lcdc_start(struct s
 
 	/* start the lcdc */
 	sh_mobile_lcdc_start_stop(priv, 1);
+	priv->started = 1;
 
 	/* tell the board code to enable the panel */
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
@@ -493,7 +495,10 @@ static void sh_mobile_lcdc_stop(struct s
 	}
 
 	/* stop the lcdc */
-	sh_mobile_lcdc_start_stop(priv, 0);
+	if (priv->started) {
+		sh_mobile_lcdc_start_stop(priv, 0);
+		priv->started = 0;
+	}
 
 	/* stop clocks */
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++)
