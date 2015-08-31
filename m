From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Aug 2015 13:38:40 +0000
Subject: Re: [PATCH v8 01/07] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
Message-Id: <CAMuHMdUY0wWrEoD9H3dtUD1jM3yxG3D754+rEBEbGnA5wCKAUw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831062918.24004.15458.sendpatchset@little-apple>
In-Reply-To: <20150831062918.24004.15458.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Mon, Aug 31, 2015 at 12:44 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 31 August 2015 15:29:18 Magnus Damm wrote:
>> --- 0001/arch/arm64/Kconfig.platforms
>> +++ work/arch/arm64/Kconfig.platforms 2015-08-29 18:20:52.022366518 +0900
>> @@ -66,6 +66,22 @@ config ARCH_SEATTLE
>>       help
>>         This enables support for AMD Seattle SOC Family
>>
>> +config ARCH_SHMOBILE
>> +     bool
>
> It's tempting to get rid of ARCH_SHMOBILE going forward and define
> ARCH_RENESAS on ARM32 instead. I'm not sure whether that's worth it, even
> though the change would just be a search & replace.

What's the meaning of "ARCH_RENESAS"?
Does that include H8/300, m32r, and SuperH, too?

I know "SH Mobile" has been used for both SuperH and ARM32, but it's
still closer ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
