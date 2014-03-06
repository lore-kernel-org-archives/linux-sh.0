From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Mar 2014 02:41:38 +0000
Subject: [PATCH] ARM: shmobile: r8a7790: Update CPU frequency to 1.5Ghz in DT
Message-Id: <1394073698-7266-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Update CPU nodes to use 1.5Ghz instead of 1.3Ghz as their frequency.
1.5Ghz is consistent with the documentation.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
This patch is based on the renesas-devel-v3.14-rc4-20140227 tag
of my renesas tree.
---
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index b007f9e..7bc027a 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -37,14 +37,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
-			clock-frequency = <1300000000>;
+			clock-frequency = <1500000000>;
 		};
 
 		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <1>;
-			clock-frequency = <1300000000>;
+			clock-frequency = <1500000000>;
 		};
 	};
 
-- 
1.8.5.2

