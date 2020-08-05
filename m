From: kernel test robot <lkp@intel.com>
Date: Wed, 05 Aug 2020 17:16:25 +0000
Subject: Re: [PATCH v10 07/11] device-mapping: Introduce DMA range map, supplanting dma_pfn_offset
Message-Id: <202008060101.fwG2S6hX%lkp@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200803194529.32357-8-james.quinlan@broadcom.com>
In-Reply-To: <20200803194529.32357-8-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, bcm-kernel-feedback-list@broadcom.com
Cc: kbuild-all@lists.01.org, Rich Felker <dalias@libc.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>, Hanjun Guo <guohanjun@huawei.com>

Hi Jim,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on sunxi/sunxi/for-next linuxtv-media/master usb/usb-testing v5.8]
[cannot apply to robh/for-next linus/master next-20200805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jim-Quinlan/PCI-brcmstb-enable-PCIe-for-STB-chips/20200804-034755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/of/address.c:996:6: warning: Variable 'ret' is reassigned a value before the old one has been used. [redundantAssignment]
    ret = 0;
        ^
   drivers/of/address.c:978:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = -ENOMEM;
        ^
   drivers/of/address.c:996:6: note: Variable 'ret' is reassigned a value before the old one has been used.
    ret = 0;
        ^

vim +/ret +996 drivers/of/address.c

   920	
   921	#ifdef CONFIG_HAS_DMA
   922	/**
   923	 * of_dma_get_range - Get DMA range info and put it into a map array
   924	 * @np:		device node to get DMA range info
   925	 * @map:	dma range structure to return
   926	 *
   927	 * Look in bottom up direction for the first "dma-ranges" property
   928	 * and parse it.  Put the information into a DMA offset map array.
   929	 *
   930	 * dma-ranges format:
   931	 *	DMA addr (dma_addr)	: naddr cells
   932	 *	CPU addr (phys_addr_t)	: pna cells
   933	 *	size			: nsize cells
   934	 *
   935	 * It returns -ENODEV if "dma-ranges" property was not found for this
   936	 * device in the DT.
   937	 */
   938	int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
   939	{
   940		struct device_node *node = of_node_get(np);
   941		const __be32 *ranges = NULL;
   942		bool found_dma_ranges = false;
   943		struct of_range_parser parser;
   944		struct of_range range;
   945		struct bus_dma_region *r;
   946		int len, num_ranges = 0;
   947		int ret;
   948	
   949		while (node) {
   950			ranges = of_get_property(node, "dma-ranges", &len);
   951	
   952			/* Ignore empty ranges, they imply no translation required */
   953			if (ranges && len > 0)
   954				break;
   955	
   956			/* Once we find 'dma-ranges', then a missing one is an error */
   957			if (found_dma_ranges && !ranges) {
   958				ret = -ENODEV;
   959				goto out;
   960			}
   961			found_dma_ranges = true;
   962	
   963			node = of_get_next_dma_parent(node);
   964		}
   965	
   966		if (!node || !ranges) {
   967			pr_debug("no dma-ranges found for node(%pOF)\n", np);
   968			ret = -ENODEV;
   969			goto out;
   970		}
   971	
   972		of_dma_range_parser_init(&parser, node);
   973		for_each_of_range(&parser, &range)
   974			num_ranges++;
   975	
   976		of_dma_range_parser_init(&parser, node);
   977	
   978		ret = -ENOMEM;
   979		r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
   980		if (!r)
   981			goto out;
   982	
   983		/*
   984		 * Record all info in the generic DMA ranges array for struct device.
   985		 */
   986		*map = r;
   987		for_each_of_range(&parser, &range) {
   988			pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
   989				 range.bus_addr, range.cpu_addr, range.size);
   990			r->cpu_start = range.cpu_addr;
   991			r->dma_start = range.bus_addr;
   992			r->size = range.size;
   993			r->offset = (u64)range.cpu_addr - (u64)range.bus_addr;
   994			r++;
   995		}
 > 996		ret = 0;
   997	
   998	out:
   999		of_node_put(node);
  1000		return ret;
  1001	}
  1002	#endif
  1003	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
