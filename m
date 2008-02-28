From: Hideo Saito <saito@densan.co.jp>
Date: Thu, 28 Feb 2008 09:45:40 +0000
Subject: TLB reset on SH7780
Message-Id: <20080228.184540.68563408.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

When /dev/mem is accessed as follows, it causes TLB reset on SH7780, because our physical memory is mapped from 0x08000000, the PMB entry does not map all of the P1 area.

# dd if=/dev/mem <return>

How about following changes though the code is in the machine independent part?

--- ./drivers/char/mem.c.org	2008-01-25 07:58:37.000000000 +0900
+++ ./drivers/char/mem.c	2008-02-28 17:56:11.000000000 +0900
@@ -91,17 +91,18 @@ static inline int uncached_access(struct
 		return 1;
 	return addr >= __pa(high_memory);
 #endif
 }
 
 #ifndef ARCH_HAS_VALID_PHYS_ADDR_RANGE
 static inline int valid_phys_addr_range(unsigned long addr, size_t count)
 {
-	if (addr + count > __pa(high_memory))
+	if (addr < __pa(high_memory - (num_physpages << PAGE_SHIFT)) ||
+	    addr + count > __pa(high_memory))
 		return 0;
 
 	return 1;
 }
 
 static inline int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 {
 	return 1;
