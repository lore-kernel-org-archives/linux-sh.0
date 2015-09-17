From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 06:32:50 +0000
Subject: [PATCH v3 01/09] devicetree: bindings: Renesas APMU and SMP Enable method
Message-Id: <20150917063250.26016.99820.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917063240.26016.93772.sendpatchset@little-apple>
In-Reply-To: <20150917063240.26016.93772.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, keita.kobayashi.ym@renesas.com, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Add DT binding documentation for the APMU hardware and add "renesas,apmu"
to the list of enable methods for the ARM cpus.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V2:
 - s/Until/Unit/g - thanks Geert!

 Changes since V1:
 - None

 Documentation/devicetree/bindings/arm/cpus.txt           |    1 
 Documentation/devicetree/bindings/power/renesas,apmu.txt |   31 ++++++++++++++
 2 files changed, 32 insertions(+)

--- 0001/Documentation/devicetree/bindings/arm/cpus.txt
+++ work/Documentation/devicetree/bindings/arm/cpus.txt	2015-09-16 20:32:46.710513000 +0900
@@ -198,6 +198,7 @@ nodes to be present and contain the prop
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
+			    "renesas,apmu"
 			    "rockchip,rk3066-smp"
 			    "ste,dbx500-smp"
 
--- /dev/null
+++ work/Documentation/devicetree/bindings/power/renesas,apmu.txt	2015-09-16 20:42:09.000513000 +0900
@@ -0,0 +1,31 @@
+DT bindings for the Renesas Advanced Power Management Unit
+
+Renesas R-Car line of SoCs utilize one or more APMU hardware units
+for CPU core power domain control including SMP boot and CPU Hotplug.
+
+Required properties:
+
+- compatible: Should be "renesas,apmu-<soctype>", "renesas,apmu" as fallback.
+	      Examples with soctypes are:
+		- "renesas,apmu-r8a7790" (R-Car H2)
+		- "renesas,apmu-r8a7791" (R-Car M2-W)
+		- "renesas,apmu-r8a7792" (R-Car V2H)
+		- "renesas,apmu-r8a7793" (R-Car M2-N)
+		- "renesas,apmu-r8a7794" (R-Car E2)
+
+- reg: Base address and length of the I/O registers used by the APMU.
+
+- cpus: This node contains a list of CPU cores, which should match the order
+  of CPU cores used by the WUPCR and PSTR reigsters in the Advanced Power
+  Management Unit section of the device's datasheet.
+
+
+Example:
+
+This shows the r8a7791 APMU that can control CPU0 and CPU1.
+
+	apmu@e6152000 {
+		compatible = "renesas,apmu-r8a7791", "renesas,apmu";
+		reg = <0 0xe6152000 0 0x188>;
+		cpus = <&cpu0 &cpu1>;
+	};
