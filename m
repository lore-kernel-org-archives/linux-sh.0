From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 03 Dec 2014 12:39:55 +0000
Subject: re: sh: Support for multiple nodes.
Message-Id: <20141203123954.GA16105@mwanda>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Paul Mundt,

The patch b241cb0c885e: "sh: Support for multiple nodes." from Jun 6,
2007, leads to the following static checker warning:

	arch/sh/mm/numa.c:47 setup_bootmem_node()
	error: buffer overflow 'node_data' 1024 <= 1024

arch/sh/mm/numa.c
    27  void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end)
    28  {
    29          unsigned long bootmap_pages;
    30          unsigned long start_pfn, end_pfn;
    31          unsigned long bootmem_paddr;
    32  
    33          /* Don't allow bogus node assignment */
    34          BUG_ON(nid > MAX_NUMNODES || nid <= 0);
                       ^^^^^^^^^^^^^^^^^^

It's not very important but this check is off by one so static checkers
complain.

    35  
    36          start_pfn = start >> PAGE_SHIFT;
    37          end_pfn = end >> PAGE_SHIFT;
    38  
    39          pmb_bolt_mapping((unsigned long)__va(start), start, end - start,
    40                           PAGE_KERNEL);
    41  
    42          memblock_add(start, end - start);
    43  
    44          __add_active_range(nid, start_pfn, end_pfn);
    45  
    46          /* Node-local pgdat */
    47          NODE_DATA(nid) = __va(memblock_alloc_base(sizeof(struct pglist_data),
    48                                               SMP_CACHE_BYTES, end));
    49          memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
    50  

regards,
dan carpenter
