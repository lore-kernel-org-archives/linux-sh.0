From: Bastian Hecht <hechtb@googlemail.com>
Date: Thu, 26 Apr 2012 14:01:02 +0000
Subject: [RFC DT style 4/4] docs/mtd/nand/sh_flctl: Initial device tree binding specification
Message-Id: <1335448862-5201-5-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add documentation for setting up the flctl flash controller via device
tree description.
---
 .../devicetree/bindings/mtd/rmobile-flctl.txt      |   58 ++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/rmobile-flctl.txt

diff --git a/Documentation/devicetree/bindings/mtd/rmobile-flctl.txt b/Documentation/devicetree/bindings/mtd/rmobile-flctl.txt
new file mode 100644
index 0000000..ee0011b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/rmobile-flctl.txt
@@ -0,0 +1,58 @@
+Renesas RMobile Flash controller FLCTL.
+
+Controller properties:
+- compatible:	"rmobile,flctl".
+- reg:		I/O map base address.
+- ext-bus-con:	"SHBUSSEL - External Bus Connection". Set this flag when the
+		I/O is multiplexed with the external bus through BSC.
+- release-bus:	"HOLDEN - Bus occupancy enable". Set this flag if the bus shall
+		be released when the FIFO becomes empty or full.
+- clk-scheme:	The bit fields differ between different hardware releases.
+		Please consult the datasheet and select a proper u32 that
+		is OR'ed to FLCMNCR.
+
+For each NAND chip connected to the FLCTL add a subnode compliant to mtd/nand
+bindings.
+
+- nand-ecc-mode: See nand.txt. Hardware and software ECC modes are supported.
+- nand-bus-width: See nand.txt. 16 and 8 bit widths are supported.
+- flctl-snand:	"SNAND - Large capacity NAND Flash Memory Select". Set this for
+		2k page size NAND chips or for AG-AND-type chips with a capacity
+		of 1Gb or more.
+
+These options may follow partition definitions, see partition.txt.
+
+Examples:
+
+flctl@e6000000 {
+	compatible = "rmobile,flctl";
+	reg = <0xe6000000 0x100>;
+
+	ext-bus-con;
+	use-holden;
+	clk-scheme = <0x20200>; /* Low 12, high 4 cycles */
+
+	nand@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		nand-ecc-mode = "hw";
+		nand-bus-width = <16>;
+		nand-large-page;
+
+		system@0 {
+			label = "system";
+			reg = <0x0 0x8000000>;
+		};
+
+		userdata@8000000 {
+			label = "userdata";
+			reg = <0x8000000 0x10000000>;
+		};
+
+		cache@18000000 {
+			label = "cache";
+			reg = <0x18000000 0x8000000>;
+		};
+	};
+};
-- 
1.7.5.4

