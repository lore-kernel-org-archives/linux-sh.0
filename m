From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 23 Apr 2013 15:33:00 +0000
Subject: [PATCH v6 7/9] rcar-phy: add platform data
Message-Id: <201304231933.00604.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Currently the driver hard-codes USBPCTRL0 register to 0.  It is wrong since this
register contains board-specific USB ports configuration and so its value should
be somehow passed via the platform data.  Add <linux/usb/rcar-phy.h> file with
the 'struct rcar_phy_platform_data' containing various bit fields describing
USB pin configuration.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>

---
Changes since version 3:
- moved USBPCTRL0 register bit #define's to patch #9;
- replaced USBPCTRL0 register value in the platform data structure by a set of
  bit fields describing the configuration of the board, rewrote changelog;

Changes since version 2:
- added #include <linux/types.h>;
- added ACKs from Simon Horman and Kuninori Morimoto.

 include/linux/usb/rcar-phy.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

Index: renesas/include/linux/usb/rcar-phy.h
=================================--- /dev/null
+++ renesas/include/linux/usb/rcar-phy.h
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
+#ifndef __RCAR_PHY_H
+#define __RCAR_PHY_H
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
+#endif /* __RCAR_PHY_H */
