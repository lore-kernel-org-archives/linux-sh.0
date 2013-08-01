From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 01 Aug 2013 08:26:25 +0000
Subject: [PATCH 03/14] ARM: shmobile: Remove sh73a0 use of <mach/hardware.h>
Message-Id: <fb0724805eb7369a75a434873f409b42e33ecb85.1375344714.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused <mach/hardware.h> on sh73a0.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 516c239..22de174 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -34,7 +34,6 @@
 #include <linux/platform_data/sh_ipmmu.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <mach/dma-register.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
-- 
1.8.3.2

