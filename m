From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 13 Jun 2013 07:00:31 +0000
Subject: [PATCH 07/12] phy-rcar-usb: add platform data
Message-Id: <1371106836-25388-8-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1371106836-25388-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1371106836-25388-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Currently the driver hard-codes  USBPCTRL0 register to 0. It is wrong since this
register contains board-specific USB ports configuration and so its value should
be somehow passed via the platform data.  Add the global header file containing
'struct rcar_phy_platform_data' consisting of the various bit fields describing
USB ports' pin configuration.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/linux/platform_data/usb-rcar-phy.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 include/linux/platform_data/usb-rcar-phy.h

diff --git a/include/linux/platform_data/usb-rcar-phy.h b/include/linux/platform_data/usb-rcar-phy.h
new file mode 100644
index 0000000..c49f35a
--- /dev/null
+++ b/include/linux/platform_data/usb-rcar-phy.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013 Cogent Embedded, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __USB_RCAR_PHY_H
+#define __USB_RCAR_PHY_H
+
+#include <linux/types.h>
+
+struct rcar_phy_platform_data {
+	bool port1_func:1;	/* true: port 1 used by function, false: host */
+	unsigned penc1:1;	/* Output of the PENC1 pin in function mode */
+	struct {		/* Overcurrent pin control for ports 0..2 */
+		bool select_3_3v:1; /* true: USB_OVCn pin, false: OVCn pin */
+				/* Set to false on port 1 in function mode */
+		bool active_high:1; /* true: active  high, false: active low */
+				/* Set to true  on port 1 in function mode */
+	} ovc_pin[3];
+};
+
+#endif /* __USB_RCAR_PHY_H */
-- 
1.8.2.1

