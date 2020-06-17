From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2020 06:55:39 +0000
Subject: [PATCH 2/2] input: i8042 - Remove special Cayman handling
Message-Id: <20200617065539.25805-3-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200617065539.25805-1-geert+renesas@glider.be>
In-Reply-To: <20200617065539.25805-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

As of commit 37744feebc086908 ("sh: remove sh5 support"), support for
the SH5-based Cayman platform can no longer be selected.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/input/serio/i8042-io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
index da0bf85321de3a77..64590b86eb37ff30 100644
--- a/drivers/input/serio/i8042-io.h
+++ b/drivers/input/serio/i8042-io.h
@@ -21,8 +21,6 @@
 #elif defined(__arm__)
 /* defined in include/asm-arm/arch-xxx/irqs.h */
 #include <asm/irq.h>
-#elif defined(CONFIG_SH_CAYMAN)
-#include <asm/irq.h>
 #elif defined(CONFIG_PPC)
 extern int of_i8042_kbd_irq;
 extern int of_i8042_aux_irq;
-- 
2.17.1
