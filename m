From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 04 Apr 2013 23:07:50 +0000
Subject: [PATCH 6/8] rcar-phy: add platform data
Message-Id: <201304050307.51360.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Currently the driver hard-codes USBPCTRL0 register to 0.  It is wrong since this
register contains board-specific USB ports configuration and so its value should
be somehow passed via the platform data.  Add <linux/usb/rcar-phy.h> file with
the USBPCTRL0 bit #define's and 'struct rcar_phy_platform_data' containing the
value to be set by the driver to that register.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 include/linux/usb/rcar-phy.h |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

Index: renesas/include/linux/usb/rcar-phy.h
=================================--- /dev/null
+++ renesas/include/linux/usb/rcar-phy.h
@@ -0,0 +1,39 @@
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
+#include <linux/bitops.h>
+
+/* USBPCTRL0 register bits */
+#define USBPCTRL0_OVC2	BIT(10)	/* Switches the OVC input pin for port 2: */
+				/* 1: USB_OVC2, 0: OVC2			*/
+#define USBPCTRL0_OVC1_VBUS1 BIT(9) /* Switches the OVC input pin for port 1: */
+				/* 1: USB_OVC1, 0: OVC1/VBUS1		*/
+#define USBPCTRL0_OVC0	BIT(8)	/* Switches the OVC input pin for port 0: */
+				/* 1: USB_OVC0 pin, 0: OVC0		*/
+#define USBPCTRL0_OVC2_ACT BIT(6) /* Host mode: OVC2 polarity:		*/
+				/* 1: active-high, 0: active-low	*/
+				/* Function mode: be sure to set to 1	*/
+#define USBPCTRL0_PENC	BIT(4)	/* Function mode: output level of PENC1 pin: */
+				/* 1: high, 0: low			*/
+#define USBPCTRL0_OVC0_ACT BIT(3) /* Host mode: OVC0 polarity:		*/
+				/* 1: active-high, 0: active-low	*/
+#define USBPCTRL0_OVC1_ACT BIT(1) /* Host mode: OVC1 polarity:		*/
+				/* 1: active-high, 0: active-low	*/
+				/* Function mode: be sure to set to 1	*/
+#define USBPCTRL0_PORT1	BIT(0)	/* Selects port 1 mode:			*/
+				/* 1: function, 0: host			*/
+
+struct rcar_phy_platform_data {
+	u32 usbpctrl0;		/* USBPCTRL0 register value */
+};
+
+#endif /* __RCAR_PHY_H */
