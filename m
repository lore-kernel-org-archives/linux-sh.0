From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Date: Wed, 17 Nov 2010 06:51:08 +0000
Subject: [PATCH (sh-2.6)] sh: avoid to flush all cache in sys_cacheflush
Message-Id: <1289976668-27728-1-git-send-email-peppe.cavallaro@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Calling sys_cacheflush with ICACHE we can direclty flush
the icache without invoking the flush_cache_all function.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 arch/sh/kernel/sys_sh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/sys_sh.c b/arch/sh/kernel/sys_sh.c
index 81f5837..8c6a350 100644
--- a/arch/sh/kernel/sys_sh.c
+++ b/arch/sh/kernel/sys_sh.c
@@ -88,7 +88,7 @@ asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len, int op)
 	}
 
 	if (op & CACHEFLUSH_I)
-		flush_cache_all();
+		flush_icache_range(addr, addr+len);
 
 	up_read(&current->mm->mmap_sem);
 	return 0;
-- 
1.5.5.6

