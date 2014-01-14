From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 14 Jan 2014 17:05:31 +0000
Subject: [PATCH 2/2] ARM: dts: lager: Enable SATA1 in r8a7790-lager.dts
Message-Id: <1389719131-24376-3-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This enables SATA1 in Lager device tree.
SATA0 is not available on Lager since its
pinmux is fixed to USB3.0.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
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
1.8.3.1

