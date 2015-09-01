From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 01 Sep 2015 15:12:36 +0000
Subject: [PATCH 1/6] reset: Add renesas,rst DT bindings.
Message-Id: <1441120361-1232-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add DT bindings for the Renesas R-Car Reset Controller

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/reset/renesas,rst.txt      | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/renesas,rst.txt

diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
new file mode 100644
index 0000000000000000..aabf8dc6bce86ffc
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
@@ -0,0 +1,28 @@
+DT bindings for the Renesas R-Car Reset Controller
+
+The R-Car Reset Controller provides reset control, and implements the following
+functions:
+  - Register-based reset control for the various CPU cores,
+  - Latching of the levels on mode pins when PRESET# is negated,
+  - Mode monitoring register,
+  - Boot address registers for the various CPU cores.
+
+
+Required properties:
+  - compatible: Should be "renesas,rst-<soctype>", and "syscon".
+		Examples with soctypes are:
+		  - "renesas,rst-r8a7790" (R-Car H2)
+		  - "renesas,rst-r8a7791" (R-Car M2-W)
+		  - "renesas,rst-r8a7792" (R-Car V2H
+		  - "renesas,rst-r8a7793" (R-Car M2-N)
+		  - "renesas,rst-r8a7794" (R-Car E2)
+		  - "renesas,rst-r8a7795" (R-Car H3)
+  - reg: Address start and address range for the device.
+
+
+Example:
+
+	rst: reset-controller@e6160000 {
+		compatible = "renesas,rst-r8a7795", "syscon";
+		reg = <0 0xe6160000 0 0x0200>;
+	};
-- 
1.9.1

