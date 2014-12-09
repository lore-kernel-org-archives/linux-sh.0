From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 09 Dec 2014 11:25:05 +0000
Subject: [PATCH 7/7] ARM: shmobile: kzm9g-reference dts: Replace status value "ok" by "okay"
Message-Id: <1418124305-7445-7-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

While the DT parsing code recognizes "ok" as a valid value for the
"status" property, ePAPR v1.1 doesn't mention it in the list of valid
values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 939be1299ca6ca34..863dc4c7d7f67762 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -179,7 +179,7 @@
 };
 
 &cmt1 {
-	status = "ok";
+	status = "okay";
 };
 
 &i2c0 {
-- 
1.9.1

