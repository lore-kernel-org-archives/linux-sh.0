From: Rob Herring <robherring2@gmail.com>
Date: Fri, 20 Jan 2012 20:32:59 +0000
Subject: [PATCH v2 01/13] sound: pxa2xx-ac97: include mach/irqs.h directly
Message-Id: <1327091591-27125-2-git-send-email-robherring2@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
In-Reply-To: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation of removing mach/irqs.h include from asm/irq.h, include
mach/irqs.h directly.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 sound/arm/pxa2xx-ac97-lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index d1aa421..0e9e822 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -21,7 +21,7 @@
 #include <sound/ac97_codec.h>
 #include <sound/pxa2xx-lib.h>
 
-#include <asm/irq.h>
+#include <mach/irqs.h>
 #include <mach/regs-ac97.h>
 #include <mach/audio.h>
 
-- 
1.7.5.4

