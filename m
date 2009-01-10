From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Sat, 10 Jan 2009 17:38:48 +0000
Subject: sh: dcache flush breaks text region?
Message-Id: <4968DD28.3030709@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: qemu-devel@nongnu.org

Hi, all.

I'm now working on to expand qemu-sh to emulate
"Solution Engine 7750", and found one odd thing.
Could you give me some advice?

My SH7750 emulation environment fails to boot up.
I made some investigation and found that,
 - the linux kernel for SE7750(se7750_defconfig) flushes
   dcache on its boot sequence.
 - SH7750's dcache is 16KB and direct-map.
   Then 16KB memory region are touched and modified to flush it.
 - empty_zero_page is used for this flush, but it only has
   4KB.  The text region after it has got broken and causes
   boot failure.

I added a patch against linux kernel to this mail for a reference.
It only reduces the flush region size to 4KB=PAGE_SIZE, but avoids
the problem and let the kernel boot up cleanly.
Of course it is not a good solution, because it does not flush all
caches.

I wonder two points.
 - Does this problem happen on real SE7750 board?
   In other words, does the current linux kernel work on it?
   I don't have it, and can't check it out by myself.
 - How should I solve the problem?
   16KB region should be allocated for flush by kernel?

The patches for SE7750 emulation is not yet posted
to qemu-devel. Before it, I'd like to solve the problem.

Any comments will be appreciated.

Regards,
Shin-ichiro KAWASAKI



diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 5cfe08d..4042c8c 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -612,6 +612,9 @@ static void __flush_dcache_segment_1way(unsigned long start,
 
 	a0 = base_addr;
 	a0e = base_addr + extent_per_way;
+	if (a0e > ((unsigned long)&empty_zero_page[0]) + PAGE_SIZE) {
+	    a0e = ((unsigned long)&empty_zero_page[0]) + PAGE_SIZE;
+	}
 	do {
 		asm volatile("ldc %0, sr" : : "r" (sr_with_bl));
 		asm volatile("movca.l r0, @%0\n\t"
