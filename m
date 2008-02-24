From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 24 Feb 2008 13:47:08 +0000
Subject: [PATCH 1/3] input: support maple mouse on Dreamcast
Message-Id: <1203860828.6474.6.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

input: support maple mouse on Dreamcast

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 7bbea09..d171336 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -232,4 +232,16 @@ config MOUSE_GPIO
 	  To compile this driver as a module, choose M here: the
 	  module will be called gpio_mouse.
 
+config MOUSE_MAPLE
+	tristate "Dreamcast mouse"
+	depends on SH_DREAMCAST
+	select MAPLE
+	help
+	  This driver supports the Maple bus mouse on a SEGA Dreamcast.
+
+	  Most Dreamcast users (with a mouse) will want to say Y here.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called maplemouse.
+
 endif

