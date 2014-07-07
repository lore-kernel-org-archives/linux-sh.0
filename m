From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 07 Jul 2014 06:47:36 +0000
Subject: [PATCH 1/3] ARM: shmobile: henninger: Consistently use tabs for indentation
Message-Id: <1404715658-31050-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404715658-31050-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1404715658-31050-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Unify white space usage by consistently using tabs for indentation.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-henninger.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index bc48bcc..1a8991d 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -151,7 +151,7 @@
 };
 
 &sata0 {
-       status = "okay";
+	status = "okay";
 };
 
 &sdhi0 {
-- 
2.0.0.rc2

