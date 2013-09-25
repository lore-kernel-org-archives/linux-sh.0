From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 25 Sep 2013 01:55:22 +0000
Subject: [PATCH][resend] sh: ecovec: fixup compile error on sdhi
Message-Id: <87zjr1ll6g.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

afa2c9407f8908e2269b243773cbb0997c553804
(sh: ecovec24: Use MMC/SDHI CD and RO GPIO)
added .tmio_flags = TMIO_MMC_USE_GPIO_CD
on sh_mobile_sdhi_info, but it needs
<linux/mfd/tmio.h> header.
This patch adds it

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
change

 - add Laurent's ACK
 - To Chris

 arch/sh/boards/mach-ecovec24/setup.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 1fa8be4..122f737 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -15,6 +15,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mtd/physmap.h>
+#include <linux/mfd/tmio.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-- 
1.7.9.5

