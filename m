From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 13 Mar 2012 01:55:23 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: Reserve DMA memory for the frame buffer
Message-Id: <87r4wxi7sn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ap4evb board needs the same fix as
1740d3448012475f6b63172631c60cbcd1994a81
(ARM: mach-shmobile: mackerel: Reserve DMA memory for the frame buffer)

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index eeb4d96..3b17d13 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1205,6 +1205,10 @@ static struct map_desc ap4evb_io_desc[] __initdata = {
 static void __init ap4evb_map_io(void)
 {
 	iotable_init(ap4evb_io_desc, ARRAY_SIZE(ap4evb_io_desc));
+	/* DMA memory at 0xff200000 - 0xffdfffff. The default 2MB size isn't
+	 * enough to allocate the frame buffer memory.
+	 */
+	init_consistent_dma_size(12 << 20);
 
 	/* setup early devices and console here as well */
 	sh7372_add_early_devices();
-- 
1.7.5.4

