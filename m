From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 07 Jul 2015 14:10:10 +0000
Subject: [PATCH/RFC 04/11] ARM: shmobile: r8a7793 dtsi: Add device node for RST module
Message-Id: <1436278217-20522-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1436278217-20522-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436278217-20522-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a device node for the RST module, which provides reset control.
Declare it to be a system controller (syscon), so other device nodes can
refer to its registers.

TODO Add DT binding documentation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7793.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 420fafda442b8a0e..fbb1aa3740e2b55e 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -394,6 +394,11 @@
 		};
 	};
 
+	rst: reset-controller@e616000 {
+		compatible = "renesas,rst-r8a7793", "syscon";
+		reg = <0 0xe6160000 0 0x0100>;
+	};
+
 	sysc: system-controller@e6180000 {
 		compatible = "renesas,sysc-r8a7793", "renesas,sysc-rcar";
 		reg = <0 0xe6180000 0 0x0200>;
-- 
1.9.1

