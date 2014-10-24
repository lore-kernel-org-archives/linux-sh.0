From: Simon Horman <horms@verge.net.au>
Date: Fri, 24 Oct 2014 02:15:16 +0000
Subject: Re: [PATCH] clocksource: sh_mtu2: Correct SoC family name
Message-Id: <20141024021513.GD7537@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1413969978-15946-1-git-send-email-geert+renesas@glider.be>
 <1593823.SBtdMLb0Ra@avalon>
In-Reply-To: <1593823.SBtdMLb0Ra@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Oct 22, 2014 at 06:00:19PM +0300, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Wednesday 22 October 2014 11:26:18 Geert Uytterhoeven wrote:
> > r7s72100 is a member of the RZ family, not of the R-Car family
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

My understanding is that mtu2 is an IP block that has been around
inside Renesas for quite some time and has a history of use
on the SH architecture as well as its more recent use on the r7s72100.

So perhaps "Renesas Multi-Function Timer Pulse Unit 2 (MTU2)"
would be (slightly) better.

> > ---
> >  Documentation/devicetree/bindings/timer/renesas,mtu2.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
> > b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt index
> > d9a8d5af1a21270f..55484a77a6ae54d0 100644
> > --- a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
> > +++ b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
> > @@ -1,4 +1,4 @@
> > -* Renesas R-Car Multi-Function Timer Pulse Unit 2 (MTU2)
> > +* Renesas RZ Multi-Function Timer Pulse Unit 2 (MTU2)
> > 
> >  The MTU2 is a multi-purpose, multi-channel timer/counter with configurable
> >  clock inputs and programmable compare match.
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
