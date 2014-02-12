From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Feb 2014 08:48:55 +0000
Subject: Re: [PATCH v2 01/02] ARM: shmobile: Add SDHI devices to r8a7791 DTSI
Message-Id: <CAMuHMdUVSYtoaLvT-ZGw81q3jTXk2nB0zCYSsdx-u6QVZ8Z8WA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140212074119.23493.28243.sendpatchset@w520>
In-Reply-To: <20140212074119.23493.28243.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 12, 2014 at 9:37 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> On Wed, Feb 12, 2014 at 8:41 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> Changes since V1:
>>>  - add r8a7790 suffix as fall back in case r8a7791 is missing from the driver
>>
>> I'm afraid that's not such a good idea: what if r8a7791 SDHI turns out to have a
>> slight incompatibility with r8a7790 SDHI later?
>
> It's a fallback so later we will simply use r8a7791 instead. r8a7790
> is currently used with the v3.14-rc version of the SDHI driver. Future
> ones always include r8a7791. How does that introduce any issues?

Bummer, yes, it prefers the first compatible entry.

Will refrain from sending more emails until my coffee has been digested ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
