From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 13 May 2014 11:37:47 +0000
Subject: [PATCH v2 2/4] pinctrl: sh-pfc: r8a7740: Allow Multiplatform Build
Message-Id: <1399981069-29366-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add #ifdefs to allow r8a7740 Multiplatform build. Needed
to enable r8a7740 Multiplatform support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 6c83ce4..e4c1ef4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -22,7 +22,9 @@
 #include <linux/kernel.h>
 #include <linux/pinctrl/pinconf-generic.h>
 
+#ifndef CONFIG_ARCH_MULTIPLATFORM
 #include <mach/irqs.h>
+#endif
 
 #include "core.h"
 #include "sh_pfc.h"
-- 
1.8.5.5

