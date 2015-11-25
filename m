From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 25 Nov 2015 12:52:13 +0000
Subject: [PATCH] pinctrl: sh-pfc: sh7734: Add missing cfg macro parameter to fix build
Message-Id: <1448455933-20276-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

When building for SH7734:

    drivers/pinctrl/sh-pfc/pfc-sh7734.c:586:1: error: macro "_GP_DATA" passed 5 arguments, but takes just 4
    drivers/pinctrl/sh-pfc/pfc-sh7734.c:586:2: error: '_GP_DATA' undeclared here (not in a function)
    drivers/pinctrl/sh-pfc/pfc-sh7734.c:586:1: error: macro "_GP_DATA" passed 5 arguments, but takes just 4
    drivers/pinctrl/sh-pfc/pfc-sh7734.c:586:1: error: macro "_GP_DATA" passed 5 arguments, but takes just 4
    ...
    drivers/pinctrl/sh-pfc/pfc-sh7734.c:2389:1: error: macro "_GP_INOUTSEL" passed 5 arguments, but takes just 4
    drivers/pinctrl/sh-pfc/pfc-sh7734.c:2389:53: error: '_GP_INOUTSEL' undeclared here (not in a function)
    drivers/pinctrl/sh-pfc/pfc-sh7734.c:2389:2: warning: initialization makes integer from pointer without a cast [enabled by default]
    drivers/pinctrl/sh-pfc/pfc-sh7734.c:2389:2: warning: (near initialization for '(anonymous)[0]') [enabled by default]
    ...
    drivers/pinctrl/sh-pfc/pfc-sh7734.c:2416:1: error: macro "_GP_INDT" passed 5 arguments, but takes just 4
    drivers/pinctrl/sh-pfc/pfc-sh7734.c:2416:47: error: '_GP_INDT' undeclared here (not in a function)
    drivers/pinctrl/sh-pfc/pfc-sh7734.c:2416:2: warning: initialization makes integer from pointer without a cast [enabled by default]
    drivers/pinctrl/sh-pfc/pfc-sh7734.c:2416:2: warning: (near initialization for '(anonymous)[0]') [enabled by default]
    ...

Add the missing "cfg" macro parameters to the sh7734-specific
_GP_DATA(), _GP_INOUTSEL(), and _GP_INDT() macros to fix this.

Fixes: 22768fc60abbf58b ("pinctrl: sh-pfc: Add macros defining GP ports with config flags")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Hi Linus,

This is a regression introduced in v4.4-rc1.
Thanks for applying directly!

How to trigger (there's no sh7734 defconfig):
  - make ARCH=sh se7724_defconfig
  - enable CONFIG_CPU_SUBTYPE_SH7734
  - make drivers/pinctrl/sh-pfc/pfc-sh7734.o
---
 drivers/pinctrl/sh-pfc/pfc-sh7734.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index e7deb51de7dc4fd4..9842bb1067969701 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -31,11 +31,11 @@
 	PORT_GP_12(5, fn, sfx)
 
 #undef _GP_DATA
-#define _GP_DATA(bank, pin, name, sfx)					\
+#define _GP_DATA(bank, pin, name, sfx, cfg)				\
 	PINMUX_DATA(name##_DATA, name##_FN, name##_IN, name##_OUT)
 
-#define _GP_INOUTSEL(bank, pin, name, sfx)	name##_IN, name##_OUT
-#define _GP_INDT(bank, pin, name, sfx)		name##_DATA
+#define _GP_INOUTSEL(bank, pin, name, sfx, cfg)	name##_IN, name##_OUT
+#define _GP_INDT(bank, pin, name, sfx, cfg)	name##_DATA
 #define GP_INOUTSEL(bank)	PORT_GP_32_REV(bank, _GP_INOUTSEL, unused)
 #define GP_INDT(bank)		PORT_GP_32_REV(bank, _GP_INDT, unused)
 
-- 
1.9.1

