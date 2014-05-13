From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 13 May 2014 11:37:48 +0000
Subject: [PATCH v2 3/4] pinctrl: sh-pfc: sh73a0: Allow Multiplatform Build
Message-Id: <1399981069-29366-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add #ifdefs to allow sh73a0 Multiplatform build. Needed
to enable sh73a0 Multiplatform support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 6f6ba10..ee370de 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -26,7 +26,9 @@
 #include <linux/regulator/machine.h>
 #include <linux/slab.h>
 
+#ifndef CONFIG_ARCH_MULTIPLATFORM
 #include <mach/irqs.h>
+#endif
 
 #include "core.h"
 #include "sh_pfc.h"
-- 
1.8.5.5

