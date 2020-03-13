From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Mar 2020 14:52:53 +0000
Subject: Re: [PATCH] mm/memory_hotplug: add pgprot_t to mhp_params
Message-Id: <20200313145253.GA29117@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 13, 2020 at 04:10:21PM +1100, Logan Gunthorpe wrote:
> devm_memremap_pages() is currently used by the PCI P2PDMA code to create
> struct page mappings for IO memory.  At present, these mappings are
> created with PAGE_KERNEL which implies setting the PAT bits to be WB.
> However, on x86, an mtrr register will typically override this and force
> the cache type to be UC-.  In the case firmware doesn't set this register
> it is effectively WB and will typically result in a machine check
> exception when it's accessed.
> 
> Other arches are not currently likely to function correctly seeing they
> don't have any MTRR registers to fall back on.
> 
> To solve this, provide a way to specify the pgprot value explicitly to
> arch_add_memory().
> 
> Of the arches that support MEMORY_HOTPLUG: x86_64, and arm64 need a simple
> change to pass the pgprot_t down to their respective functions which set
> up the page tables.  For x86_32, set the page tables explicitly using
> _set_memory_prot() (seeing they are already mapped).  For ia64, s390 and
> sh, reject anything but PAGE_KERNEL settings -- this should be fine, for
> now, seeing these architectures don't support ZONE_DEVICE.
> 
> A check in __add_pages() is also added to ensure the pgprot parameter was
> set for all arches.
> 
...

> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index e5114c053364..b9de2d4fa57e 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -412,6 +412,9 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
>  	int ret;
>  
> +	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot)
> +		return -EINVAL;

Compile test ?

Guenter
