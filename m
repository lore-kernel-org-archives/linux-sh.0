From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2015 09:31:28 +0000
Subject: [PATCH 12/15] pinctrl: sh-pfc: sh73a0: Remove obsolete multi-platform check
Message-Id: <1434533491-21979-13-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Since the removal of the sh73a0 legacy board code, sh73a0 is only
supported in generic ARM multi-platform builds.  Hence
CONFIG_ARCH_MULTIPLATFORM is always set, and the check can be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
Please do not apply until the legacy sh73a0 SoC code has been removed.
Or just provide an ack, so Simon can apply it when appropriate.
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index d2efbfb776ac57d6..097526576f88181f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -26,10 +26,6 @@
 #include <linux/regulator/machine.h>
 #include <linux/slab.h>
 
-#ifndef CONFIG_ARCH_MULTIPLATFORM
-#include <mach/irqs.h>
-#endif
-
 #include "core.h"
 #include "sh_pfc.h"
 
-- 
1.9.1

