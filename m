From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 09 Oct 2009 02:37:24 +0000
Subject: Re: [PATCH 01/14] sh: Sprinkle __uses_jump_to_uncached
Message-Id: <20091009023724.GA7179@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1db0a1123393575aec324e0d808b6369f9837fe4.1254861984.git.matt@console-pimps.org>
In-Reply-To: <1db0a1123393575aec324e0d808b6369f9837fe4.1254861984.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 06, 2009 at 10:22:21PM +0100, Matt Fleming wrote:
> Fix some callers of jump_to_uncached() and back_to_cached() that were
> not annotated with __uses_jump_to_uncached.

On Tue, Oct 06, 2009 at 10:22:22PM +0100, Matt Fleming wrote:
> If we fail to allocate a PMB entry in pmb_remap() we must remember to
> clear and free any PMB entries that we may have previously allocated,
> e.g. if we were allocating a multiple entry mapping.

On Tue, Oct 06, 2009 at 10:22:27PM +0100, Matt Fleming wrote:
> We should favour PMB mappings when the physical address cannot be
> reached with 29-bits.

On Tue, Oct 06, 2009 at 10:22:34PM +0100, Matt Fleming wrote:
> Currently, we've got the less than ideal situation where if we need to
> allocate a 256MB mapping we'll allocate four entries like so,
> 
> 	 entry 1: 128MB
> 	 entry 2:  64MB
> 	 entry 3:  16MB
> 	 entry 4:  16MB
> 
> This is because as we execute the loop in pmb_remap() we will
> progressively try mapping the remaining address space with smaller and
> smaller sizes. This isn't good because the size we use on one iteration
> may be the perfect size to use on the next iteration, for instance when
> the initial size is divisible by one of the PMB mapping sizes.
> 
> With this patch, we now only need two entries in the PMB to map 256MB of
> address space,
> 
> 	  entry 1: 128MB
> 	  entry 2: 128MB
> 

These are all good fixups that are fairly orthogonal to the rest of the
changes, so I've merged these as fixups for 2.6.32. The others we'll deal
with incrementally once I open the tree for 2.6.33 changes.
