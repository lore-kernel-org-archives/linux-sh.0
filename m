From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 May 2014 08:04:52 +0000
Subject: Re: [PATCH v4] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <CAMuHMdUP37MdiZEYZjZ8Gj_h_wojcm7RvmRKxKP2v9g7WqBb3A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201405240206.04700.sergei.shtylyov@cogentembedded.com>
	<CAMuHMdUrYmoYzcD__HkHMN4UzTpBcGbjTwhuSdNHXa6QXq6dsg@mail.gmail.com>
	<20140526074801.GC4500@verge.net.au>
In-Reply-To: <20140526074801.GC4500@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Rob Herring <robh+dt@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, kishon@ti.com, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Simon, Rob,

On Mon, May 26, 2014 at 9:48 AM, Simon Horman <horms@verge.net.au> wrote:
>> > +Required properties:
>> > +- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
>> > +             "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
>>
>> As this is a new driver, I think you should switch to the recommended
>> vendor/soc/device ordering, which is also supported by checkpatch (incl.
>> wildcard matching!), i.e. "renesas,r8a7790-usb-phy" etc.
>
> A while ago we were asked to consolidate our drivers around a consistent
> scheme. At the time the <vendor>,<device>-<version> scheme, where version 
(after talking around at ELC) It's my understanding this was a silly mistake.

> SoC for most Renesas parts, was agreed to be acceptable and we have
> (hopefully) consistently been using that ever since.

We did for everything except for clock drivers, sound, and thermal.

> So unless there has been a policy change I would prefer to keep using this
> scheme (i.e. leave the bindings above as-is). And update checkpatch if that
> is appropriate.

Rob, can we have the official policy documented in
Documentation/devicetree/bindings?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
