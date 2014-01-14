From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 14 Jan 2014 17:05:41 +0000
Subject: [PATCH 2/2] ARM: dts: koelsch: Enable SATA0 in r8a7791-koelsch.dts
Message-Id: <1389719141-24419-3-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This enables SATA0 in Koelsch device tree.
SATA1 is not available on Koelsch since
its pinmux configuration is fixed to PCIe.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index d30527d..74f0985 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -122,3 +122,7 @@
 		renesas,function = "scif1";
 	};
 };
+
+&sata0 {
+	status = "okay";
+};
-- 
1.8.3.1

