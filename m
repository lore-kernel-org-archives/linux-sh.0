From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 10 Nov 2014 11:02:47 +0000
Subject: [PATCH 4/4] usb: renesas_usbhs: expand USB-DMAC channels for R-Car Gen2
Message-Id: <1415617367-3828-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch expands USB-DMAC channels for R-Car Gen2 SoCs. The SoCs
have 4 channels. If d{2,3}_{t,x}x_id are not set, this driver never
uses the expanded USB-DMAC channels.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/common.h |    4 ++++
 drivers/usb/renesas_usbhs/fifo.c   |    2 ++
 drivers/usb/renesas_usbhs/fifo.h   |    2 +-
 include/linux/usb/renesas_usbhs.h  |    4 ++++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/common.h b/drivers/usb/renesas_usbhs/common.h
index c45667f..0427cdd 100644
--- a/drivers/usb/renesas_usbhs/common.h
+++ b/drivers/usb/renesas_usbhs/common.h
@@ -102,6 +102,10 @@ struct usbhs_priv;
 #define DEVADD8		0x00E0
 #define DEVADD9		0x00E2
 #define DEVADDA		0x00E4
+#define D2FIFOSEL	0x00F0	/* for R-Car Gen2 */
+#define D2FIFOCTR	0x00F2	/* for R-Car Gen2 */
+#define D3FIFOSEL	0x00F4	/* for R-Car Gen2 */
+#define D3FIFOCTR	0x00F6	/* for R-Car Gen2 */
 
 /* SYSCFG */
 #define SCKE	(1 << 10)	/* USB Module Clock Enable */
diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index bc9a050..f46271c 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -1234,6 +1234,8 @@ int usbhs_fifo_probe(struct usbhs_priv *priv)
 	/* DFIFO */
 	USBHS_DFIFO_INIT(priv, fifo, 0);
 	USBHS_DFIFO_INIT(priv, fifo, 1);
+	USBHS_DFIFO_INIT_NO_PORT(priv, fifo, 2);
+	USBHS_DFIFO_INIT_NO_PORT(priv, fifo, 3);
 
 	return 0;
 }
diff --git a/drivers/usb/renesas_usbhs/fifo.h b/drivers/usb/renesas_usbhs/fifo.h
index 899729a..f07037c1 100644
--- a/drivers/usb/renesas_usbhs/fifo.h
+++ b/drivers/usb/renesas_usbhs/fifo.h
@@ -38,7 +38,7 @@ struct usbhs_fifo {
 	struct sh_dmae_slave	rx_slave;
 };
 
-#define USBHS_MAX_NUM_DFIFO	2
+#define USBHS_MAX_NUM_DFIFO	4
 struct usbhs_fifo_info {
 	struct usbhs_fifo cfifo;
 	struct usbhs_fifo dfifo[USBHS_MAX_NUM_DFIFO];
diff --git a/include/linux/usb/renesas_usbhs.h b/include/linux/usb/renesas_usbhs.h
index d5952bb..9fd9e48 100644
--- a/include/linux/usb/renesas_usbhs.h
+++ b/include/linux/usb/renesas_usbhs.h
@@ -145,6 +145,10 @@ struct renesas_usbhs_driver_param {
 	int d0_rx_id;
 	int d1_tx_id;
 	int d1_rx_id;
+	int d2_tx_id;
+	int d2_rx_id;
+	int d3_tx_id;
+	int d3_rx_id;
 
 	/*
 	 * option:
-- 
1.7.9.5

