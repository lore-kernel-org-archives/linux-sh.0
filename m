From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 28 Oct 2014 18:59:58 +0000
Subject: Re: CMA: test_pages_isolated failures in alloc_contig_range
Message-Id: <1703418.04z9xDaRPF@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <2457604.k03RC2Mv4q@avalon> <xa1tsii8l683.fsf@mina86.com> <544F9EAA.5010404@hurleysoftware.com>
In-Reply-To: <544F9EAA.5010404@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Michal Nazarewicz <mina86@mina86.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Hello,

On Tuesday 28 October 2014 09:48:26 Peter Hurley wrote:
> [ +cc Andrew Morton ]
> 
> On 10/28/2014 08:38 AM, Michal Nazarewicz wrote:
> > On Sun, Oct 26 2014, Laurent Pinchart wrote:
> >> Hello,
> >> 
> >> I've run into a CMA-related issue while testing a DMA engine driver with
> >> dmatest on a Renesas R-Car ARM platform.
> >> 
> >> When allocating contiguous memory through CMA the kernel prints the
> >> following messages to the kernel log.
> >> 
> >> [   99.770000] alloc_contig_range test_pages_isolated(6b843, 6b844)
> >> failed
> >> [  124.220000] alloc_contig_range test_pages_isolated(6b843, 6b844)
> >> failed
> >> [  127.550000] alloc_contig_range test_pages_isolated(6b845, 6b846)
> >> failed
> >> [  132.850000] alloc_contig_range test_pages_isolated(6b845, 6b846)
> >> failed
> >> [  151.390000] alloc_contig_range test_pages_isolated(6b843, 6b844)
> >> failed
> >> [  166.490000] alloc_contig_range test_pages_isolated(6b843, 6b844)
> >> failed
> >> [  181.450000] alloc_contig_range test_pages_isolated(6b845, 6b846)
> >> failed
> >> 
> >> I've stripped the dmatest module down as much as possible to remove any
> >> hardware dependencies and came up with the following implementation.
> > 
> > Like Laura wrote, the message is not (should not be) a problem in
> > itself:
>
> [...]
> 
> > So as you can see cma_alloc will try another part of the cma region if
> > test_pages_isolated fails.
> > 
> > Obviously, if CMA region is fragmented or there's enough space for only
> > one allocation of required size isolation failures will cause allocation
> > failures, so it's best to avoid them, but they are not always avoidable.
> > 
> > To debug you would probably want to add more debug information about the
> > page (i.e. data from struct page) that failed isolation after the
> > pr_warn in alloc_contig_range.

[   94.730000] __test_page_isolated_in_pageblock: failed at pfn 6b845: buddy 0 
count 0 migratetype 4 poison 0
[   94.740000] alloc_contig_range test_pages_isolated(6b845, 6b846) failed 
(-16)
[  202.140000] __test_page_isolated_in_pageblock: failed at pfn 6b843: buddy 0 
count 0 migratetype 4 poison 0
[  202.150000] alloc_contig_range test_pages_isolated(6b843, 6b844) failed 
(-16)

(4 is MIGRATE_CMA)

> If the message does not indicate an actual problem, then its printk level is
> too high. These messages have been reported when using 3.16+ distro kernels.

The messages got me worried, and if there's nothing to worry about, that's bad 
:-)

-- 
Regards,

Laurent Pinchart

