From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 12 Oct 2015 11:37:42 +0000
Subject: [PATCH/POC v3 2/3] clk: shmobile: Add r8a7791 CPG Core Clock Definitions
Message-Id: <1444649863-17796-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1444649863-17796-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444649863-17796-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add the R-Car M2-W CPG Core Clocks that are currently needed by the DTS.
More will be added when needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is a Proof-of-Concept. Final definitions and values may be
different.

 include/dt-bindings/clock/r8a7791-cpg-mssr.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 include/dt-bindings/clock/r8a7791-cpg-mssr.h

diff --git a/include/dt-bindings/clock/r8a7791-cpg-mssr.h b/include/dt-bindings/clock/r8a7791-cpg-mssr.h
new file mode 100644
index 0000000000000000..a68093bc77f846fa
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7791-cpg-mssr.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright 2013 Ideas On Board SPRL
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_R8A7791_CPG_MSSR_H__
+#define __DT_BINDINGS_CLOCK_R8A7791_CPG_MSSR_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* r8a7791 CPG Core Clocks */
+#define R8A7791_CLK_Z			0
+#define R8A7791_CLK_M2			1
+#define R8A7791_CLK_ADSP		2
+#define R8A7791_CLK_SD0			3
+#define R8A7791_CLK_RCAN		4
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7791_CPG_MSSR_H__ */
-- 
1.9.1

