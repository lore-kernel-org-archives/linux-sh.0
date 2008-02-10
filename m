From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 10 Feb 2008 23:05:09 +0000
Subject: [PATCH 2/2] SH/Dreamcast - joystick (controlpad)
Message-Id: <1202684709.6237.14.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1202684222.6237.9.camel@localhost.localdomain>
In-Reply-To: <1202684222.6237.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dtor@insightbb.com
Cc: Paul Mundt <lethal@users.sourceforge.net>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Changes to the Kconfig and Makefile needed to build the Maple controlpad
code.

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
===

diff --combined drivers/input/joystick/Kconfig
index 7c662ee,7c662ee..3566fa2
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@@ -282,4 -282,4 +282,17 @@@ config JOYSTICK_XPAD_LED
  	  This option enables support for the LED which surrounds the Big X on
  	  XBox 360 controller.
  
+config JOYSTICK_MAPLE
+	tristate "Dreamcast control pad"
+	depends on SH_DREAMCAST
+	select MAPLE
+	help
+	 Say Y here if you have a SEGA Dreamcast and want to use your
+	 controller.
+
+	 Most Dreamcast users will say Y.
+
+	 To compile this as a module choose M here: the
+	 module will be called maplecontrol.
+
  endif
diff --combined drivers/input/joystick/Makefile
index e855abb,e855abb..62929ef
--- a/drivers/input/joystick/Makefile
+++ b/drivers/input/joystick/Makefile
@@@ -27,5 -27,5 +27,6 @@@ obj-$(CONFIG_JOYSTICK_TURBOGRAFX)	+= tu
  obj-$(CONFIG_JOYSTICK_TWIDJOY)		+= twidjoy.o
  obj-$(CONFIG_JOYSTICK_WARRIOR)		+= warrior.o
  obj-$(CONFIG_JOYSTICK_XPAD)		+= xpad.o
+ obj-$(CONFIG_JOYSTICK_MAPLE)		+= maplecontrol.o
  
  obj-$(CONFIG_JOYSTICK_IFORCE)		+= iforce/





