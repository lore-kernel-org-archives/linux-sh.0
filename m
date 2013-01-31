From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 31 Jan 2013 06:26:07 +0000
Subject: [PATCH 2/4] ARM: mach-shmobile: emev2:  Add reg and device_type properties to cpus
Message-Id: <1359613569-26981-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1359613569-26981-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1359613569-26981-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index eb504a6..c8a8c08 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -15,11 +15,18 @@
 	interrupt-parent = <&gic>;
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu@0 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			reg = <0>;
 		};
 		cpu@1 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			reg = <1>;
 		};
 	};
 
-- 
1.7.10.4

