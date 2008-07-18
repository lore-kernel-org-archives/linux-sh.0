From: Ben Dooks <ben-linux@fluff.org>
Date: Fri, 18 Jul 2008 07:54:26 +0000
Subject: Re: [PATCH 01/05] resource: add resource_size()
Message-Id: <20080718075426.GK24620@fluff.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20080718074002.32713.73442.sendpatchset@rx1.opensource.se> <20080718074010.32713.22016.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080718074010.32713.22016.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, gregkh@suse.de, lethal@linux-sh.org, i2c@lm-sensors.org, akpm@linux-foundation.org

On Fri, Jul 18, 2008 at 04:40:10PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Avoid one-off errors by introducing a resource_size() function.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

A resource_size definition is a good idea, given the number of
times it has been re-implemented throughout the kernel.

> ---
> 
>  include/linux/ioport.h |    4 ++++
>  kernel/resource.c      |    2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> --- 0001/include/linux/ioport.h
> +++ work/include/linux/ioport.h	2008-07-09 12:59:04.000000000 +0900
> @@ -113,6 +113,10 @@ extern int allocate_resource(struct reso
>  int adjust_resource(struct resource *res, resource_size_t start,
>  		    resource_size_t size);
>  resource_size_t resource_alignment(struct resource *res);
> +static inline resource_size_t resource_size(struct resource *res)
> +{
> +	return res->end - res->start + 1;
> +}
>  
>  /* Convenience shorthand with allocation */
>  #define request_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name))
> --- 0001/kernel/resource.c
> +++ work/kernel/resource.c	2008-07-09 12:59:41.000000000 +0900
> @@ -490,7 +490,7 @@ resource_size_t resource_alignment(struc
>  {
>  	switch (res->flags & (IORESOURCE_SIZEALIGN | IORESOURCE_STARTALIGN)) {
>  	case IORESOURCE_SIZEALIGN:
> -		return res->end - res->start + 1;
> +		return resource_size(res);
>  	case IORESOURCE_STARTALIGN:
>  		return res->start;
>  	default:
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
