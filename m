From: Matthew Wilcox <willy@infradead.org>
Date: Wed, 17 Jan 2018 20:21:49 +0000
Subject: [PATCH v6 85/99] btrfs: Remove unused spinlock
Message-Id: <20180117202203.19756-86-willy@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20180117202203.19756-1-willy@infradead.org>
In-Reply-To: <20180117202203.19756-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-nilfs@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>, linux-sh@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Stefano Stabellini <sstabellini@kernel.org>, linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-btrfs@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

The reada_lock in struct btrfs_device was only initialised, and not
actually used.  That's good because there's another lock also called
reada_lock in the btrfs_fs_info that was quite heavily used.  Remove
this one.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/btrfs/volumes.c | 1 -
 fs/btrfs/volumes.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a25684287501..cba286183ff9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -244,7 +244,6 @@ static struct btrfs_device *__alloc_device(void)
 
 	spin_lock_init(&dev->io_lock);
 
-	spin_lock_init(&dev->reada_lock);
 	atomic_set(&dev->reada_in_flight, 0);
 	atomic_set(&dev->dev_stats_ccnt, 0);
 	btrfs_device_data_ordered_init(dev);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index ff15208344a7..335fd1590458 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -136,7 +136,6 @@ struct btrfs_device {
 	struct work_struct rcu_work;
 
 	/* readahead state */
-	spinlock_t reada_lock;
 	atomic_t reada_in_flight;
 	u64 reada_next;
 	struct reada_zone *reada_curr_zone;
-- 
2.15.1

