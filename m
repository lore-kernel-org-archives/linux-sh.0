From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 07 Oct 2015 11:38:55 +0000
Subject: [PATCH v2 3/6] usb: host: xhci-plat: add firmware_name in xhci_plat_priv
Message-Id: <1444217938-4668-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds a member "firmware_name" in struct xhci_plat_priv
to simplify the code to match specific firmware name.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/host/xhci-plat.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 4479869..20b32a7 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -20,6 +20,7 @@ enum xhci_plat_type {
 
 struct xhci_plat_priv {
 	enum xhci_plat_type type;
+	const char *firmware_name;
 };
 
 #define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
-- 
1.9.1

