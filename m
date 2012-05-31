From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 31 May 2012 00:24:28 +0000
Subject: [PATCH 9/9] ARM: mach-shmobile: armadillo800eva: add USB DMAEngine support
Message-Id: <87fwah8afa.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 57dc0d8..bb7ad67 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -283,6 +283,8 @@ static struct usbhsf_private usbhsf_private = {
 		.driver_param = {
 			.buswait_bwait		= 5,
 			.detection_delay	= 5,
+			.d0_rx_id	= SHDMA_SLAVE_USBHS_RX,
+			.d1_tx_id	= SHDMA_SLAVE_USBHS_TX,
 		},
 	}
 };
-- 
1.7.5.4

