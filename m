From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 21 Jan 2013 01:03:43 +0000
Subject: [PATCH] ARM: mach-shmobile: kzm9g: Add command line to reference dts
Message-Id: <1358730223-32703-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This seems to be recommended by arm-soc and is required
for earlyprintk with changes to the kzm9g defconfig that
have been sent upstream.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 588016e..06f52f9 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -18,6 +18,10 @@
 	model = "KZM-A9-GT";
 	compatible = "renesas,kzm9g-reference", "renesas,sh73a0";
 
+	chosen {
+		bootargs = "console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel earlyprintk=sh-sci.4,115200";
+	};
+
 	memory {
 		device_type = "memory";
 		reg = <0x41000000 0x1e800000>;
-- 
1.7.10.4

