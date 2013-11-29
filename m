From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 29 Nov 2013 20:15:31 +0000
Subject: Re: [PATCH RESEND] gpio: rcar: Support both edge trigger with DT
Message-Id: <1417900.1xZ6mx4xL8@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1811469.aLo43mdTt2@avalon> <CACRpkdbkKR=ZpYe9K21daLGZr7+mM5suAWKpoSPjUOZqQc272w@mail.gmail.com>
In-Reply-To: <CACRpkdbkKR=ZpYe9K21daLGZr7+mM5suAWKpoSPjUOZqQc272w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

Hi Linus,

On Friday 29 November 2013 21:06:17 Linus Walleij wrote:
> On Fri, Nov 29, 2013 at 2:48 PM, Laurent Pinchart wrote:
> > Some versions of the R-Car GPIO controller support triggering on both
> > edges of the input signal. Whether this capability is supported is
> > currently specified in platform data. R-Car GPIO devices instantiated
> > from the device tree have the capability turned off even when the
> > hardware supports it.
> > 
> > To fix this, add DT match data support to the driver, initialize both
> > edge trigger support from match data and enable both edge trigger in
> > r8a7790 and r8a7791 match data.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > Acked-by: Magnus Damm <damm@opensource.se>
> 
> Patch applied, but shouldn't there be some change to add these
> new compatible strings to Documentation/devicetree/bindings/*
> somewhere?

You're right.

> Accepted as follow-on patch or something to be squashed into
> this later if I'm right.

Sent.

-- 
Regards,

Laurent Pinchart

