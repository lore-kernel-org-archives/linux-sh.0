From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 16 May 2013 06:05:16 +0000
Subject: [PATCH] ARM: shmobile: Remove unused r8a7790 GIC CPU interface DT bits
Message-Id: <20130516060516.29259.42682.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130516060355.29253.21426.sendpatchset@w520>
In-Reply-To: <20130516060355.29253.21426.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Remove unused GIC CPU interface DT bits for r8a7790.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7790.dtsi |    6 ------
 1 file changed, 6 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-05-15 14:41:08.000000000 +0900
@@ -36,12 +36,6 @@
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
-
-		gic-cpuif@4 {
-			compatible = "arm,gic-cpuif";
-			cpuif-id = <4>;
-			cpu = <&cpu0>;
-		};
 	};
 
 	timer {
