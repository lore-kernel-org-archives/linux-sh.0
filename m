From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 11 Jun 2011 20:27:11 +0000
Subject: [PATCH 3/8] PM: subsys_data in struct dev_pm_info need not depend on RM_RUNTIME
Message-Id: <201106112227.11933.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201106112223.04972.rjw@sisk.pl>
In-Reply-To: <201106112223.04972.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The subsys_data field of struct dev_pm_info, introduced by commit
1d2b71f61b6a10216274e27b717becf9ae101fc7 (PM / Runtime: Add subsystem
data field to struct dev_pm_info), is going to be used even if
CONFIG_PM_RUNTIME is not set, so move it from under the #ifdef.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/pm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/include/linux/pm.h
=================================--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -460,8 +460,8 @@ struct dev_pm_info {
 	unsigned long		active_jiffies;
 	unsigned long		suspended_jiffies;
 	unsigned long		accounting_timestamp;
-	void			*subsys_data;  /* Owned by the subsystem. */
 #endif
+	void			*subsys_data;  /* Owned by the subsystem. */
 };
 
 extern void update_pm_runtime_accounting(struct device *dev);

