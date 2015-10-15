From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 15 Oct 2015 00:34:13 +0000
Subject: [PATCH 2/7] ARM: shmobile: porter: enable SATA0
Message-Id: <efbb05c2c00231d73393390db2156046bda787de.1444868963.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1444868963.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1444868963.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Enable SATA0 device for the Porter board.

This patch is analogous to the commit 5a62ec57004f ("ARM: shmobile:
henninger: enable SATA0") as there are no differences between the boards
in this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 5bc4d23c1edb..7f46980ffd12 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -154,3 +154,7 @@
 	cd-gpios = <&gpio6 22 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
+
+&sata0 {
+	status = "okay";
+};
-- 
2.1.4

