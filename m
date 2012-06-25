From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:37:47 +0000
Subject: [PATCH 6/6] ARM: shmobile: armadillo800eva: enable DMAEngine on USB
Message-Id: <87txxzk77s.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It is possible to reduce CPU load if USB used DMAEngine.
This patch enabled it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index f7f9ac5..3066fa7 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -297,6 +297,8 @@ static struct usbhsf_private usbhsf_private = {
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

