From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jun 2011 06:08:32 +0000
Subject: [PATCH 3/3] sh: ecovec: add renesas_usbhs DMAEngine support
Message-Id: <w3pips762zj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 513cb1a..2659567 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -248,6 +248,10 @@ static struct renesas_usbhs_platform_info usbhs_info = {
 	.driver_param = {
 		.buswait_bwait		= 4,
 		.detection_delay	= 5,
+		.d0_tx_id = SHDMA_SLAVE_USB1D0_TX,
+		.d0_rx_id = SHDMA_SLAVE_USB1D0_RX,
+		.d1_tx_id = SHDMA_SLAVE_USB1D1_TX,
+		.d1_rx_id = SHDMA_SLAVE_USB1D1_RX,
 	},
 };
 
-- 
1.7.4.1

