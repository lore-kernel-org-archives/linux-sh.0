From: Simon Horman <horms@verge.net.au>
Date: Wed, 23 Apr 2014 01:40:10 +0000
Subject: Re: [PATCH] clk: Improve clock-indices binding documentation
Message-Id: <20140423014009.GA20199@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1397494840-22420-1-git-send-email-geert@linux-m68k.org>
 <21852545.7Zg9c00i3i@avalon>
In-Reply-To: <21852545.7Zg9c00i3i@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Mike Turquette <mturquette@linaro.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On Tue, Apr 15, 2014 at 05:56:12PM +0200, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Monday 14 April 2014 19:00:40 Geert Uytterhoeven wrote:
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > Improve the wording for the clock-indices binding documentation.
> > Also replace "empty nodes" by "empty strings", as reported before by Sergei
> > Shtylyov.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

Mike, could you consider picking this up?

> 
> > ---
> >  .../devicetree/bindings/clock/clock-bindings.txt   |    9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > b/Documentation/devicetree/bindings/clock/clock-bindings.txt index
> > 700e7aac3717..f15787817d6b 100644
> > --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > @@ -44,10 +44,9 @@ For example:
> >    clocks by index. The names should reflect the clock output signal
> >    names for the device.
> > 
> > -clock-indices:	   If the identifyng number for the clocks in the node
> > -		   is not linear from zero, then the this mapping allows
> > -		   the mapping of identifiers into the clock-output-names
> > -		   array.
> > +clock-indices:	   If the identifying number for the clocks in the node
> > +		   is not linear from zero, then this allows the mapping of
> > +		   identifiers into the clock-output-names array.
> > 
> >  For example, if we have two clocks <&oscillator 1> and <&oscillator 3>:
> > 
> > @@ -58,7 +57,7 @@ For example, if we have two clocks <&oscillator 1> and
> > <&oscillator 3>: clock-output-names = "clka", "clkb";
> >  	}
> > 
> > -	This ensures we do not have any empty nodes in clock-output-names
> > +	This ensures we do not have any empty strings in clock-output-names
> > 
> > 
> >  =Clock consumers=
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
