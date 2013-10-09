From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 09 Oct 2013 06:50:29 +0000
Subject: [PATCH 13/13] ARM: shmobile: bockw: fixup ether node naming
Message-Id: <73c79afa61cdee2553461ee714bb4716372bdd55.1381298964.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1381298964.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1381298964.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

According to the ePAPR spec,
the node name should be "ethernet", not "lan0".

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 4425fd2..969e386 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -39,7 +39,7 @@
 		regulator-always-on;
 	};
 
-	lan0@18300000 {
+	ethernet@18300000 {
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x18300000 0x1000>;
 
-- 
1.8.4

