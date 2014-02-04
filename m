From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 04 Feb 2014 18:54:51 +0000
Subject: Re: [PATCH 00/11] ARM: shmobile: RSPI RZ and QSPI SoC and board integration
Message-Id: <CAMuHMdUHP8ptyjXh1n+iucygfAEAZCuwwe1tB1JjrTuGrhD3Pg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1391527445-14881-1-git-send-email-geert@linux-m68k.org>
 <20140204173733.GI22609@sirena.org.uk>
In-Reply-To: <20140204173733.GI22609@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Mark,

On Tue, Feb 4, 2014 at 6:37 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Feb 04, 2014 at 04:23:54PM +0100, Geert Uytterhoeven wrote:
>>       Hi Simon, Magnus,
>>
>> This patch series contains SoC and board integration for
>>   1. RSPI in the r7s72100 aka RZ/A1H SoC on the Genmai reference board,
>>   2. QSPI in the r8a7791 aka R-Car M2 SoC on the Koelsch reference board.
>> It was rebased on top of renesas-devel-v3.14-rc1-20140204.
>
> Can you please stop CCing arch/arm only patch serieses like this to the
> SPI list - they just mean I have to go through patchwork and mark them
> as not applicable.

Sorry, you're right. Only a few of them contained SPI-specific code.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
