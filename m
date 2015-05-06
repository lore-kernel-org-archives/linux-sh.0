From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 06 May 2015 07:13:56 +0000
Subject: Re: [RFC] DT-based pinmux configuration for Renesas platforms (was: [PATCH v2 01/15] pinctrl: sh-pfc
Message-Id: <CAMuHMdVVNxgyCoSpVyjadn+PLwuL40_ZBUBzxaQ9qUZ3+m_4QA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2259197.0WD3Y1GXGT@avalon>
In-Reply-To: <2259197.0WD3Y1GXGT@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, May 6, 2015 at 6:15 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 05 May 2015 11:07:20 Geert Uytterhoeven wrote:
>> On Thu, Apr 30, 2015 at 4:18 PM, Ulrich Hecht
>>
>> <ulrich.hecht+renesas@gmail.com> wrote:
>> > Part of PFC support for R-Car M2-N (r8a7793) that defines the pinmux
>> > data.
>>
>> As this patch is difficult to quote, I'm just summarizing my comments:
>>   - Other R-Car Gen2 variants use "MLB_CLK" instead of "MLB_CK",
>>   - Compared to M2-W, CAN0/1, HSCIF2_D, and MLB+ are missing,
>>     but they do exist on M2-N,
>>   - Compared to M2-W, SSP is added, but it does exist on M2-W.
>>
>> After compensating for that, pfc-r8a7793.c is identical to pfc-r8a7791.c.
>> So I think we should use a single file for both, or at least share (most of)
>> the data structures (sh_pfc_soc_info contains the SoC name, so it can't
>> be shared).
>
> I agree with that, and I'd even go further : I think we won't be able to scale
> much further with our large in-kernel tables. We currently have around 150kB
> or PFC .rodata when enabling all Renesas platforms, which is far from being
> negligible in a multiplatform build. I could be time to reconsider the

I've been thinking about compressing it using zlib/lzo/lz4, and only
decompressing the data for the platform you're running on.

> approach and specify data in DT.

Ohoh... ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
