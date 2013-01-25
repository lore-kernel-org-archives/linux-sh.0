From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 25 Jan 2013 03:55:19 +0000
Subject: [PATCH 01/15] ARM: shmobile: Remove duplicate inclusion of dma-mapping.h in setup-r8a7740.c
Message-Id: <1359086133-23357-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1359086133-23357-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1359086133-23357-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sachin Kamat <sachin.kamat@linaro.org>

linux/dma-mapping.h was included twice.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 03c69f9..9ef397d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -27,7 +27,6 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
-#include <linux/dma-mapping.h>
 #include <mach/dma-register.h>
 #include <mach/r8a7740.h>
 #include <mach/pm-rmobile.h>
-- 
1.7.10.4

