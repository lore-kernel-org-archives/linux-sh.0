From: Simon Horman <horms@verge.net.au>
Date: Mon, 26 May 2014 09:00:34 +0000
Subject: Re: [PATCH v4] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <20140526090031.GA6155@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201405240206.04700.sergei.shtylyov@cogentembedded.com>
 <CAMuHMdUrYmoYzcD__HkHMN4UzTpBcGbjTwhuSdNHXa6QXq6dsg@mail.gmail.com>
 <20140526074801.GC4500@verge.net.au>
 <CAMuHMdUP37MdiZEYZjZ8Gj_h_wojcm7RvmRKxKP2v9g7WqBb3A@mail.gmail.com>
In-Reply-To: <CAMuHMdUP37MdiZEYZjZ8Gj_h_wojcm7RvmRKxKP2v9g7WqBb3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh+dt@kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, kishon@ti.com, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, May 26, 2014 at 10:04:52AM +0200, Geert Uytterhoeven wrote:
> Hi Simon, Rob,
> 
> On Mon, May 26, 2014 at 9:48 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > +Required properties:
> >> > +- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
> >> > +             "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
> >>
> >> As this is a new driver, I think you should switch to the recommended
> >> vendor/soc/device ordering, which is also supported by checkpatch (incl.
> >> wildcard matching!), i.e. "renesas,r8a7790-usb-phy" etc.
> >
> > A while ago we were asked to consolidate our drivers around a consistent
> > scheme. At the time the <vendor>,<device>-<version> scheme, where version > 
> (after talking around at ELC) It's my understanding this was a silly mistake.

That is a shame as we switched around the binding for at least one driver

> > SoC for most Renesas parts, was agreed to be acceptable and we have
> > (hopefully) consistently been using that ever since.
> 
> We did for everything except for clock drivers, sound, and thermal.
> 
> > So unless there has been a policy change I would prefer to keep using this
> > scheme (i.e. leave the bindings above as-is). And update checkpatch if that
> > is appropriate.
> 
> Rob, can we have the official policy documented in
> Documentation/devicetree/bindings?

Of course if there is a policy I'm have no objections to following it for
new drivers.
