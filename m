From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 14:01:34 +0000
Subject: [PATCH 04/07] sh: allow registering clocks without name
Message-Id: <20100510140134.32745.67195.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Modify the SuperH clock code to support struct clk
with NULL as name. Such clocks will not be hooked
up to debugfs.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/clock.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- 0001/arch/sh/kernel/cpu/clock.c
+++ work/arch/sh/kernel/cpu/clock.c	2010-05-10 19:04:14.000000000 +0900
@@ -415,7 +415,7 @@ struct clk *clk_get(struct device *dev, 
 
 	mutex_lock(&clock_list_sem);
 	list_for_each_entry(p, &clock_list, node) {
-		if (p->id = idno &&
+		if (p->name && p->id = idno &&
 		    strcmp(id, p->name) = 0 && try_module_get(p->owner)) {
 			clk = p;
 			goto found;
@@ -423,7 +423,8 @@ struct clk *clk_get(struct device *dev, 
 	}
 
 	list_for_each_entry(p, &clock_list, node) {
-		if (strcmp(id, p->name) = 0 && try_module_get(p->owner)) {
+		if (p->name &&
+		    strcmp(id, p->name) = 0 && try_module_get(p->owner)) {
 			clk = p;
 			break;
 		}
@@ -594,7 +595,7 @@ static int clk_debugfs_register(struct c
 			return err;
 	}
 
-	if (!c->dentry) {
+	if (!c->dentry && c->name) {
 		err = clk_debugfs_register_one(c);
 		if (err)
 			return err;
