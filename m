From: =?iso-2022-jp?B?GyRCQEZGIzFRSVchd0VFOzobKEI=?= <saito@densan.co.jp>
Date: Fri, 18 Jun 2010 02:06:29 +0000
Subject: cache coherency problem on CF
Message-Id: <20100618.110629.68564635.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

When I use linux-2.6.34 on our board with SH7780, an IDE device for CF does not work.

It seems that this problem is caused by using PIO, because when a command is loaded from filesystem on the CF device, the data is read to i-cache from main memory without copying back to main memory from d-cache.

I think that the following code on arch/sh/mm/cache-sh7705.c is also useful for SH4.

/*
 * This is called when a page-cache page is about to be mapped into a
 * user process' address space.  It offers an opportunity for a
 * port to ensure d-cache/i-cache coherency if necessary.
 *
 * Not entirely sure why this is necessary on SH3 with 32K cache but
 * without it we get occasional "Memory fault" when loading a program.
 */
static void sh7705_flush_icache_page(void *page)
{
        __flush_purge_region(page_address(page), PAGE_SIZE);
}

For example, following change solves this problem likewise.

--- arch/sh/mm/cache-sh4.c.org	2010-05-17 06:17:36.000000000 +0900
+++ arch/sh/mm/cache-sh4.c	2010-06-17 19:00:55.000000000 +0900
@@ -364,16 +364,21 @@ static void __flush_cache_one(unsigned l
 			a += 64;
 			p += 64;
 		} while (a < ea);
 
 		base_addr += way_incr;
 	} while (--way_count != 0);
 }
 
+static void sh4_flush_icache_page(void *page)
+{
+	 __flush_purge_region(page_address(page), PAGE_SIZE);
+}
+
 extern void __weak sh4__flush_region_init(void);
 
 /*
  * SH-4 has virtually indexed and physically tagged cache.
  */
 void __init sh4_cache_init(void)
 {
 	printk("PVR=%08x CVR=%08x PRR=%08x\n",
@@ -383,11 +388,12 @@ void __init sh4_cache_init(void)
 
 	local_flush_icache_range	= sh4_flush_icache_range;
 	local_flush_dcache_page		= sh4_flush_dcache_page;
 	local_flush_cache_all		= sh4_flush_cache_all;
 	local_flush_cache_mm		= sh4_flush_cache_mm;
 	local_flush_cache_dup_mm	= sh4_flush_cache_mm;
 	local_flush_cache_page		= sh4_flush_cache_page;
 	local_flush_cache_range		= sh4_flush_cache_range;
+	local_flush_icache_page		= sh4_flush_icache_page;
 
 	sh4__flush_region_init();
 }
