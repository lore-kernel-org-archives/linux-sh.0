From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 May 2015 08:04:31 +0000
Subject: Re: [RFC 1/3] ARM: shmobile: rcar-gen2: Add generic "renesas,rcar-gen2" machine
Message-Id: <CAMuHMdUrrrO1ASZoyctSdbDMyBy99+nGhU3ppSK_WiONXOWAGQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432205413-9584-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432205413-9584-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Mon, May 25, 2015 at 3:17 AM, Simon Horman <horms@verge.net.au> wrote:
>> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> @@ -201,3 +201,16 @@ void __init rcar_gen2_reserve(void)
>>                                           &rcar_gen2_dma_contiguous, true);
>>  #endif
>>  }
>> +
>> +static const char *rcar_gen2_boards_compat_dt[] __initconst = {
>> +     "renesas,rcar-gen2",
>> +     NULL,
>> +};
>
> I would rather not have renesas,rcar-gen2 above and rather have
> each SoC that this covers listed above.

If there's no SoC-specific compatible entry needed for differentiation, we
can use the generic compatible entry here fine, just like we do for device
drivers.
The SoC-specific one is still documented in the binding documentation.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
