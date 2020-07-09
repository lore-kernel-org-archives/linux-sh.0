From: Jia He <justin.he@arm.com>
Date: Thu, 09 Jul 2020 02:06:27 +0000
Subject: [PATCH v3 4/6] mm: don't export memory_add_physaddr_to_nid in arch specific directory
Message-Id: <20200709020629.91671-5-justin.he@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200709020629.91671-1-justin.he@arm.com>
In-Reply-To: <20200709020629.91671-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>
Cc: Kaly Xin <Kaly.Xin@arm.com>, Michal Hocko <mhocko@suse.com>, Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, Chuhong Yuan <hslester96@gmail.com>, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-ia64@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Logan Gunthorpe <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Jia He <justin.he@arm.com>

After a general version of __weak memory_add_physaddr_to_nid implemented
and exported , it is no use exporting twice in arch directory even if
e,g, ia64/x86 have their specific version.

This is to suppress the modpost warning:
WARNING: modpost: vmlinux: 'memory_add_physaddr_to_nid' exported twice.
Previous export was in vmlinux

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/ia64/mm/numa.c | 2 --
 arch/x86/mm/numa.c  | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/ia64/mm/numa.c b/arch/ia64/mm/numa.c
index 5e1015eb6d0d..f34964271101 100644
--- a/arch/ia64/mm/numa.c
+++ b/arch/ia64/mm/numa.c
@@ -106,7 +106,5 @@ int memory_add_physaddr_to_nid(u64 addr)
 		return 0;
 	return nid;
 }
-
-EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 #endif
 #endif
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 8ee952038c80..2a6e62af4636 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -929,5 +929,4 @@ int memory_add_physaddr_to_nid(u64 start)
 		nid = numa_meminfo.blk[0].nid;
 	return nid;
 }
-EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 #endif
-- 
2.17.1
