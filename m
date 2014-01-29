From: Simon Horman <horms@verge.net.au>
Date: Wed, 29 Jan 2014 06:22:12 +0000
Subject: Re: [PATCH] phy-rcar-usb-gen2: add device tree support
Message-Id: <20140129062212.GD23833@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1390754945-28142-6-git-send-email-ben.dooks@codethink.co.uk>
 <1390755901-3743-1-git-send-email-ben.dooks@codethink.co.uk>
 <52E6A436.5090408@cogentembedded.com>
 <52E6AE32.5050906@codethink.co.uk>
In-Reply-To: <52E6AE32.5050906-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Jan 27, 2014 at 07:06:26PM +0000, Ben Dooks wrote:
> On 27/01/14 18:23, Sergei Shtylyov wrote:
> >Hello.
> >
> >On 01/26/2014 08:05 PM, Ben Dooks wrote:
> 
> [snip]
> 
> >>
> >>+static struct of_device_id rcar_gen2_usb_phy_ofmatch[] = {
> >>+    { .compatible = "renesas,usb-phy-r8a7790", },
> >>+    { .compatible = "renesas,rcar-gen2-usb-phy", },
> >
> >    Frankly speaking, I don't understand the need for the clearly
> >duplicate entries.
> 
> Thanks, will look into remove it.
> Anyone else have any comments on this?

I would like you to leave it there.

As we know the r8a7790 is an R-Car Gen2 SoC.  But there are other R-Car
Gen2 SoCs, such as the r8a7791, they it could plausibly make use of
rcar-gen2-usb-phy until the driver is updated with a usb-phy-r8a7791 entry.
