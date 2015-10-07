From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 07 Oct 2015 11:38:53 +0000
Subject: [PATCH v2 1/6] usb: host: xhci: add a platform-private pointer field
Message-Id: <1444217938-4668-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds an xhci->priv field for storing the of_device_id.data
pointer. This will simplify the code to match platform specific
variables (e.g. platform type and firmware name).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/host/xhci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 51093df..da227ba 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1653,6 +1653,9 @@ struct xhci_hcd {
 	u32			port_status_u0;
 /* Compliance Mode Timer Triggered every 2 seconds */
 #define COMP_MODE_RCVRY_MSECS 2000
+
+	/* Store of_device_id.data pointer as xhci-plat private data */
+	const void		*priv;
 };
 
 /* Platform specific overrides to generic XHCI hc_driver ops */
-- 
1.9.1

