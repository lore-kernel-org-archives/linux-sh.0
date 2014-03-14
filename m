From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2014 09:09:31 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: koelsch-reference: Work around core clock issues
Message-Id: <CAMuHMdWEmoZwGKs6xZgSh9_YHpy0b+X_R08h7N7G+Qi53drPhA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Fri, Mar 14, 2014 at 9:53 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Thu, Mar 13, 2014 at 11:29 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>>
>> Due to issues with runtime PM clock management, clocks not explicitly
>> managed by their drivers may not be enabled at all, or be inadvertently
>> disabled by the clk_disable_unused() late initcall.
>>
>> Until this is fixed, add a temporary workaround, calling
>> shmobile_clk_workaround() with enable = true.
>>
>> For now this enables the clocks for: ether, i2c2, msiof0, qspi_mod, and
>> thermal. More clocks can be added if needed.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>> ---
>> Tested with and without CONFIG_PM_RUNTIME
>
> Hi Geert,
>
> Thanks for this patch. I'm happy to see that you find use for my clock
> workaround function. This is exactly how I imagined that it would be
> used. =)
>
> So as alway I'm yet to test the code, but before doing that I'd like
> to clarify if this patch is known to work together with this one?
>
> [PATCH] clk: shmobile: mstp: Fix the is_enabled() operation

Yes, it works with that one. It disables the unused clocks, i.e.:

MSTP tmu0 OFF
MSTP i2c0 OFF
MSTP i2c1 OFF
MSTP i2c3 OFF
MSTP i2c4 OFF
MSTP i2c5 OFF
MSTP msiof1 OFF
MSTP msiof2 OFF

(note that i2c2, ether, msiof0, and qspi_mod are no longer disabled,
 as they're now explicitly marked in use).

> My gut feeling is that these two patches together should fix our
> pending issues for Koelsch. Is it correct?

It seems so. I guess the same hack has to be used on the other boards
that have/are receiving CCF support (Lager, Marzen, Genmai).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
