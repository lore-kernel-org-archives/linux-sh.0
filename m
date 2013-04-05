From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 05 Apr 2013 03:04:30 +0000
Subject: [PATCH 2/2] ARM: shmobile: bockw: enable network settings on bootargs
Message-Id: <1365131070-13142-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365131070-13142-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1365131070-13142-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

"ip" and "root" settings are useful for development

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 735c964..0076b1e 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -22,7 +22,7 @@
 	compatible = "renesas,bockw", "renesas,r8a7778";
 
 	chosen {
-		bootargs = "console=ttySC0,115200 ignore_loglevel";
+		bootargs = "console=ttySC0,115200 ignore_loglevel ip=dhcp root=/dev/nfs";
 	};
 
 	memory {
-- 
1.7.10.4

