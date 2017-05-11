From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 11 May 2017 08:03:31 +0000
Subject: [PATCH v2 2/4] sh: sh7757: Remove nonexistent GPIO_PT[JLNQ]7_RESV to fix pinctrl registration
Message-Id: <1494489813-27321-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1494489813-27321-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1494489813-27321-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Commit 3810e96056ffddf6 ("sh: modify pinmux for SH7757 2nd cut") renamed
GPIO_PT[JLNQ]7 to GPIO_PT[JLNQ]7_RESV, and removed the existing users
from the pinmux_pins[] array.

However, pinmux_pins[] is initialized through PINMUX_GPIO(), using
designated array initializers, where the GPIO_* enums serve as indices.
Hence entries were not really removed, but replaced by (zero-filled)
holes.  Such entries are treated as pin zero, which was registered
before, thus leading to pinctrl registration failures, as seen on
sh7722:

    sh-pfc pfc-sh7722: pin 0 already registered
    sh-pfc pfc-sh7722: error during pin registration
    sh-pfc pfc-sh7722: could not register: -22
    sh-pfc: probe of pfc-sh7722 failed with error -22

Remove GPIO_PT[JLNQ]7_RESV from the enum to fix this.

Fixes: 3810e96056ffddf6 ("sh: modify pinmux for SH7757 2nd cut")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Untested due to lack of hardware and datasheet.

v2:
  - Replace fake error messages by reference to sh7722,
  - Add Reviewed-by.
---
 arch/sh/include/cpu-sh4/cpu/sh7757.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/sh7757.h b/arch/sh/include/cpu-sh4/cpu/sh7757.h
index 5340f3bc1863c389..b40fb541e72a78ae 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7757.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7757.h
@@ -40,7 +40,7 @@ enum {
 
 	/* PTJ */
 	GPIO_PTJ0, GPIO_PTJ1, GPIO_PTJ2, GPIO_PTJ3,
-	GPIO_PTJ4, GPIO_PTJ5, GPIO_PTJ6, GPIO_PTJ7_RESV,
+	GPIO_PTJ4, GPIO_PTJ5, GPIO_PTJ6,
 
 	/* PTK */
 	GPIO_PTK0, GPIO_PTK1, GPIO_PTK2, GPIO_PTK3,
@@ -48,7 +48,7 @@ enum {
 
 	/* PTL */
 	GPIO_PTL0, GPIO_PTL1, GPIO_PTL2, GPIO_PTL3,
-	GPIO_PTL4, GPIO_PTL5, GPIO_PTL6, GPIO_PTL7_RESV,
+	GPIO_PTL4, GPIO_PTL5, GPIO_PTL6,
 
 	/* PTM */
 	GPIO_PTM0, GPIO_PTM1, GPIO_PTM2, GPIO_PTM3,
@@ -56,7 +56,7 @@ enum {
 
 	/* PTN */
 	GPIO_PTN0, GPIO_PTN1, GPIO_PTN2, GPIO_PTN3,
-	GPIO_PTN4, GPIO_PTN5, GPIO_PTN6, GPIO_PTN7_RESV,
+	GPIO_PTN4, GPIO_PTN5, GPIO_PTN6,
 
 	/* PTO */
 	GPIO_PTO0, GPIO_PTO1, GPIO_PTO2, GPIO_PTO3,
@@ -68,7 +68,7 @@ enum {
 
 	/* PTQ */
 	GPIO_PTQ0, GPIO_PTQ1, GPIO_PTQ2, GPIO_PTQ3,
-	GPIO_PTQ4, GPIO_PTQ5, GPIO_PTQ6, GPIO_PTQ7_RESV,
+	GPIO_PTQ4, GPIO_PTQ5, GPIO_PTQ6,
 
 	/* PTR */
 	GPIO_PTR0, GPIO_PTR1, GPIO_PTR2, GPIO_PTR3,
-- 
2.7.4

