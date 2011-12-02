From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 02 Dec 2011 06:03:08 +0000
Subject: Re: [PATCH] sh: sh2a: Optimise cache flush for writethrough mode.
Message-Id: <20111202060308.GA5704@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1322637713-15227-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1322637713-15227-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 30, 2011 at 09:56:35AM +0000, phil.edworthy@renesas.com wrote:
> It's worth mentioning that this patch is essentially a work around for an 
> issue with write-back mode. sh2a_flush_icache_range is passed a large 
> address range which takes ages to flush/invalidate. For write-back mode, 
> instead of indexing on the address, perhaps we can walk through all the 
> cache entries and check for an address match. That's for another day...
> 
That's a common pitfall for anything using the address array for clearing
the entries. We have some simple heuristics in the cache-sh4.c code:

..
        /* If there are too many pages then just blow away the caches */
        if (((end - start) >> PAGE_SHIFT) >= MAX_ICACHE_PAGES) {
                local_flush_cache_all(NULL);
                return;
        }
..

A similar thing should probably be done for the SH-2/2A cases simply utilizing
CCR-based global invalidation.

> I agree that the other functions can be improved. I ignored them as the 
> main performance issue is with sh2a_flush_icache_range. I wasn't entirely 
> sure when some of the other functions are used. Are 
> sh2a__flush_wback_region and sh2a__flush_purge_region purely OC related? 
> And sh2a__flush_invalidate_region and sh2a_flush_icache_range work on both 
> the IC and OC?
> 
All of __flush_wback/purge/invalidate_region() are region based routines for OC
management. You get an idea of the abstraction from arch/sh/mm/flush-sh4.c. In general:

	__flush_wback_region - OC writeback
	__flush_invalidate_region - OC invalidate
	__flush_purge_region - OC writeback & invalidate

You can see a trivial usage example through the consistent DMA's
dma_cache_sync() and so on, relative to DMA direction.

flush_icache_range() handles I-cache invalidation for non-snoopable stores, and also
contends with things like I-cache aliases and the like. While semantically it's
not terribly complex, it's a bit of a sledgehammer given the different cases in
which it gets used. Whether the D-cache handling needs to be implemented or not
is likewise CPU dependent. In cases where the I-cache is not able to snoop
D-cache accesses we also need to deal with the D-cache explicitly. On the SMP
parts it's also further complicated by the fact that the bulk of the parts do
not broadcast I-cache block invalidates, and the snoop controller only handles
the D-cache (though the same I/D race exists given that the I-cache doesn't
have any connection to the snoop controller).

You can get a bit of an overview in Documentation/cachetlb.txt if you're
interested in some of the requirements.
