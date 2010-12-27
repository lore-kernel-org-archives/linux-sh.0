From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 27 Dec 2010 04:42:20 +0000
Subject: [PATCH] fbdev: sh_mobile_hdmi: fixup compile error
Message-Id: <w3phbdzu8ra.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Paul

This patch is not needed for now on Paul's tree.
But seems to be needed after ALSA tree merge.

>> Mark, Liam

this patch is needed on current Mark's "for-2.6.38" tree.


 drivers/video/sh_mobile_hdmi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index d7df103..b19941d 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
-- 
1.7.1

