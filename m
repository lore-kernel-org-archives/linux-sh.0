From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 24 Jul 2013 03:42:40 +0000
Subject: [PATCH] ARM: shmobile: emev2: add PMU information to emev2.dtsi
Message-Id: <20130724034240.30596.52917.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: koba@kmckk.co.jp, Magnus Damm <magnus.damm@gmail.com>, horms@verge.net.au, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add PMU information to emev2.dtsi. With this
included KZM9D DT reference may use the PMU.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/emev2.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0009/arch/arm/boot/dts/emev2.dtsi
+++ work/arch/arm/boot/dts/emev2.dtsi	2013-07-02 17:32:45.000000000 +0900
@@ -46,6 +46,12 @@
 		      <0xe0020000 0x0100>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <0 120 4>,
+			     <0 121 4>;
+	};
+
 	sti@e0180000 {
 		compatible = "renesas,em-sti";
 		reg = <0xe0180000 0x54>;
