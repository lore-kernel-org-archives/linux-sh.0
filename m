From: Simon Horman <horms@verge.net.au>
Date: Wed, 02 Sep 2015 02:14:56 +0000
Subject: Re: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <20150902021456.GE12080@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 28, 2015 at 04:21:14PM +0300, Sergei Shtylyov wrote:
> On 08/28/2015 01:30 PM, Sergei Shtylyov wrote:
> 
> >>>>>@@ -1688,6 +1712,16 @@ static int ravb_probe(struct platform_device *pdev)
> >>>>>      priv->avb_link_active_low > >>>>>          of_property_read_bool(np, "renesas,ether-link-active-low");
> >>>>>
> >>>>>+    if (of_device_is_compatible(np,
> >>>>>+                "renesas,etheravb-r8a7795")) {
> >>>>
> >>>>    Please respect the rules. And do you really need the break the line here?
> >>>>
> >>>>>+        irq = platform_get_irq(pdev, 1);
> >>>>>+        if (irq < 0) {
> >>>>>+            error = -ENODEV;
> >>>>
> >>>>    Please propagate the error instead.
> >
> >>>Sure, will do.
> >
> >>On closer examination the above is consistent with the existing
> >>error handling for another call to platform_get_irq() in the same function.
> >>Shall we fix that first?
> 
> >    Yes, and I'll look into that.
> 
>    Accidentally spotted the same error in sh_eth.c... really old one. :-)
> Will fix both.

Thanks, I see both of those changes went into net-next.
I'll update this patch accordingly.
