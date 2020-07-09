From: Jia He <justin.he@arm.com>
Date: Thu, 09 Jul 2020 02:06:23 +0000
Subject: [PATCH v3 0/6] Fix and enable pmem as RAM device on arm64
Message-Id: <20200709020629.91671-1-justin.he@arm.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>
Cc: Kaly Xin <Kaly.Xin@arm.com>, Michal Hocko <mhocko@suse.com>, Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, Chuhong Yuan <hslester96@gmail.com>, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-ia64@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Logan Gunthorpe <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Jia He <justin.he@arm.com>

This fixies a few issues when I tried to enable pmem as RAM device on arm64.

To use memory_add_physaddr_to_nid as a fallback nid, it would be better
implement a general version (__weak) in mm/memory_hotplug. After that, arm64/
sh/s390 can simply use the general version, and PowerPC/ia64/x86 will use
arch specific version.

Tested on ThunderX2 host/qemu "-M virt" guest with a nvdimm device. The 
memblocks from the dax pmem device can be either hot-added or hot-removed
on arm64 guest. Also passed the compilation test on x86.

Changes:
v3: - introduce general version memory_add_physaddr_to_nid, refine the arch
      specific one
    - fix an uninitialization bug in v2 device-dax patch
v2: https://lkml.org/lkml/2020/7/7/71
    - Drop unnecessary patch to harden try_offline_node
    - Use new solution(by David) to fix dev->target_node=-1 during probing
    - Refine the mem_hotplug_begin/done patch

v1: https://lkml.org/lkml/2020/7/5/381


Jia He (6):
  mm/memory_hotplug: introduce default dummy
    memory_add_physaddr_to_nid()
  arm64/mm: use default dummy memory_add_physaddr_to_nid()
  sh/mm: use default dummy memory_add_physaddr_to_nid()
  mm: don't export memory_add_physaddr_to_nid in arch specific directory
  device-dax: use fallback nid when numa_node is invalid
  mm/memory_hotplug: fix unpaired mem_hotplug_begin/done

 arch/arm64/mm/numa.c | 10 ----------
 arch/ia64/mm/numa.c  |  2 --
 arch/sh/mm/init.c    |  9 ---------
 arch/x86/mm/numa.c   |  1 -
 drivers/dax/kmem.c   | 21 +++++++++++++--------
 mm/memory_hotplug.c  | 15 ++++++++++++---
 6 files changed, 25 insertions(+), 33 deletions(-)

-- 
2.17.1
