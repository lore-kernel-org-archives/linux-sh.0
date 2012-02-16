From: Danny Kukawka <danny.kukawka@bisect.de>
Date: Thu, 16 Feb 2012 14:46:38 +0000
Subject: [PATCH] arch/arm/mach-shmobile/board-ag5evm.c: included linux/dma-mapping.h twice
Message-Id: <1329403598-304-1-git-send-email-danny.kukawka@bisect.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

arch/arm/mach-shmobile/board-ag5evm.c: included 'linux/dma-mapping.h'
twice, remove the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/arm/mach-shmobile/board-ag5evm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index eff8a96..014b8e2 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -37,7 +37,6 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/sh_clk.h>
-#include <linux/dma-mapping.h>
 #include <video/sh_mobile_lcdc.h>
 #include <video/sh_mipi_dsi.h>
 #include <sound/sh_fsi.h>
-- 
1.7.8.3

