From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 27 Oct 2015 01:18:25 +0000
Subject: [PATCH v4 2/7] usb: host: xhci: add a platform-private field
Message-Id: <1445908710-5812-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds an xhci->priv field for private use by
XHCI platform drivers. Until now none of the platform drivers
has used this private space.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/host/xhci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index be9048e..05f4a73 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1657,6 +1657,9 @@ struct xhci_hcd {
 	u32			port_status_u0;
 /* Compliance Mode Timer Triggered every 2 seconds */
 #define COMP_MODE_RCVRY_MSECS 2000
+
+	/* platform-specific data -- must come last */
+	unsigned long		priv[0] __aligned(sizeof(s64));
 };
 
 /* Platform specific overrides to generic XHCI hc_driver ops */
-- 
1.9.1

