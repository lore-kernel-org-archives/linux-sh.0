From: Jia He <justin.he@arm.com>
Date: Thu, 09 Jul 2020 02:06:26 +0000
Subject: [PATCH v3 3/6] sh/mm: use default dummy memory_add_physaddr_to_nid()
Message-Id: <20200709020629.91671-4-justin.he@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200709020629.91671-1-justin.he@arm.com>
In-Reply-To: <20200709020629.91671-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>
Cc: Kaly Xin <Kaly.Xin@arm.com>, Michal Hocko <mhocko@suse.com>, Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, Chuhong Yuan <hslester96@gmail.com>, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-ia64@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Logan Gunthorpe <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Jia He <justin.he@arm.com>

After making default memory_add_physaddr_to_nid in mm/memory_hotplug,
there is no use to define a similar one in arch specific directory.

Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/sh/mm/init.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index a70ba0fdd0b3..f75932ba87a6 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -430,15 +430,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return ret;
 }
 
-#ifdef CONFIG_NUMA
-int memory_add_physaddr_to_nid(u64 addr)
-{
-	/* Node 0 for now.. */
-	return 0;
-}
-EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
-#endif
-
 void arch_remove_memory(int nid, u64 start, u64 size,
 			struct vmem_altmap *altmap)
 {
-- 
2.17.1
