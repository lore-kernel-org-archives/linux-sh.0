From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Feb 2014 06:20:50 +0000
Subject: [PATCH 15/17] ARM: shmobile: lager: Enable SATA1 in r8a7790-lager.dts
Message-Id: <c6181b9f06b0821e8d34e47174e044801f03edce.1391665761.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1391665761.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1391665761.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

This enables SATA1 in Lager device tree.
SATA0 is not available on Lager since its
pinmux is fixed to USB3.0.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 57569cb..1081c5e 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -91,3 +91,7 @@
 	non-removable;
 	status = "okay";
 };
+
+&sata1 {
+	status = "okay";
+};
-- 
1.8.5.2

