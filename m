From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 28 Oct 2014 15:12:14 +0000
Subject: Re: CMA: test_pages_isolated failures in alloc_contig_range
Message-Id: <8295446.YZpkE7ns4p@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <2457604.k03RC2Mv4q@avalon> <544EAD3B.6070102@codeaurora.org>
In-Reply-To: <544EAD3B.6070102@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laura Abbott <lauraa@codeaurora.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Minchan Kim <minchan@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>

Hi Laura,

On Monday 27 October 2014 13:38:19 Laura Abbott wrote:
> On 10/26/2014 2:09 PM, Laurent Pinchart wrote:
> > Hello,
> > 
> > I've run into a CMA-related issue while testing a DMA engine driver with
> > dmatest on a Renesas R-Car ARM platform.
> > 
> > When allocating contiguous memory through CMA the kernel prints the
> > following messages to the kernel log.
> > 
> > [   99.770000] alloc_contig_range test_pages_isolated(6b843, 6b844) failed
> > [  124.220000] alloc_contig_range test_pages_isolated(6b843, 6b844) failed
> > [  127.550000] alloc_contig_range test_pages_isolated(6b845, 6b846) failed
> > [  132.850000] alloc_contig_range test_pages_isolated(6b845, 6b846) failed
> > [  151.390000] alloc_contig_range test_pages_isolated(6b843, 6b844) failed
> > [  166.490000] alloc_contig_range test_pages_isolated(6b843, 6b844) failed
> > [  181.450000] alloc_contig_range test_pages_isolated(6b845, 6b846) failed
> > 
> > I've stripped the dmatest module down as much as possible to remove any
> > hardware dependencies and came up with the following implementation.
> 
> ...
> 
> > Loading the module will start 4 threads that will allocate and free DMA
> > coherent memory in a tight loop and eventually produce the error. It seems
> > like the probability of occurrence grows with the number of threads, which
> > could indicate a race condition.
> > 
> > The tests have been run on 3.18-rc1, but previous tests on 3.16 did
> > exhibit the same behaviour.
> > 
> > I'm not that familiar with the CMA internals, help would be appreciated to
> > debug the problem.
> 
> Are you actually seeing allocation failures or is it just the messages?

It's just the messages, I haven't noticed allocation failures.

> The messages themselves may be harmless if the allocation is succeeding.
> It's an indication that the particular range could not be isolated and
> therefore another range should be used for the CMA allocation. Joonsoo
> Kim had a patch series[1] that was designed to correct some problems with
> isolation and from my testing it helps fix some CMA related errors. You
> might try picking that up to see if it helps.
> 
> Thanks,
> Laura
> 
> [1] https://lkml.org/lkml/2014/10/23/90

I've tested the patches but they don't seem to have any influence on the 
isolation test failures.

-- 
Regards,

Laurent Pinchart
