From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Oct 2015 11:09:22 +0000
Subject: Re: [PATCH v4 1/5] [RFC] clk: shmobile: Add new Renesas CPG/MSSR DT bindings
Message-Id: <CAMuHMdW=bNeoXWMbw74HVT4rZGYq=HekW9a=ZfvhS3wpuG1hZg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
	<CAMuHMdVhBipbf13o0jb3H6qmcewh6CCtq3=Hj-9nvgar+AYdFg@mail.gmail.com>
	<CANqRtoS6QpWJY99aD8KyGHgySxqzzBPic-k_a-VcZE6LVFFRow@mail.gmail.com>
	<1832656.BCXoHFFChX@avalon>
In-Reply-To: <1832656.BCXoHFFChX@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Laurent,

On Fri, Oct 23, 2015 at 1:05 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 21 October 2015 01:01:03 Magnus Damm wrote:
>> On Tue, Oct 20, 2015 at 9:16 PM, Geert Uytterhoeven wrote:
>> > On Fri, Oct 16, 2015 at 2:49 PM, Geert Uytterhoeven wrote:
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
>> >> @@ -0,0 +1,71 @@
>> >> +* Renesas Clock Pulse Generator / Module Standby and Software Reset
>> >> +
>> >> +On Renesas ARM SoCs (SH/R-Mobile, R-Car, RZ), the CPG (Clock Pulse
>> >> Generator)
>> >> +and MSSR (Module Standby and Software Reset) blocks are intimately
>> >> connected,
>> >> +and share the same register block.
>> >> +
>> >> +They provide the following functionalities:
>> >> +  - The CPG block generates various core clocks,
>> >> +  - The MSSR block provides two functions:
>> >> +      1. Module Standby, providing a Clock Domain to control the clock
>> >> supply
>> >> +        to individual SoC devices,
>> >> +      2. Reset Control, to perform a software reset of individual SoC
>> >> devices.
>> >> +
>> >> +Required Properties:
>> >> +  - compatible: Must be one of:
>> >> +      - "renesas,r8a7791-cpg-mssr" for the r8a7791 SoC
>> >
>> > I'll drop the reference to "r8a7791", as we won't convert r8a7791 (yet).
>
> I'm fine with supporting r8a7795 only in the initial patch set, but when do we
> plan to convert r8a7791 ? I think it would be a good idea to validate these

That's a political question...

> bindings on r8a7791 before considering them as stable.

I did the validation on both r8a7795/salvator-x and r8a7791/koelsch.
Please try branch topic/cpg-mssr-v4 of renesas-drivers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
