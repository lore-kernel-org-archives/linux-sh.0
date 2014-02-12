From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Feb 2014 08:37:03 +0000
Subject: Re: [PATCH v2 01/02] ARM: shmobile: Add SDHI devices to r8a7791 DTSI
Message-Id: <CANqRtoQQs+CxTGgiyEH3jjwr4zY5KxrPSgns8Fd6PyHMst0iJg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140212074119.23493.28243.sendpatchset@w520>
In-Reply-To: <20140212074119.23493.28243.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wed, Feb 12, 2014 at 5:19 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Wed, Feb 12, 2014 at 8:41 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> Changes since V1:
>>  - add r8a7790 suffix as fall back in case r8a7791 is missing from the driver
>
> I'm afraid that's not such a good idea: what if r8a7791 SDHI turns out to have a
> slight incompatibility with r8a7790 SDHI later?

It's a fallback so later we will simply use r8a7791 instead. r8a7790
is currently used with the v3.14-rc version of the SDHI driver. Future
ones always include r8a7791. How does that introduce any issues?

To be clear, I'm not introducing a new ABI here, just using something
that already exists. Of course, I can simply not use the fallback
which is what I did in V1 of the patch. But then I can't use the
v3.14-rc1 driver with r8a7791.

Morimoto-san has just posted a patch to add r8a7791 support to the
SDHI driver, so at some point in the future the r8a7790 association
won't be used anymore. Maybe v3.15-rc1, maybe later. This of course
depends on patch pick up pace.

> What about adding "renesas,sdhi-rcar-gen2" as a fallback instead, for
> both r8a7790
> and r8a7791?

Not sure if that makes much sense really, wouldn't that require driver
changes? If so we may as well modify the driver to add r8a7791
directly. =)

Also, I don't like to use "gen2" as compatible string. This because
all gen2 SoCs have not been released yet. For platform devices this is
not so serious due to lack of ABI, so there I am willing to accept
"gen2" or "r8a77xx" or something since we can change that any time.
But for DT bindings...

Ideally I'd prefer not to use the SoC string at all, but hey...

> This would reduce the size of the sh_mobile_sdhi_of_match[] table in
> drivers/mmc/host/sh_mobile_sdhi.c, as no SoC-specific entries are needed at
> the moment.

I understand the space saving benefit, but due to documentation issues
we don't really know the difference between various SoCs, so assuming
all the SoCs in the same generation is most likely not such a good
idea.

> A similar thing can be done for "renesas,sdhi-rcar-gen1" (as long as those DTSes
> are not in mainline).

We've had discussions internally about using the VERSION register in
the SDHI hardware. This would be needed in some cases because withing
a certain SoC the SDHI hardware varies with instance. So for r8a7790
SDHI0 and SDHI1 are different from SDHI2 and SDHI3. Now we get by
because they have different I/O space size.

Cheers,

/ magnus
