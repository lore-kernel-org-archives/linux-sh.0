From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 11 Mar 2015 10:26:02 +0000
Subject: [PATCH] kernfs: remove outdated and confusing comment
Message-Id: <1426069565-7933-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Tejun Heo <tj@kernel.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Grabbing the parent is not happening anymore since 2010 (e72ceb8ccac5f7
"sysfs: Remove sysfs_get/put_active_two"). Remove this confusing
comment.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Found while trying to find out why my sysfs-bin file always returns POLLPRI
after opening, reading, polling. Any pointers while I am here? :)

 fs/kernfs/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index b684e8a132e625..a893c634cd9c0b 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -784,7 +784,6 @@ static unsigned int kernfs_fop_poll(struct file *filp, poll_table *wait)
 	struct kernfs_node *kn = filp->f_path.dentry->d_fsdata;
 	struct kernfs_open_node *on = kn->attr.open;
 
-	/* need parent for the kobj, grab both */
 	if (!kernfs_get_active(kn))
 		goto trigger;
 
-- 
2.1.4

