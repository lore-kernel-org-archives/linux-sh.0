From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 11 Sep 2013 07:37:52 +0000
Subject: Re: [PATCH 3/5] i2c: rcar: add Device Tree support
Message-Id: <Pine.LNX.4.64.1309110921270.26942@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1378742120-11135-1-git-send-email-g.liakhovetski@gmx.de>
 <1378742120-11135-4-git-send-email-g.liakhovetski@gmx.de>
 <CANqRtoTrCwd=+m6SPO2TqvvSjEO-m4uMrChxSYs_ZxniA-7dwQ@mail.gmail.com>
 <1460028.QECHppQ2H2@avalon> <CANqRtoRXByHeJP==qbk-VH7HgGBN9MWE1eE1nL88jfYhF1uOXg@mail.gmail.com>
In-Reply-To: <CANqRtoRXByHeJP==qbk-VH7HgGBN9MWE1eE1nL88jfYhF1uOXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, "Simon Horman [Horms]" <horms@verge.net.au>

Hi Magnus, Laurent

On Wed, 11 Sep 2013, Magnus Damm wrote:

> Hi Laurent,
> 
> On Wed, Sep 11, 2013 at 7:46 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > Hi Magnus,
> >
> > On Wednesday 11 September 2013 07:40:54 Magnus Damm wrote:
> >> Hi Guennadi,
> >>
> >> [CC Simon, Laurent]
> >>
> >> On Tue, Sep 10, 2013 at 12:55 AM, Guennadi Liakhovetski wrote:
> >> > This patch adds Device Tree support to the i2c-rcar driver and respective
> >> > documentation.
> >> >
> >> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> >> > ---
> >> >
> >> >  Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   22 +++++++++++++++
> >> >  drivers/i2c/busses/i2c-rcar.c                      |   20 ++++++++++++++-
> >> >  2 files changed, 40 insertions(+), 2 deletions(-)
> >> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> >> > b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt new file mode 100644
> >> > index 0000000..b3c030b
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> >> > @@ -0,0 +1,22 @@
> >> > +I2C for R-Car platforms
> >> > +
> >> > +Required properties:
> >> > +- compatible: Must be one of
> >> > +       "renesas,i2c-rcar"
> >> > +       "renesas,i2c-rcar-h1"
> >> > +       "renesas,i2c-rcar-h2"
> >>
> >> Is this following the same style as other DT patches? It looks to me
> >> that you may want to use r8a7779 and r8a7790 instead of h1 and h2.
> >>
> >> Simon, Laurent, what do you think about this?
> >
> > I think that should be "renesas,i2c-r8a7779" and "renesas,i2c-r8a7790", yes.

Yes, agree, those names look better. I modelled my names after the 
respective strings in the struct platform_device_id table in the driver, 
looks like that wasn't a very good idea. Yes, I realise that those 
platform device ID don't matter much - they aren't a part of any ABI 
(fortunately), can freely be changed at any time, but maybe it would be 
good to also try to create them according to a certain pattern... But yes, 
that's unrelated.

> Thanks for your comments. I recall that r8a7790 has a bunch of
> channels and at least two types of i2c controllers. I wonder what the
> proper naming would be then...

You're right. r8a7790 has 4 I2C interfaces, each of them can be used with 
either an i2c-sh_mobile - compatible or an i2c-rcar - compatible 
controller instance. Some of those interfaces can also be configured to 
use one of several pin groups.

The i2c-sh_mobile driver already has DT support and it's compatibility 
string, as added by your patch "i2c: sh_mobile: add device tree support" 
of almost 1.5 years ago, is "renesas,rmobile-iic", so, it wouldn't clash 
with the proposed "renesas,i2c-<soc>" naming scheme for i2c-rcar.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
