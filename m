From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2015 07:07:33 +0000
Subject: Re: [PATCH v2 01/07] devicetree: bindings: Renesas APMU and SMP Enable method
Message-Id: <CAMuHMdX5Cr0Ck02j=_19oTmdwQtZRu-UFE5PNLP3MHcX0kxg7A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150823072427.14156.1960.sendpatchset@little-apple>
	<20150823072439.14156.96621.sendpatchset@little-apple>
	<20008630.OlgzF7YJEU@avalon>
	<CANqRtoQkmy9JKe6B=QjiNDdFenVukO8zvSDz8NNtWCL-g6zqRQ@mail.gmail.com>
In-Reply-To: <CANqRtoQkmy9JKe6B=QjiNDdFenVukO8zvSDz8NNtWCL-g6zqRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?B?5bCP5p6X5pWs5aSq?= <keita.kobayashi.ym@renesas.com>, "Simon Horman [Horms]" <horms@verge.net.au>

Hi Magnus, Laurent,

On Tue, Aug 25, 2015 at 6:11 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Tue, Aug 25, 2015 at 3:25 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>>> --- /dev/null
>>> +++ work/Documentation/devicetree/bindings/power/renesas,apmu.txt
>> 2015-05-20
>>> 22:39:34.872366518 +0900 @@ -0,0 +1,31 @@
>>> +DT bindings for the Renesas Advanced Power Management Unit
>>> +
>>> +Renesas R-Car line of SoCs utilize one or more APMU hardware units
>>> +for CPU core power domain control including SMP boot and CPU Hotplug.
>>> +
>>> +Required properties:
>>> +
>>> +- compatible: Should be "renesas,apmu-<soctype>", "renesas,apmu" as
>>> fallback.
>>> +           Examples with soctypes are:
>>> +             - "renesas,apmu-r8a7790" (R-Car H2)
>>> +             - "renesas,apmu-r8a7791" (R-Car M2-W)
>>> +             - "renesas,apmu-r8a7792" (R-Car V2H)
>>> +             - "renesas,apmu-r8a7793" (R-Car M2-N)
>>> +             - "renesas,apmu-r8a7794" (R-Car E2)
>>> +
>>> +- reg: Base address and length of the I/O registers used by the APMU.
>>> +
>>> +- cpus: This node contains a list of CPU cores, which should match the
>>> order
>>> +  of CPU cores used by the WUPCR and PSTR registers in the Advanced Power
>>> +  Management Until section of the device's datasheet.
>>> +
>>> +
>>> +Example:
>>> +
>>> +This shows the r8a7791 APMU that can control CPU0 and CPU1.
>>> +
>>> +     apmu@e6152000 {
>>> +             compatible = "renesas,apmu-r8a7791", "renesas,apmu";
>>> +             reg = <0 0xe6152000 0 0x188>;
>>
>> Are the CA7 and CA15 APMUs identical ? If not you won't be able to instantiate
>> two APMU nodes, and it might be better to span the whole registers range of
>> both CA7 and CA15.

That complicates the (alternative solution to the) "cpus" property.
Now you have two of them, in two separate nodes, for CA15 vs. CA7 on H2,
and CA57 vs. CA53 on H3.

You can merge the nodes, but you can't easily merge the "cpus" property,
as they relate to two different registers.

> I believe they are identical, but now when you mention it I should

I was also under the impression they're identical...

> really double check!

Let's wait and see...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
