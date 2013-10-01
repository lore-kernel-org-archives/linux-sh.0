From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Oct 2013 08:12:38 +0000
Subject: [PATCH 05/10] ARM: shmobile: r8a7791 Arch timer device tree node
Message-Id: <20131001081238.4136.38665.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131001081143.4136.46925.sendpatchset@w520>
In-Reply-To: <20131001081143.4136.46925.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add r8a7791 arch timer device tree information.

This needs to be used together with r8a7791 support
code that ties in the R-Car Gen2 arch timer workarounds.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7791.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

--- 0005/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2013-10-01 16:30:54.000000000 +0900
@@ -39,6 +39,14 @@
 		interrupts = <1 9 0xf04>;
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <1 13 0xf08>,
+				<1 14 0xf08>,
+				<1 11 0xf08>,
+				<1 10 0xf08>;
+	};
+
 	irqc0: interrupt-controller@e61c0000 {
 		compatible = "renesas,irqc";
 		#interrupt-cells = <2>;
