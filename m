From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Jul 2008 12:46:48 +0000
Subject: [PATCH 01/07] soc_camera: Remove default spinlock operations
Message-Id: <20080701124648.30446.87596.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080701124638.30446.81449.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080701124638.30446.81449.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: video4linux-list@redhat.com
Cc: linux-sh@vger.kernel.org, akpm@linux-foundation.org, lethal@linux-sh.org, mchehab@infradead.org

This patch removes the default spinlock_alloc() and spinlock_free()
functions. The pxa_camera.c driver is providing it's own spinlock
callbacks anyway. With this patch spinlock callbacks are required
when registering the host.

This is ground work for the next per-host videobuf queue patch.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/media/video/soc_camera.c |   23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

--- 0001/drivers/media/video/soc_camera.c
+++ work/drivers/media/video/soc_camera.c	2008-06-12 14:05:36.000000000 +0900
@@ -776,27 +776,13 @@ static void dummy_release(struct device 
 {
 }
 
-static spinlock_t *spinlock_alloc(struct soc_camera_file *icf)
-{
-	spinlock_t *lock = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
-
-	if (lock)
-		spin_lock_init(lock);
-
-	return lock;
-}
-
-static void spinlock_free(spinlock_t *lock)
-{
-	kfree(lock);
-}
-
 int soc_camera_host_register(struct soc_camera_host *ici)
 {
 	int ret;
 	struct soc_camera_host *ix;
 
-	if (!ici->vbq_ops || !ici->ops->add || !ici->ops->remove)
+	if (!ici->vbq_ops || !ici->ops->add || !ici->ops->remove
+	    || !ici->ops->spinlock_alloc)
 		return -EINVAL;
 
 	/* Number might be equal to the platform device ID */
@@ -821,11 +807,6 @@ int soc_camera_host_register(struct soc_
 	if (ret)
 		goto edevr;
 
-	if (!ici->ops->spinlock_alloc) {
-		ici->ops->spinlock_alloc = spinlock_alloc;
-		ici->ops->spinlock_free = spinlock_free;
-	}
-
 	scan_add_host(ici);
 
 	return 0;
