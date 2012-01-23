From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 23 Jan 2012 05:08:55 +0000
Subject: [PATCH] ARM: mach-shmobile: ag5: fixup compile break
Message-Id: <8739b7huos.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixup below compile break

  CC      arch/arm/mach-shmobile/board-ag5evm.o
${LINUX}/arch/arm/mach-shmobile/board-ag5evm.c:274:\
   error: 'V4L2_PIX_FMT_RGB565' undeclared here (not in a function)

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 9952f0a..344698c 100644
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
1.7.5.4

