From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 11 May 2017 08:03:32 +0000
Subject: [PATCH v2 3/4] sh: sh7264: Remove nonexistent GPIO_PH[0-7] to fix pinctrl registration
Message-Id: <1494489813-27321-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1494489813-27321-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1494489813-27321-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Pinmux_pins[] is initialized through PINMUX_GPIO(), using designated
array initializers, where the GPIO_* enums serve as indices.
If enum values are defined, but never used, pinmux_pins[] contains
(zero-filled) holes.  Such entries are treated as pin zero, which was
registered before, thus leading to pinctrl registration failures, as
seen on sh7722:

    sh-pfc pfc-sh7722: pin 0 already registered
    sh-pfc pfc-sh7722: error during pin registration
    sh-pfc pfc-sh7722: could not register: -22
    sh-pfc: probe of pfc-sh7722 failed with error -22

Remove GPIO_PH[0-7] from the enum to fix this.

Fixes: 41797f75486d8ca3 ("sh: Add pinmux for sh7264")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Untested due to lack of hardware.

v2:
  - Replace fake error messages by reference to sh7722,
  - Add Reviewed-by.
---
 arch/sh/include/cpu-sh2a/cpu/sh7264.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/include/cpu-sh2a/cpu/sh7264.h b/arch/sh/include/cpu-sh2a/cpu/sh7264.h
index 4d1ef6d74bd6050c..2ae0e938b657a109 100644
--- a/arch/sh/include/cpu-sh2a/cpu/sh7264.h
+++ b/arch/sh/include/cpu-sh2a/cpu/sh7264.h
@@ -43,9 +43,7 @@ enum {
 	GPIO_PG7, GPIO_PG6, GPIO_PG5, GPIO_PG4,
 	GPIO_PG3, GPIO_PG2, GPIO_PG1, GPIO_PG0,
 
-	/* Port H */
-	GPIO_PH7, GPIO_PH6, GPIO_PH5, GPIO_PH4,
-	GPIO_PH3, GPIO_PH2, GPIO_PH1, GPIO_PH0,
+	/* Port H - Port H does not have a Data Register */
 
 	/* Port I - not on device */
 
-- 
2.7.4

