From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 19 Jul 2013 04:36:57 +0000
Subject: [PATCH 03/19] ARM: shmobile: r8a7778: Add pin control device to device tree
Message-Id: <2754bfad53d2a5eb2a824c0c8f65564cf0d7b57c.1374208262.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1374208262.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1374208262.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add a pfc node to the r8a7778 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 4743735..c8dbf14 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -32,4 +32,9 @@
 		reg = <0xfe438000 0x1000>,
 		      <0xfe430000 0x100>;
 	};
+
+	pfc: pfc@fffc0000 {
+		compatible = "renesas,pfc-r8a7778";
+		reg = <0xfffc000 0x118>;
+	};
 };
-- 
1.7.10.4

