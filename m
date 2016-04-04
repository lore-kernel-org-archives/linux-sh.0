From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 Apr 2016 13:55:39 +0000
Subject: Re: [PATCH] drivers: sh: Use ARCH_RENESAS
Message-Id: <CAMuHMdVTCYEyBxqBd7e8PyyT3xkA6vvoT1fj-YcFFeONQxCZ+A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1456882987-4502-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1456882987-4502-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rich,

On Mon, Mar 28, 2016 at 3:16 PM, Rich Felker <dalias@libc.org> wrote:
> On Wed, Mar 02, 2016 at 09:25:54AM +0100, Geert Uytterhoeven wrote:
>> On Wed, Mar 2, 2016 at 2:43 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
>> > Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
>> >
>> > This is part of an ongoing process to migrate from ARCH_SHMOBILE to
>> > ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
>> > appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>> >
>> > ARCH_RENESAS should cover all cases where both CONFIG_OF and
>> > ARCH_SHMOBILE are enabled.
>> >
>> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>
>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> If you intend to drop ARCH_SHMOBILE from arch/arm/mach-shmobile/Kconfig before
>> dropping the whole "if (...) { ... }" block below" (cfr. "drivers: sh: Stop
>> using the legacy clock domain on ARM",
>> http://www.spinics.net/lists/linux-renesas-soc/msg00869.html).
>>
>> Note that the SH-people may resurrect (a variant of) the block when they start
>> migrating to DT and CCF.
>
> I can't say for sure at this point, but I think instead of searching
> for a node by compatible I would want to represent the relationship
> between the nodes semantically in the device tree. We can address that
> when we get there, though. If we're stuck with device-provided device
> trees that don't fully represent the relationships we might have to
> keep kludges for searching.

Great. That's indeed the best approach to follow.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
