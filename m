From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Mon, 26 Oct 2009 19:11:43 +0000
Subject: Clean config for hp6xx and Hugetlbpage build errors
Message-Id: <20091026201143.a0e55726.kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Greetings,

Starting with a fresh ARCH=sh menuconfig and selecting my various bits and pieces
for hp6xx, I end up with this:

In file included from include/linux/hugetlb.h:275,
                 from arch/sh/mm/hugetlbpage.c:14:
/home/kristoffer/work/kernel/linux-hpc.git/arch/sh/include/asm/hugetlb.h: In function `prepare_hugepage_range':
/home/kristoffer/work/kernel/linux-hpc.git/arch/sh/include/asm/hugetlb.h:20: error: `HPAGE_SHIFT' undeclared (first use in this function)
/home/kristoffer/work/kernel/linux-hpc.git/arch/sh/include/asm/hugetlb.h:20: error: (Each undeclared identifier is reported only once
/home/kristoffer/work/kernel/linux-hpc.git/arch/sh/include/asm/hugetlb.h:20: error: for each function it appears in.)
make[1]: *** [arch/sh/mm/hugetlbpage.o] Fel 1
make: *** [arch/sh/mm] Fel 2

Turning off MMU makes it compile nicely. And to make it abit more funny, then reactivating mmu
works fine ;)

So in order to build from scratch I need to :
1. Build with mmu (fails with hugetlb missing HPAGE_SHIFT).
2. build without mmu (works) and stop after awhile.
3. Build with mmu.

So, why is hugetlb defaulting to y?

/Kristoffer

-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>
