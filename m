From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 17 Jun 2011 08:21:21 +0000
Subject: [RFC][PATCH 6/6 v3] ARM: mach-shmobile: mackerel: Add USB-DMA ID
Message-Id: <w3pzklgoola.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch use channel0 as Tx, and channel1 as Rx

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

- no change

 arch/arm/mach-shmobile/board-mackerel.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 3802f2a..ff3c1a0 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -641,6 +641,8 @@ static struct usbhs_private usbhs0_private = {
 		},
 		.driver_param = {
 			.buswait_bwait	= 4,
+			.d0_tx_id	= SHDMA_SLAVE_USB0_TX,
+			.d1_rx_id	= SHDMA_SLAVE_USB0_RX,
 		},
 	},
 };
@@ -810,6 +812,8 @@ static struct usbhs_private usbhs1_private = {
 			.buswait_bwait	= 4,
 			.pipe_type	= usbhs1_pipe_cfg,
 			.pipe_size	= ARRAY_SIZE(usbhs1_pipe_cfg),
+			.d0_tx_id	= SHDMA_SLAVE_USB1_TX,
+			.d1_rx_id	= SHDMA_SLAVE_USB1_RX,
 		},
 	},
 };
-- 
1.7.4.1

