From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 05 Mar 2015 01:58:09 +0000
Subject: [PATCH 09/16] ARM: shmobile: bockw dts: Move Ethernet node to BSC
Message-Id: <7d316faa193fed16079b35c57e0500be3cc6f0a5.1425518337.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1425518337.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1425518337.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Move the Ethernet node to the new BSC node, as its connected to the
Bus State Controller.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
[horms: dropped compat string changes as they seem out of scope]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 96cfcdc..274a1b6f 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -45,7 +45,9 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+};
 
+&bsc {
 	ethernet@18300000 {
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x18300000 0x1000>;
-- 
2.1.4

