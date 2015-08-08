From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 08 Aug 2015 20:33:18 +0000
Subject: [PATCH 01/10] dt-bindings: add header for generic I2C flags in bindings
Message-Id: <1439066007-13951-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Andrey Danin <danindrey@mail.ru>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested-by: Andrey Danin <danindrey@mail.ru>
Acked-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/dt-bindings/i2c/i2c.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/i2c/i2c.h

diff --git a/include/dt-bindings/i2c/i2c.h b/include/dt-bindings/i2c/i2c.h
new file mode 100644
index 00000000000000..1d5da81d90f144
--- /dev/null
+++ b/include/dt-bindings/i2c/i2c.h
@@ -0,0 +1,18 @@
+/*
+ * This header provides constants for I2C bindings
+ *
+ * Copyright (C) 2015 by Sang Engineering
+ * Copyright (C) 2015 by Renesas Electronics Corporation
+ *
+ * Wolfram Sang <wsa@sang-engineering.com>
+ *
+ * GPLv2 only
+ */
+
+#ifndef _DT_BINDINGS_I2C_I2C_H
+#define _DT_BINDINGS_I2C_I2C_H
+
+#define I2C_TEN_BIT_ADDRESS	(1 << 31)
+#define I2C_OWN_SLAVE_ADDRESS	(1 << 30)
+
+#endif
-- 
2.1.4

