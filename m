From: Matt Fleming <mjf@gentoo.org>
Date: Sun, 14 Dec 2008 17:09:16 +0000
Subject: [PATCH] sh: Do not pass SLAB_POISON to kmem_cache_create()
Message-Id: <1229274556-31790-1-git-send-email-mjf@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SLAB_POISON is not a valid flag for kmem_create_cache() unless
CONFIG_DEBUG_SLAB is set, and can we ever know if it's set? Since no
drivers seem to use this flag just remove it from the flags argument.

Acked-by: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Signed-off-by: Matt Fleming <mjf@gentoo.org>
---
 drivers/sh/maple/maple.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index d1812d3..63f0de2 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -827,7 +827,7 @@ static int __init maple_bus_init(void)
 
 	maple_queue_cache  	    kmem_cache_create("maple_queue_cache", 0x400, 0,
-			      SLAB_POISON|SLAB_HWCACHE_ALIGN, NULL);
+			      SLAB_HWCACHE_ALIGN, NULL);
 
 	if (!maple_queue_cache)
 		goto cleanup_bothirqs;
-- 
1.5.6.4

