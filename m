From: Gon Solo <gonsolo@gmail.com>
Date: Mon, 16 Dec 2019 10:35:22 +0000
Subject: [PATCH 1/1] Fix undefined reference to 'node_reclaim_distance'.
Message-Id: <20191216103522.32215-2-gonsolo@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20191216103522.32215-1-gonsolo@gmail.com>
In-Reply-To: <20191216103522.32215-1-gonsolo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Gon Solo <gonsolo@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

According to https://lkml.org/lkml/2019/12/16/101 and
http://kisskb.ellerman.id.au/kisskb/buildresult/14067948/ building on
sh4 is broken due to a

page_alloc.c:(.text+0x3148): undefined reference to `node_reclaim_distance'.

This only happens with CONFIG_NUMA=y (variable used with #ifdef
CONFIG_NUMA at mm/page_alloc.c:3529) and CONFIG_SMP=n (variable defined at
kernel/sched/topology.c:2291 but the whole file to be built depends on
CONFIG_SMP in kernel/sched/Makefile:23.

Follow the lead of arch/x86/Kconfig:1547 and depend on SMP.

This assumes that there are no NUMA systems without SMP which is
reasonable I guess.

Signed-off-by: Gon Solo <gonsolo@gmail.com>
---
 arch/sh/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 5c8a2ebfc720..cf655d8e8758 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -108,7 +108,7 @@ config VSYSCALL
 
 config NUMA
 	bool "Non Uniform Memory Access (NUMA) Support"
-	depends on MMU && SYS_SUPPORTS_NUMA
+	depends on MMU && SMP && SYS_SUPPORTS_NUMA
 	select ARCH_WANT_NUMA_VARIABLE_LOCALITY
 	default n
 	help
-- 
2.20.1
