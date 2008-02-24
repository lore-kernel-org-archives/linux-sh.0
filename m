From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 24 Feb 2008 13:49:14 +0000
Subject: [PATCH 2/3] input: support maple mouse on Dreamcast
Message-Id: <1203860954.6474.9.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1203860828.6474.6.camel@localhost.localdomain>
In-Reply-To: <1203860828.6474.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


input: update Makefile to support maple mouse on Dreamcast

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index 9e6e363..5d35939 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
 obj-$(CONFIG_MOUSE_GPIO)	+= gpio_mouse.o
+obj-$(CONFIG_MOUSE_MAPLE)	+= maplemouse.o
 
 psmouse-objs := psmouse-base.o synaptics.o

