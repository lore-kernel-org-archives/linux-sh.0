From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Jun 2014 02:26:28 +0000
Subject: [PATCH 15/24] ARM: shmobile: r8a7779: Add Maximum CPU Frequency to DTS
Message-Id: <6b060f93fe7dedbeb067feacbc8c4780c59f5df4.1403487423.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add 1GHz to the r8a7779 DTS to describe the maximum CPU frequency.

Based on work by Magnus dam for the r8a7740 SoC.

Cc: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index bdaaadc..038c16a 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -26,21 +26,25 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clock-frequency = <1000000000>;
 		};
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clock-frequency = <1000000000>;
 		};
 		cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
+			clock-frequency = <1000000000>;
 		};
 		cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
+			clock-frequency = <1000000000>;
 		};
 	};
 
-- 
2.0.0.rc2

