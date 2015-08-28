From: Simon Horman <horms@verge.net.au>
Date: Fri, 28 Aug 2015 02:13:01 +0000
Subject: Re: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <20150828021300.GE7357@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 28, 2015 at 11:01:20AM +0900, Simon Horman wrote:
> On Thu, Aug 27, 2015 at 02:03:37PM +0300, Sergei Shtylyov wrote:
> > On 8/27/2015 12:24 PM, Simon Horman wrote:

[snip]

> > >@@ -1688,6 +1712,16 @@ static int ravb_probe(struct platform_device *pdev)
> > >  	priv->avb_link_active_low > > >  		of_property_read_bool(np, "renesas,ether-link-active-low");
> > >
> > >+	if (of_device_is_compatible(np,
> > >+				"renesas,etheravb-r8a7795")) {
> > 
> >    Please respect the rules. And do you really need the break the line here?
> > 
> > >+		irq = platform_get_irq(pdev, 1);
> > >+		if (irq < 0) {
> > >+			error = -ENODEV;
> > 
> >    Please propagate the error instead.
> 
> Sure, will do.

On closer examination the above is consistent with the existing
error handling for another call to platform_get_irq() in the same function.
Shall we fix that first?
