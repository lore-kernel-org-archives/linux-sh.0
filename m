From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 24 Dec 2013 04:44:30 +0000
Subject: [PATCH 3/3] ARM: shmobile: bockw: add USB Func DMAEngine support
Message-Id: <871u12g8nn.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 24b4161..684a529 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -168,6 +168,8 @@ static struct renesas_usbhs_platform_info usbhs_info __initdata = {
 	},
 	.driver_param = {
 		.buswait_bwait	= 4,
+		.d0_tx_id	= HPBDMA_SLAVE_USBFUNC_TX,
+		.d1_rx_id	= HPBDMA_SLAVE_USBFUNC_RX,
 	},
 };
 
-- 
1.7.9.5

