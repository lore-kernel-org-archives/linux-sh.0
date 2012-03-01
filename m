From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 01 Mar 2012 13:57:11 +0000
Subject: [PATCH for v3.3] arm: sh_mobile: ag5evm: Fix compilation by including linux/videodev2.h
Message-Id: <1330610231-6228-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The board file uses a 4CC defined in linux/videodev2.h. Include the
header to fix

arch/arm/mach-shmobile/board-ag5evm.c:262: error: 'V4L2_PIX_FMT_RGB565'
undeclared here (not in a function)

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

This is a v3.3 regression.

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index eff8a96..0db1685 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -38,6 +38,7 @@
 #include <linux/mfd/tmio.h>
 #include <linux/sh_clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/videodev2.h>
 #include <video/sh_mobile_lcdc.h>
 #include <video/sh_mipi_dsi.h>
 #include <sound/sh_fsi.h>
-- 
Regards,

Laurent Pinchart

