From: Simon Horman <horms@verge.net.au>
Date: Mon, 26 May 2014 07:48:01 +0000
Subject: Re: [PATCH v4] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <20140526074801.GC4500@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201405240206.04700.sergei.shtylyov@cogentembedded.com>
 <CAMuHMdUrYmoYzcD__HkHMN4UzTpBcGbjTwhuSdNHXa6QXq6dsg@mail.gmail.com>
In-Reply-To: <CAMuHMdUrYmoYzcD__HkHMN4UzTpBcGbjTwhuSdNHXa6QXq6dsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, kishon@ti.com, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, May 26, 2014 at 09:28:22AM +0200, Geert Uytterhoeven wrote:
> On Sat, May 24, 2014 at 12:06 AM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > --- /dev/null
> > +++ linux-phy/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
> > @@ -0,0 +1,60 @@
> > +* Renesas R-Car generation 2 USB PHY
> > +
> > +This file provides information on what the device node for the R-Car generation
> > +2 USB PHY contains.
> > +
> > +Required properties:
> > +- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
> > +             "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
> 
> As this is a new driver, I think you should switch to the recommended
> vendor/soc/device ordering, which is also supported by checkpatch (incl.
> wildcard matching!), i.e. "renesas,r8a7790-usb-phy" etc.

A while ago we were asked to consolidate our drivers around a consistent
scheme. At the time the <vendor>,<device>-<version> scheme, where version SoC for most Renesas parts, was agreed to be acceptable and we have
(hopefully) consistently been using that ever since.

So unless there has been a policy change I would prefer to keep using this
scheme (i.e. leave the bindings above as-is). And update checkpatch if that
is appropriate.
