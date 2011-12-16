From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 16 Dec 2011 00:13:35 +0000
Subject: [Update][PATCH 4/5] PM / input / touchscreen: Make st1232 use device PM QoS constraints
Message-Id: <201112160113.36166.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201112100042.45168.rjw@sisk.pl> <201112160110.09124.rjw@sisk.pl>
In-Reply-To: <201112160110.09124.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-sh list <linux-sh@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make the st1232 driver use dev_pm_qos_add_ancestor_request() to
add a device PM QoS latency constraint for the controller it
depends on, so that the controller won't go into an overly deep
low-power state when the touchscreen has to be particularly
responsive (e.g. when the user moves his or her finger on it).

This change is based on a prototype patch from Guennadi Liakhovetski.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/input/touchscreen/st1232.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Index: linux/drivers/input/touchscreen/st1232.c
=================================--- linux.orig/drivers/input/touchscreen/st1232.c
+++ linux/drivers/input/touchscreen/st1232.c
@@ -23,6 +23,7 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -46,6 +47,7 @@ struct st1232_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
 	struct st1232_ts_finger finger[MAX_FINGERS];
+	struct dev_pm_qos_request low_latency_req;
 };
 
 static int st1232_ts_read_data(struct st1232_ts_data *ts)
@@ -118,8 +120,17 @@ static irqreturn_t st1232_ts_irq_handler
 	}
 
 	/* SYN_MT_REPORT only if no contact */
-	if (!count)
+	if (!count) {
 		input_mt_sync(input_dev);
+		if (ts->low_latency_req.dev) {
+			dev_pm_qos_remove_request(&ts->low_latency_req);
+			ts->low_latency_req.dev = NULL;
+		}
+	} else if (!ts->low_latency_req.dev) {
+		/* First contact, request 100 us latency. */
+		dev_pm_qos_add_ancestor_request(&ts->client->dev,
+						&ts->low_latency_req, 100);
+	}
 
 	/* SYN_REPORT */
 	input_sync(input_dev);

