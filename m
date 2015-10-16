From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 16 Oct 2015 12:49:17 +0000
Subject: [PATCH v4 2/5] [RFC] clk: shmobile: Add r8a7795 CPG Core Clock Definitions
Message-Id: <1444999760-15750-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add all R-Car H3 CPG Core Clock Outputs defined in the datasheet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Add all clocks instead of just the ones used by the current DTS.

v3:
  - New.
---
 include/dt-bindings/clock/r8a7795-cpg-mssr.h | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 include/dt-bindings/clock/r8a7795-cpg-mssr.h

diff --git a/include/dt-bindings/clock/r8a7795-cpg-mssr.h b/include/dt-bindings/clock/r8a7795-cpg-mssr.h
new file mode 100644
index 0000000000000000..e864aae0a2561c4b
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7795-cpg-mssr.h
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __DT_BINDINGS_CLOCK_R8A7795_CPG_MSSR_H__
+#define __DT_BINDINGS_CLOCK_R8A7795_CPG_MSSR_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* r8a7795 CPG Core Clocks */
+#define R8A7795_CLK_Z			0
+#define R8A7795_CLK_Z2			1
+#define R8A7795_CLK_ZR			2
+#define R8A7795_CLK_ZG			3
+#define R8A7795_CLK_ZTR			4
+#define R8A7795_CLK_ZTRD2		5
+#define R8A7795_CLK_ZT			6
+#define R8A7795_CLK_ZX			7
+#define R8A7795_CLK_S0D1		8
+#define R8A7795_CLK_S0D4		9
+#define R8A7795_CLK_S1D1		10
+#define R8A7795_CLK_S1D2		11
+#define R8A7795_CLK_S1D4		12
+#define R8A7795_CLK_S2D1		13
+#define R8A7795_CLK_S2D2		14
+#define R8A7795_CLK_S2D4		15
+#define R8A7795_CLK_S3D1		16
+#define R8A7795_CLK_S3D2		17
+#define R8A7795_CLK_S3D4		18
+#define R8A7795_CLK_LB			19
+#define R8A7795_CLK_CL			20
+#define R8A7795_CLK_ZB3			21
+#define R8A7795_CLK_ZB3D2		22
+#define R8A7795_CLK_CR			23
+#define R8A7795_CLK_CRD2		24
+#define R8A7795_CLK_SD0H		25
+#define R8A7795_CLK_SD0			26
+#define R8A7795_CLK_SD1H		27
+#define R8A7795_CLK_SD1			28
+#define R8A7795_CLK_SD2H		29
+#define R8A7795_CLK_SD2			30
+#define R8A7795_CLK_SD3H		31
+#define R8A7795_CLK_SD3			32
+#define R8A7795_CLK_SSP2		33
+#define R8A7795_CLK_SSP1		34
+#define R8A7795_CLK_SSPRS		35
+#define R8A7795_CLK_RPC			36
+#define R8A7795_CLK_RPCD2		37
+#define R8A7795_CLK_MSO			38
+#define R8A7795_CLK_CANFD		39
+#define R8A7795_CLK_HDMI		40
+#define R8A7795_CLK_CSI0		41
+#define R8A7795_CLK_CSIREF		42
+#define R8A7795_CLK_CP			43
+#define R8A7795_CLK_CPEX		44
+#define R8A7795_CLK_R			45
+#define R8A7795_CLK_OSC			46
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7795_CPG_MSSR_H__ */
-- 
1.9.1

