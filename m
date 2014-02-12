From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Feb 2014 09:27:30 +0000
Subject: Re: [PATCH v2 01/02] ARM: shmobile: Add SDHI devices to r8a7791 DTSI
Message-Id: <CAMuHMdU28GA23bQGqr8KsEcTcvbX=3UHrnfy90o7HjipYhkX3g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140212074110.23493.41073.sendpatchset@w520>
	<20140212074119.23493.28243.sendpatchset@w520>
	<CAMuHMdVsh4hG0VruqJBatkGCvhtgUYXAYxR930UZS-QAdoN8gw@mail.gmail.com>
	<CANqRtoQQs+CxTGgiyEH3jjwr4zY5KxrPSgns8Fd6PyHMst0iJg@mail.gmail.com>
	<CAMuHMdUVSYtoaLvT-ZGw81q3jTXk2nB0zCYSsdx-u6QVZ8Z8WA@mail.gmail.com>
	<CANqRtoQ8uYZcMQC5EQ6DLHGb3noOFsnTvtFTvPaMQarOdkD5Aw@mail.gmail.com>
In-Reply-To: <CANqRtoQ8uYZcMQC5EQ6DLHGb3noOFsnTvtFTvPaMQarOdkD5Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Feb 12, 2014 at 9:51 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>>>>  - add r8a7790 suffix as fall back in case r8a7791 is missing from the driver

>>>>> +       sdhi0: sd@ee100000 {
>>>>> +               compatible = "renesas,sdhi-r8a7791", "renesas,sdhi-r8a7790";

>>>> I'm afraid that's not such a good idea: what if r8a7791 SDHI turns out to have a
>>>> slight incompatibility with r8a7790 SDHI later?
>>>
>>> It's a fallback so later we will simply use r8a7791 instead. r8a7790
>>> is currently used with the v3.14-rc version of the SDHI driver. Future
>>> ones always include r8a7791. How does that introduce any issues?
>>
>> Bummer, yes, it prefers the first compatible entry.
>>
>> Will refrain from sending more emails until my coffee has been digested ;-)
>
> Heheh. But I think you raise a valid point:
>
> Using the wrong SoC in the compatible string is pretty darn ugly.
>
> What is the best practise here?

(adding devicetree)

It should be a reference to the hardware block.

Before the advent of SoCs, a hardware block was an IC, with a part number
(e.g. de21040), and sometimes a name (e.g. tulip). Further evolutions of the
hardware block got (usually, but not always) different part numbers.

With SoCs, the part numbers of the hardware blocks were lost. Only the SoC
still carries a part number. The hardware blocks (now called "IP cores") still
have names (e.g. RSPI), but they're more abstract, and it's difficult to know
what exact version of the hardware block they're referring to[*].

Using "<manufacturer>,<name>-<soc>" is future-proof, but cumbersome.
Having a more generic fallback name to group SoCs with the same IP core
is convenient.

So we have to "invent" generic fallback names with versioning ourselves?

  - SoC family name? But there's no guarantee a new SoC from the same
    family will be 100% compatible.
  - "-v1", "-v2" suffixes? The new SoC may have something in between
    v1 and v2
  - ???

[*] With OpenRISC it's easier, as we have the hardware source files, but
    it's still cumbersome to find good version naming.
    The OpenCores-mandated "<name>-rtlsvn<version>" is not such a good
    match for todays distributed development, with IP cores being imported
    into git repositories and modified there.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
