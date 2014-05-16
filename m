From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 16 May 2014 04:42:58 +0000
Subject: [PATCH 1/4] ARM: shmobile: r8a7779: Add Maximum CPU Frequency to DTS
Message-Id: <1400215381-7027-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1400215381-7027-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1400215381-7027-1-git-send-email-horms+renesas@verge.net.au>
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
1.8.5.2

