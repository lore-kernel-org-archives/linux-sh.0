From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 21 Aug 2011 19:11:44 +0000
Subject: [PATCH 2/2 v2] sh-sci / PM: Use power.irq_safe
Message-Id: <201108212111.45012.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201108202131.19479.rjw@sisk.pl> <201108212109.30399.rjw@sisk.pl>
In-Reply-To: <201108212109.30399.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>

From: Rafael J. Wysocki <rjw@sisk.pl>

Since sci_port_enable() and sci_port_disable() may be run with
interrupts off and they execute pm_runtime_get_sync() and
pm_runtime_put_sync(), respectively, the SCI device's
power.irq_safe flags has to be used to indicate that it is safe
to execute runtime PM callbacks for this device with interrupts off.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/tty/serial/sh-sci.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux/drivers/tty/serial/sh-sci.c
=================================--- linux.orig/drivers/tty/serial/sh-sci.c
+++ linux/drivers/tty/serial/sh-sci.c
@@ -1913,6 +1913,7 @@ static int __devinit sci_init_single(str
 
 		port->dev = &dev->dev;
 
+		pm_runtime_irq_safe(&dev->dev);
 		pm_runtime_enable(&dev->dev);
 	}
 

