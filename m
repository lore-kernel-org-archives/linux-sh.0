From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 10 Feb 2010 12:55:14 +0000
Subject: Re: [PATCH] sh: extend INTC with optional ioremap() support
Message-Id: <20100210125514.GB907@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100210111739.11145.92334.sendpatchset@rxone.opensource.se>
In-Reply-To: <20100210111739.11145.92334.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 10, 2010 at 08:17:39PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add the member "io_window" to intc_desc to allow
> passing a physical memory window to the INTC code.
> The INTC code will ioremap the window if present.
> 
> Required to support INTCS on SH-Mobile G-series.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  drivers/sh/intc.c       |   14 ++++++++++++++
>  include/linux/sh_intc.h |    3 +++
>  2 files changed, 17 insertions(+)
> 
> --- 0006/drivers/sh/intc.c
> +++ work/drivers/sh/intc.c	2010-02-10 19:31:14.000000000 +0900
> @@ -45,6 +45,8 @@ struct intc_handle_int {
>  
>  struct intc_desc_int {
>  	struct list_head list;
> +	unsigned long virt_base;
> +	unsigned long phys_base;
>  	struct sys_device sysdev;
>  	pm_message_t state;
>  	unsigned long *reg;

phys_base can be a phys_addr_t, while virt_base wants to be a
void __iomem *.

> @@ -800,6 +808,12 @@ void __init register_intc_controller(str
>  	INIT_LIST_HEAD(&d->list);
>  	list_add(&d->list, &intc_list);
>  
> +	if (desc->io_window) {
> +		d->phys_base = desc->io_window->start;
> +		d->virt_base = (unsigned long)ioremap_nocache(d->phys_base,
> +					       resource_size(desc->io_window));
> +	}
> +
Error handling?

> --- 0006/include/linux/sh_intc.h
> +++ work/include/linux/sh_intc.h	2010-02-10 19:31:14.000000000 +0900
> @@ -71,6 +73,7 @@ struct intc_hw_desc {
>  
>  struct intc_desc {
>  	char *name;
> +	struct resource *io_window;
>  	intc_enum force_enable;
>  	struct intc_hw_desc hw;
>  };

io_window is pretty much completely lacking in meaning. Why does this
platform want to pass in a resource that gets remapped while others do
not?

This all looks terribly fragile. You're basically counting on the fact
that all addresses are going to be covered by this window, which seems
like a pretty lofty assumption given how some of the INTC2 registers were
mapped out. It's also pretty ambiguous, given that this is obviously a
an MMIO resource yet is named like a PIO one.

Special casing the remapping is really just crap. Each of the register
ranges wants to be remapped, while on SH given that these are in the P4
space nothing of much note will happen. You are better off throwing in
void __iomem * pointers for each of the register ranges that you are
passing in and permit the data structures to use offsets in to that. This
can be done incrementally for the SH parts, since remapping isn't going
to change the underlying address.
