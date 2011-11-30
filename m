From: phil.edworthy@renesas.com
Date: Wed, 30 Nov 2011 09:56:35 +0000
Subject: Re: [PATCH] sh: sh2a: Optimise cache flush for writethrough mode.
Message-Id: <OFFAFC5D77.02F438E3-ON80257958.0033B1B4-80257958.00366CBB@eu.necel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1322637713-15227-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1322637713-15227-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

> Subject: Re: [PATCH] sh: sh2a: Optimise cache flush for writethrough 
mode.
> 
> On Wed, Nov 30, 2011 at 07:21:53AM +0000, Phil Edworthy wrote:
> > When the operand cache is set to writethough mode, there is no
> > need to flush data.
> > 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> What about the other routines?
> 
> You are presumably stipulating that any access to the OC address array
> outside of cacheline invalidation should be omitted for write-through
> cache mode, which suggests that quite a lot of the file in question can
> simply be nopped out.
> 
> At the very least sh2a__flush_wback_region() could deal with the same
> treatment. For the invalidation routines you presumably still need the
> V-bit clearing, though.
> 
> sh2a__flush_invalidate_region() also bears closer inspection.

It's worth mentioning that this patch is essentially a work around for an 
issue with write-back mode. sh2a_flush_icache_range is passed a large 
address range which takes ages to flush/invalidate. For write-back mode, 
instead of indexing on the address, perhaps we can walk through all the 
cache entries and check for an address match. That's for another day...

I agree that the other functions can be improved. I ignored them as the 
main performance issue is with sh2a_flush_icache_range. I wasn't entirely 
sure when some of the other functions are used. Are 
sh2a__flush_wback_region and sh2a__flush_purge_region purely OC related? 
And sh2a__flush_invalidate_region and sh2a_flush_icache_range work on both 
the IC and OC?

Phil
