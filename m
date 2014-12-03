From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 03 Dec 2014 13:05:12 +0000
Subject: Re: sh: Support for multiple nodes.
Message-Id: <CAMuHMdVxCUYkaC5wzHi-o6knD6ugFudTdh3PJz5JCwv-std3GA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141203123954.GA16105@mwanda>
In-Reply-To: <20141203123954.GA16105@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Dan,

On Wed, Dec 3, 2014 at 1:39 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> The patch b241cb0c885e: "sh: Support for multiple nodes." from Jun 6,
> 2007, leads to the following static checker warning:
>
>         arch/sh/mm/numa.c:47 setup_bootmem_node()
>         error: buffer overflow 'node_data' 1024 <= 1024
>
> arch/sh/mm/numa.c
>     27  void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end)
>     28  {
>     29          unsigned long bootmap_pages;
>     30          unsigned long start_pfn, end_pfn;
>     31          unsigned long bootmem_paddr;
>     32
>     33          /* Don't allow bogus node assignment */
>     34          BUG_ON(nid > MAX_NUMNODES || nid <= 0);
>                        ^^^^^^^^^^^^^^^^^^
>
> It's not very important but this check is off by one so static checkers
> complain.

Thanks for your analysis!

Please note that sh is orphaned. Andrew Morton does accept patches.

>     35
>     36          start_pfn = start >> PAGE_SHIFT;
>     37          end_pfn = end >> PAGE_SHIFT;
>     38
>     39          pmb_bolt_mapping((unsigned long)__va(start), start, end - start,
>     40                           PAGE_KERNEL);
>     41
>     42          memblock_add(start, end - start);
>     43
>     44          __add_active_range(nid, start_pfn, end_pfn);
>     45
>     46          /* Node-local pgdat */
>     47          NODE_DATA(nid) = __va(memblock_alloc_base(sizeof(struct pglist_data),
>     48                                               SMP_CACHE_BYTES, end));
>     49          memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
>     50

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
