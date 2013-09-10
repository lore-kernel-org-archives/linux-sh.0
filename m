From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 10 Sep 2013 22:46:11 +0000
Subject: Re: [PATCH 3/5] i2c: rcar: add Device Tree support
Message-Id: <1460028.QECHppQ2H2@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1378742120-11135-1-git-send-email-g.liakhovetski@gmx.de> <1378742120-11135-4-git-send-email-g.liakhovetski@gmx.de> <CANqRtoTrCwd=+m6SPO2TqvvSjEO-m4uMrChxSYs_ZxniA-7dwQ@mail.gmail.com>
In-Reply-To: <CANqRtoTrCwd=+m6SPO2TqvvSjEO-m4uMrChxSYs_ZxniA-7dwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Simon Horman [Horms]" <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Hi Magnus,

On Wednesday 11 September 2013 07:40:54 Magnus Damm wrote:
> Hi Guennadi,
> 
> [CC Simon, Laurent]
> 
> On Tue, Sep 10, 2013 at 12:55 AM, Guennadi Liakhovetski wrote:
> > This patch adds Device Tree support to the i2c-rcar driver and respective
> > documentation.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> > 
> >  Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   22 +++++++++++++++
> >  drivers/i2c/busses/i2c-rcar.c                      |   20 ++++++++++++++-
> >  2 files changed, 40 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> > b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt new file mode 100644
> > index 0000000..b3c030b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> > @@ -0,0 +1,22 @@
> > +I2C for R-Car platforms
> > +
> > +Required properties:
> > +- compatible: Must be one of
> > +       "renesas,i2c-rcar"
> > +       "renesas,i2c-rcar-h1"
> > +       "renesas,i2c-rcar-h2"
> 
> Is this following the same style as other DT patches? It looks to me
> that you may want to use r8a7779 and r8a7790 instead of h1 and h2.
> 
> Simon, Laurent, what do you think about this?

I think that should be "renesas,i2c-r8a7779" and "renesas,i2c-r8a7790", yes.

-- 
Regards,

Laurent Pinchart

