From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 May 2014 13:17:32 +0000
Subject: [PATCH v2 04/05] staging: board: Initial board staging support
Message-Id: <20140529131732.2329.50630.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140529131650.2329.3197.sendpatchset@w520>
In-Reply-To: <20140529131650.2329.3197.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devel@driverdev.osuosl.org, linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, olof@lixom.net, Magnus Damm <magnus.damm@gmail.com>, dan.carpenter@oracle.com

From: Magnus Damm <damm+renesas@opensource.se>

Add staging board base support to allow continuous upstream
in-tree development and integration of platform devices.

Helps developers integrate devices as platform devices for
device drivers that only provide platform device bindings.
This in turn allows for incremental development of both
hardware feature support and DT binding work in parallel.

Two separate pieces of board staging functionality is
provided to ease per-board staging board support:
 - The board_staging() macro allows easy per-board callbacks
 - The board_staging_dt_node_available() provides DT node checking

Tested on the KZM9D board with the emxx_udc staging driver.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - New broken out staging board base support
 - Added the function board_staging_dt_node_available()
 - Added a TODO file

 drivers/staging/Kconfig        |    2 +
 drivers/staging/Makefile       |    1 
 drivers/staging/board/Kconfig  |    7 ++++++
 drivers/staging/board/Makefile |    1 
 drivers/staging/board/TODO     |    2 +
 drivers/staging/board/board.c  |   41 ++++++++++++++++++++++++++++++++++++++++
 drivers/staging/board/board.h  |   20 +++++++++++++++++++
 7 files changed, 74 insertions(+)

--- 0008/drivers/staging/Kconfig
+++ work/drivers/staging/Kconfig	2014-05-29 21:40:40.000000000 +0900
@@ -112,6 +112,8 @@ source "drivers/staging/media/Kconfig"
 
 source "drivers/staging/android/Kconfig"
 
+source "drivers/staging/board/Kconfig"
+
 source "drivers/staging/ozwpan/Kconfig"
 
 source "drivers/staging/gdm72xx/Kconfig"
--- 0008/drivers/staging/Makefile
+++ work/drivers/staging/Makefile	2014-05-29 21:40:40.000000000 +0900
@@ -49,6 +49,7 @@ obj-$(CONFIG_TOUCHSCREEN_CLEARPAD_TM1217
 obj-$(CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4)	+= ste_rmi4/
 obj-$(CONFIG_MFD_NVEC)		+= nvec/
 obj-$(CONFIG_ANDROID)		+= android/
+obj-$(CONFIG_STAGING_BOARD)	+= board/
 obj-$(CONFIG_USB_WPAN_HCD)	+= ozwpan/
 obj-$(CONFIG_WIMAX_GDM72XX)	+= gdm72xx/
 obj-$(CONFIG_LTE_GDM724X)	+= gdm724x/
--- /dev/null
+++ work/drivers/staging/board/Kconfig	2014-05-29 21:40:41.000000000 +0900
@@ -0,0 +1,7 @@
+config STAGING_BOARD
+	boolean "Staging Board Support"
+	help
+	  Select to enable per-board staging support code.
+
+	  If in doubt, say N here.
+
--- /dev/null
+++ work/drivers/staging/board/Makefile	2014-05-29 21:40:41.000000000 +0900
@@ -0,0 +1 @@
+obj-y	:= board.o
--- /dev/null
+++ work/drivers/staging/board/TODO	2014-05-29 21:40:41.000000000 +0900
@@ -0,0 +1,2 @@
+* replace platform device code with DT nodes once the driver supports DT
+* remove staging board code when no more platform devices are needed
--- /dev/null
+++ work/drivers/staging/board/board.c	2014-05-29 21:46:32.000000000 +0900
@@ -0,0 +1,41 @@
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include "board.h"
+
+static bool find_by_address(u64 base_address)
+{
+	struct device_node *dn = of_find_all_nodes(NULL);
+	struct resource res;
+
+	while (dn) {
+		if (of_can_translate_address(dn)
+		    && !of_address_to_resource(dn, 0, &res)) {
+			if (res.start = base_address) {
+				of_node_put(dn);
+				return true;
+			}
+		}
+		dn = of_find_all_nodes(dn);
+	}
+
+	return false;
+}
+
+bool __init board_staging_dt_node_available(const struct resource *resource,
+					    unsigned int num_resources)
+{
+	unsigned int i;
+
+	for (i = 0; i < num_resources; i++) {
+		const struct resource *r = resource + i;
+
+		if (resource_type(r) = IORESOURCE_MEM)
+			if (find_by_address(r->start))
+				return true; /* DT node available */
+	}
+
+	return false; /* Nothing found */
+}
--- /dev/null
+++ work/drivers/staging/board/board.h	2014-05-29 21:40:41.000000000 +0900
@@ -0,0 +1,20 @@
+#ifndef __BOARD_H__
+#define __BOARD_H__
+#include <linux/init.h>
+#include <linux/of.h>
+
+bool board_staging_dt_node_available(const struct resource *resource,
+				     unsigned int num_resources);
+
+#define board_staging(str, fn)			\
+static int __init runtime_board_check(void)	\
+{						\
+	if (of_machine_is_compatible(str))	\
+		fn();				\
+						\
+	return 0;				\
+}						\
+						\
+late_initcall(runtime_board_check)
+
+#endif /* __BOARD_H__ */
