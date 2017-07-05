From: Joe Perches <joe@perches.com>
Date: Wed, 05 Jul 2017 20:02:19 +0000
Subject: [PATCH 10/18] sh: Move inline before return type
Message-Id: <f81bb2a67a97b1fd8b6ea99bd350d8a0f6864fb1.1499284835.git.joe@perches.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1499284835.git.joe@perches.com>
In-Reply-To: <cover.1499284835.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

Make the code like the rest of the kernel.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/sh/mm/cache-sh5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/cache-sh5.c b/arch/sh/mm/cache-sh5.c
index d94dadedf74f..445b5e69b73c 100644
--- a/arch/sh/mm/cache-sh5.c
+++ b/arch/sh/mm/cache-sh5.c
@@ -234,7 +234,7 @@ static void sh64_icache_inv_current_user_range(unsigned long start, unsigned lon
 #define DUMMY_ALLOCO_AREA_SIZE ((L1_CACHE_BYTES << 10) + (1024 * 4))
 static unsigned char dummy_alloco_area[DUMMY_ALLOCO_AREA_SIZE] __cacheline_aligned = { 0, };
 
-static void inline sh64_dcache_purge_sets(int sets_to_purge_base, int n_sets)
+static inline void sh64_dcache_purge_sets(int sets_to_purge_base, int n_sets)
 {
 	/* Purge all ways in a particular block of sets, specified by the base
 	   set number and number of sets.  Can handle wrap-around, if that's
-- 
2.10.0.rc2.1.g053435c

