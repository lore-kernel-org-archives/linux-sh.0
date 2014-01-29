From: Simon Horman <horms@verge.net.au>
Date: Wed, 29 Jan 2014 12:22:02 +0000
Subject: Re: [PATCH] phy-rcar-usb-gen2: add device tree support
Message-Id: <20140129122202.GB26253@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1390754945-28142-6-git-send-email-ben.dooks@codethink.co.uk>
 <1390755901-3743-1-git-send-email-ben.dooks@codethink.co.uk>
 <52E6A436.5090408@cogentembedded.com>
 <52E6AE32.5050906@codethink.co.uk>
 <20140129062212.GD23833@verge.net.au>
 <52E8DAF6.5090105@cogentembedded.com>
In-Reply-To: <52E8DAF6.5090105@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org

On Wed, Jan 29, 2014 at 02:41:58PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 29-01-2014 10:22, Simon Horman wrote:
> 
> >>[snip]
> 
> >>>>+static struct of_device_id rcar_gen2_usb_phy_ofmatch[] = {
> >>>>+    { .compatible = "renesas,usb-phy-r8a7790", },
> >>>>+    { .compatible = "renesas,rcar-gen2-usb-phy", },
> 
> >>>    Frankly speaking, I don't understand the need for the clearly
> >>>duplicate entries.
> 
> >>Thanks, will look into remove it.
> >>Anyone else have any comments on this?
> 
> >I would like you to leave it there.
> 
> >As we know the r8a7790 is an R-Car Gen2 SoC.  But there are other R-Car
> >Gen2 SoCs, such as the r8a7791, they it could plausibly make use of
> >rcar-gen2-usb-phy until the driver is updated with a usb-phy-r8a7791 entry.
> 
>    Why not just "update" the driver this way now, may I ask?

Because I don't believe that Ben has access to r8a7791 hardware
to test the change and thus it makes sense to handle it separately.
