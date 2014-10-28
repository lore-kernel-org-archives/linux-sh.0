From: Michal Nazarewicz <mina86@mina86.com>
Date: Tue, 28 Oct 2014 12:38:20 +0000
Subject: Re: CMA: test_pages_isolated failures in alloc_contig_range
Message-Id: <xa1tsii8l683.fsf@mina86.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2457604.k03RC2Mv4q@avalon>
In-Reply-To: <2457604.k03RC2Mv4q@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Minchan Kim <minchan@kernel.org>

On Sun, Oct 26 2014, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> Hello,
>
> I've run into a CMA-related issue while testing a DMA engine driver with 
> dmatest on a Renesas R-Car ARM platform. 
>
> When allocating contiguous memory through CMA the kernel prints the following 
> messages to the kernel log.
>
> [   99.770000] alloc_contig_range test_pages_isolated(6b843, 6b844) failed
> [  124.220000] alloc_contig_range test_pages_isolated(6b843, 6b844) failed
> [  127.550000] alloc_contig_range test_pages_isolated(6b845, 6b846) failed
> [  132.850000] alloc_contig_range test_pages_isolated(6b845, 6b846) failed
> [  151.390000] alloc_contig_range test_pages_isolated(6b843, 6b844) failed
> [  166.490000] alloc_contig_range test_pages_isolated(6b843, 6b844) failed
> [  181.450000] alloc_contig_range test_pages_isolated(6b845, 6b846) failed
>
> I've stripped the dmatest module down as much as possible to remove any 
> hardware dependencies and came up with the following implementation.

Like Laura wrote, the message is not (should not be) a problem in
itself:

mm/page_alloc.c:

int alloc_contig_range(unsigned long start, unsigned long end,
		       unsigned migratetype)
{
	[…]
	/* Make sure the range is really isolated. */
	if (test_pages_isolated(outer_start, end, false)) {
		pr_warn("alloc_contig_range test_pages_isolated(%lx, %lx) failed\n",
		       outer_start, end);
		ret = -EBUSY;
		goto done;
	}
	[…]
done:
	undo_isolate_page_range(pfn_max_align_down(start),
				pfn_max_align_up(end), migratetype);
	return ret;
}

mm/cma.c:

struct page *cma_alloc(struct cma *cma, int count, unsigned int align)
{
	[…]
	for (;;) {
		bitmap_no = bitmap_find_next_zero_area(cma->bitmap,
				bitmap_maxno, start, bitmap_count, mask);
		if (bitmap_no >= bitmap_maxno)
			break;
		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);

		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA);
		if (ret = 0) {
			page = pfn_to_page(pfn);
			break;
		}

		cma_clear_bitmap(cma, pfn, count);
		if (ret != -EBUSY)
			break;

		pr_debug("%s(): memory range at %p is busy, retrying\n",
			 __func__, pfn_to_page(pfn));
		/* try again with a bit different memory target */
		start = bitmap_no + mask + 1;
	}
	[…]
}

So as you can see cma_alloc will try another part of the cma region if
test_pages_isolated fails.

Obviously, if CMA region is fragmented or there's enough space for only
one allocation of required size isolation failures will cause allocation
failures, so it's best to avoid them, but they are not always avoidable.

To debug you would probably want to add more debug information about the
page (i.e. data from struct page) that failed isolation after the
pr_warn in alloc_contig_range.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michał “mina86” Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
