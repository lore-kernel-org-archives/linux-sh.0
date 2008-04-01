From: Adrian Bunk <bunk@kernel.org>
Date: Tue, 01 Apr 2008 22:58:09 +0000
Subject: HugeTLB vs. SH3 cpu
Message-Id: <20080401225809.GC32269@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wli@holomorphy.com, lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

fs/Kconfig says:

config HUGETLBFS
        bool "HugeTLB file system support"
        depends on X86 || IA64 || PPC64 || SPARC64 || (SUPERH && MMU) || BROKEN


arch/sh/mm/Kconfig says:

choice
        prompt "HugeTLB page size"
        depends on HUGETLB_PAGE && (CPU_SH4 || CPU_SH5) && MMU


The compiler says with CONFIG_CPU_SH3:

<--  snip  -->

...
  CC      arch/sh/mm/hugetlbpage.o
In file included from /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/mm/hugetlbpage.c:14:/home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/hugetlb.h: In function 'prepare_hugepage_range':
/home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/hugetlb.h:73: error: 'HPAGE_SHIFT' undeclared (first use in this function)
/home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/hugetlb.h:73: error: (Each undeclared identifier is reported only once
/home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/hugetlb.h:73: error: for each function it appears in.)
make[2]: *** [arch/sh/mm/hugetlbpage.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

