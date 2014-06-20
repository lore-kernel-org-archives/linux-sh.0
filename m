From: Paul Bolle <pebolle@tiscali.nl>
Date: Fri, 20 Jun 2014 08:22:20 +0000
Subject: Re: [PATCH v3 01/05] staging: emxx_udc: Add Emma Mobile USB Gadget driver
Message-Id: <1403252540.22857.20.camel@x220>
List-Id: <linux-sh.vger.kernel.org>
References: <20140606104408.4423.36098.sendpatchset@w520>
	 <20140606104417.4423.38999.sendpatchset@w520>
In-Reply-To: <20140606104417.4423.38999.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, olof@lixom.net, dan.carpenter@oracle.com

Magnus,

On Fri, 2014-06-06 at 19:44 +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Add the emxx_udc driver to staging based on an old linux-2.6.35.7 
> android tree. The driver has been brushed up slightly to complile
> but it is still in great need of cleanup.
> 
> At this point DT bindings are clearly lacking and I doubt that the
> driver even can run with multiple instances (global variables, hurray!).
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---

This patch appeared in linux-next (ie, next-20140620).

>[...]
> --- /dev/null
> +++ work/drivers/staging/emxx_udc/emxx_udc.h	2014-05-22 12:21:03.000000000 +0900
> @@ -0,0 +1,662 @@
>[...]
> +/*------- (0x1010) EPCTR Register */
> +#define DIRPD				BIT12		/* RW */
> +
> +#define VBUS_LEVEL			BIT08		/* R */
> +
> +#define PLL_RESUME			BIT05		/* RW */
> +#define PLL_LOCK			BIT04		/* R */
> +
> +#ifdef CONFIG_MACH_EMGR
> +#define PLL_RST				BIT02		/* RW */
> +#endif

There's no Kconfig symbol MACH_EMGR. There's also no preprocessor define
of CONFIG_MACH_EMGR. Even web searches didn't tell me what MACH_EMGR
could be. Anyhow, this check always evaluates to false. Should I draft a
trivial patch to remove it?

But PLL_RST is unused too. Would you like to keep it?

(I didn't catch this when I first received this patch. One needs to
parse the entire tree to find stuff like this, and there are way too
many patchsets flying by to do treewide searches for all of them. So I
just try to keep up with linux-next, to at least catch things before
they enter mainline.)


Paul Bolle

