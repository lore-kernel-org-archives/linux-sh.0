From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 23 Oct 2015 12:37:46 +0000
Subject: Re: [PATCH/RFC 2/6] boot-mode-reg: Add R-Car Gen2 driver
Message-Id: <2157707.UQhANlESBt@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thursday 15 October 2015 16:59:18 Simon Horman wrote:
> On Thu, Oct 15, 2015 at 09:09:13AM +0200, Geert Uytterhoeven wrote:
> > On Thu, Oct 15, 2015 at 8:59 AM, Simon Horman wrote:
> >> --- /dev/null
> >> +++ b/drivers/misc/boot-mode-reg/rcar-gen2.c
> >> @@ -0,0 +1,61 @@
> >> +/*
> >> + * R-Car Gen2 Boot Mode Register Driver
> >> 
> >> +#define MODEMR 0xe6160060
> > 
> > Shouldn't this come from DT?
> 
> If its a property of the SoC then I'm not sure that it needs to as its a
> known value for the supported SoCs.

Hypervisors (at least Xen) use DT to initialize memory mappings. I believe we 
should thus describe the RST IP in DT and create an rcar-rst driver that 
includes the code from this patch.

> >> +static int __init rcar_gen2_read_mode_pins(void)
> >> +{
> >> +       void __iomem *modemr;
> >> +       int err = -ENOMEM;
> >> +       static u32 mode;
> >> +
> >> +       modemr = ioremap_nocache(MODEMR, 4);
> >> +       if (!modemr) {
> >> +               pr_err("failed to map boot mode register");
> >> +               goto err;
> >> +       }
> >> +       mode = ioread32(modemr);
> >> +       iounmap(modemr);
> >> +
> >> +       err = boot_mode_reg_set(mode);
> >> +err:
> >> +       if (err)
> >> +               pr_err("failed to initialise boot mode");
> >> +       return err;
> >> +}
> >> 
> >> --- a/include/misc/boot-mode-reg.h
> >> +++ b/include/misc/boot-mode-reg.h
> >> @@ -21,4 +21,7 @@
> >>  int boot_mode_reg_get(u32 *mode);
> >>  int boot_mode_reg_set(u32 mode);
> >> 
> >> +/* Allow explicit initialisation before initcalls */
> >> +int rcar_gen2_init_boot_mode(void);
> > 
> > When using explicit initialisation before initcalls, the second call will
> > trigger a new ioremap/ioread32/iounmap cycle.
> 
> Thanks, I'll fix that.

-- 
Regards,

Laurent Pinchart

