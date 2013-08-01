From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 01 Aug 2013 08:26:28 +0000
Subject: [PATCH 06/14] ARM: shmobile: Remove r8a7779 use of <mach/hardware.h>
Message-Id: <603e45827b4a565506417fbdc3400eedf8846c3d.1375344714.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused <mach/hardware.h> on r8a7779.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 66d3826..6ab7405 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -37,7 +37,6 @@
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/pm_runtime.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
-- 
1.8.3.2

