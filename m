From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 07 Oct 2015 08:23:44 +0000
Subject: [PATCH 2/3] pinctrl: sh-pfc: Stop including <linux/platform_data/gpio-rcar.h>
Message-Id: <1444206225-25664-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1444206225-25664-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444206225-25664-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

This header file will be removed soon.

Copy the helper macro RCAR_GP_PIN(), which is used by the pinctrl
drivers only, to sh_pfc.h, and drop the #include.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 1 -
 drivers/pinctrl/sh-pfc/sh_pfc.h      | 5 +++++
 7 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index 581d3c44aa4a..ff0077d7869b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -23,7 +23,6 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/pinctrl/pinconf-generic.h>
-#include <linux/platform_data/gpio-rcar.h>
 #include "core.h"
 #include "sh_pfc.h"
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 4be082e6a02e..63e22303b934 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -20,7 +20,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/platform_data/gpio-rcar.h>
 
 #include "sh_pfc.h"
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 8e45e30252bc..79b08ecc10be 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -22,7 +22,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/platform_data/gpio-rcar.h>
 
 #include "core.h"
 #include "sh_pfc.h"
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index a58a0dec6994..e67f82a44b95 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/platform_data/gpio-rcar.h>
 
 #include "core.h"
 #include "sh_pfc.h"
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 185554e15099..bc570d72285e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/platform_data/gpio-rcar.h>
 
 #include "core.h"
 #include "sh_pfc.h"
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index dce06ed02090..446a37d900c8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/platform_data/gpio-rcar.h>
 
 #include "core.h"
 #include "sh_pfc.h"
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 12bfb706845e..a6c9bf23371f 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -341,4 +341,9 @@ struct sh_pfc_soc_info {
 		}							\
 	}
 
+/*
+ * GPIO number helper macro for R-Car
+ */
+#define RCAR_GP_PIN(bank, pin)		(((bank) * 32) + (pin))
+
 #endif /* __SH_PFC_H */
-- 
1.9.1

