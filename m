From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 18 Nov 2014 00:51:15 +0000
Subject: [PATCH 4/4] ARM: shmobile: kzm9g-reference: Use keyboard as gpio-keys node name
Message-Id: <61f1fb47bdbcf145dd539d29cfa7f3294bd5e958.1416271777.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1416271777.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1416271777.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This appears to be the best match for ePAPR.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 8c913d9..3721cd4 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -113,7 +113,7 @@
 		};
 	};
 
-	gpio-keys {
+	keyboard {
 		compatible = "gpio-keys";
 
 		back-key {
-- 
2.1.1

