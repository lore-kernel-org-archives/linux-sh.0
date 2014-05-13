From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 13 May 2014 11:37:49 +0000
Subject: [PATCH v2 4/4] pinctrl: sh-pfc: r8a73a4: Allow Multiplatform Build
Message-Id: <1399981069-29366-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add #ifdefs to allow r8a73a4 Multiplatform build. Needed
to enable r8a73a4 Multiplatform support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index d39ca87..ce9fb7a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -20,7 +20,10 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/pinctrl/pinconf-generic.h>
+
+#ifndef CONFIG_ARCH_MULTIPLATFORM
 #include <mach/irqs.h>
+#endif
 
 #include "core.h"
 #include "sh_pfc.h"
-- 
1.8.5.5

