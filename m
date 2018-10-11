From: Christoph Hellwig <hch@lst.de>
Date: Thu, 11 Oct 2018 13:30:09 +0000
Subject: Re: [PATCH 1/5] mm/sparse: add common helper to mark all memblocks present
Message-Id: <20181011133009.GA7276@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20181005161642.2462-1-logang@deltatee.com>
 <20181005161642.2462-2-logang@deltatee.com>
In-Reply-To: <20181005161642.2462-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> +	for_each_memblock(memory, reg) {
> +		int nid = memblock_get_region_node(reg);
> +
> +		memory_present(nid, memblock_region_memory_base_pfn(reg),
> +			       memblock_region_memory_end_pfn(reg));

Any reason you have a local variable for the node id while you happily
get away without one for the others?  Why not simply:

	for_each_memblock(memory, reg) {
		memory_present(memblock_get_region_node(reg)
			       memblock_region_memory_base_pfn(reg),
			       memblock_region_memory_end_pfn(reg));
	}
