From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Nov 2013 08:06:40 +0000
Subject: [PATCH 03/03] pinctrl: sh-pfc: r7s72100 SCIF2 port4, 6 and 8 support
Message-Id: <20131127080640.18384.21957.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131127080606.18384.45103.sendpatchset@w520>
In-Reply-To: <20131127080606.18384.45103.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linus.walleij@linaro.org, wsa@the-dreams.de, horms@verge.net.au, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

Add the remaining SCIF2 pins using the recently introduced macro.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/pinctrl/sh-pfc/pfc-r7s72100.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- 0008/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
+++ work/drivers/pinctrl/sh-pfc/pfc-r7s72100.c	2013-11-27 14:33:17.000000000 +0900
@@ -127,7 +127,17 @@ static const unsigned int __RZ_STR(pfx,
 	fn(scif2, txd, 3, 0, 6)		\
 	fn(scif2, txd, 3, 1, 4)		\
 	fn(scif2, rxd, 3, 2, 4)		\
-	fn(scif2, clk, 3, 0, 4)
+	fn(scif2, clk, 3, 0, 4)		\
+	fn(scif2, clk, 4, 1, 5)		\
+	fn(scif2, txd, 4, 2, 5)		\
+	fn(scif2, rxd, 4, 3, 5)		\
+	fn(scif2, txd, 4, 14, 7)	\
+	fn(scif2, rxd, 4, 15, 7)	\
+	fn(scif2, txd, 6, 2, 7)		\
+	fn(scif2, rxd, 6, 3, 7)		\
+	fn(scif2, clk, 8, 3, 7)		\
+	fn(scif2, txd, 8, 6, 7)		\
+	fn(scif2, rxd, 8, 4, 7)
 
 SCIF2(RZ_PIN_AND_MUX)
 
