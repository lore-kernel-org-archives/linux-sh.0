From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Apr 2012 09:10:05 +0000
Subject: [PATCH 8/8] ARM: mach-shmobile: r8a7740: reserve DMA memory for the frame buffer
Message-Id: <87zka1ebrq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The default 2MB size of DMA coherent memory isn't enough for allocate
frame buffer memory.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/setup-r8a7740.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 14edb5c..a3951c1 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -60,6 +61,12 @@ static struct map_desc r8a7740_io_desc[] __initdata = {
 void __init r8a7740_map_io(void)
 {
 	iotable_init(r8a7740_io_desc, ARRAY_SIZE(r8a7740_io_desc));
+
+	/*
+	 * DMA memory at 0xff200000 - 0xffdfffff. The default 2MB size isn't
+	 * enough to allocate the frame buffer memory.
+	 */
+	init_consistent_dma_size(12 << 20);
 }
 
 /* SCIFA0 */
-- 
1.7.5.4

