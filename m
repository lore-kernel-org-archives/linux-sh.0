From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 26 Dec 2014 23:21:56 +0000
Subject: [PATCH v4 3/3] ARM: shmobile: henninger: add CAN0 DT support
Message-Id: <8071243.02TkQ9xbCu@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6830301.90YaDPuTpx@wasted.cogentembedded.com>
In-Reply-To: <6830301.90YaDPuTpx@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the Henninger board dependent part of the CAN0 device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 4:
- refreshed the patch.

Changes in version 3:
- changed "can0_data_a" to "can0_data", removed "can_clk_d" in the
  "renesas,groups" property;
- moved CAN0 node to go after all others;
- refreshed the patch.

 arch/arm/boot/dts/r8a7791-henninger.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -147,6 +147,11 @@
 		renesas,groups = "vin0_data8", "vin0_clk";
 		renesas,function = "vin0";
 	};
+
+	can0_pins: can0 {
+		renesas,groups = "can0_data";
+		renesas,function = "can0";
+	};
 };
 
 &scif0 {
@@ -321,3 +326,9 @@
 		};
 	};
 };
+
+&can0 {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};

