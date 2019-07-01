From: Christoph Hellwig <hch@lst.de>
Date: Mon, 01 Jul 2019 15:18:18 +0000
Subject: [PATCH 2/2] MIPS: don't select ARCH_HAS_PTE_SPECIAL
Message-Id: <20190701151818.32227-3-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190701151818.32227-1-hch@lst.de>
In-Reply-To: <20190701151818.32227-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

MIPS doesn't really have a proper pte_special implementation, just
stubs.  It turns out they were not enough to make get_user_pages_fast
work, so drop the select.  This means get_user_pages_fast won't
actually use the fast path for non-hugepage mappings, so someone who
actually knows about mips page table management should look into
adding real pte_special support.

Fixes: eb9488e58bbc ("MIPS: use the generic get_user_pages_fast code")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b1e42f0e4ed0..7957d3457156 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -6,7 +6,6 @@ config MIPS
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_ELF_RANDOMIZE
-	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_SUPPORTS_UPROBES
-- 
2.20.1
