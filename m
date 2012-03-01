From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 01 Mar 2012 14:45:16 +0000
Subject: [PATCH for v3.3] arm: sh_mobile: mackerel: Reserve DMA memory for the frame buffer
Message-Id: <1330613116-12957-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The default 2MB size of DMA coherent memory isn't enough for allocate
frame buffer memory.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

This fixes a v3.3 regression introduced in

commit 5917bfa4c0c529d7a93323671f2edec7e3d81c07
Author: Magnus Damm <damm@opensource.se>
Date:   Mon Jan 2 22:57:03 2012 -0500

    ARM: mach-shmobile: use standard 2MiB coherent DMA memory size

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 9b42fbd..2202987 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1402,6 +1402,10 @@ static struct map_desc mackerel_io_desc[] __initdata = {
 static void __init mackerel_map_io(void)
 {
 	iotable_init(mackerel_io_desc, ARRAY_SIZE(mackerel_io_desc));
+	/* DMA memory at 0xff200000 - 0xffdfffff. The default 2MB size isn't
+	 * enough to allocate the frame buffer memory.
+	 */
+	init_consistent_dma_size(12 << 20);
 
 	/* setup early devices and console here as well */
 	sh7372_add_early_devices();
-- 
Regards,

Laurent Pinchart

