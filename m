From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 29 Nov 2013 20:06:17 +0000
Subject: Re: [PATCH RESEND] gpio: rcar: Support both edge trigger with DT
Message-Id: <CACRpkdbkKR=ZpYe9K21daLGZr7+mM5suAWKpoSPjUOZqQc272w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1811469.aLo43mdTt2@avalon>
In-Reply-To: <1811469.aLo43mdTt2@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On Fri, Nov 29, 2013 at 2:48 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Some versions of the R-Car GPIO controller support triggering on both
> edges of the input signal. Whether this capability is supported is
> currently specified in platform data. R-Car GPIO devices instantiated
> from the device tree have the capability turned off even when the
> hardware supports it.
>
> To fix this, add DT match data support to the driver, initialize both
> edge trigger support from match data and enable both edge trigger in
> r8a7790 and r8a7791 match data.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Magnus Damm <damm@opensource.se>

Patch applied, but shouldn't there be some change to add these
new compatible strings to Documentation/devicetree/bindings/*
somewhere?

Accepted as follow-on patch or something to be squashed into
this later if I'm right.

Thanks!
Linus Walleij
