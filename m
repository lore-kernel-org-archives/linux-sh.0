From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Jun 2014 06:35:18 +0000
Subject: Re: [PATCH 02/07] DMA: shdma: 40-bit address prototype
Message-Id: <CAMuHMdUYsrYiuafMFyT8yKeVGkO3agN0RCO3HuO=irqUrrJKng@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140610230329.13594.85113.sendpatchset@w520>
In-Reply-To: <20140610230329.13594.85113.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thu, Jun 12, 2014 at 5:36 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> +               if ((src_masked < limit) && ((src_masked + *len) > limit))
>>
>> "src_masked < limit" fails to catch the case "src_masked = 0xffffffff".
>> "(src_masked + *len) > limit)" incorrectly catches the case
>> "(src_masked + *len) = 0x*00000000".
>>
>> I think you want to check for
>>
>>     if ((src >> 32) != ((src + *len - 1) >> 32))
>>
>> ?
>>
>>> +                       *len = limit - src_masked;
>>> +
>>> +               if ((dst_masked < limit) && ((dst_masked + *len) > limit))
>>> +                       *len = limit - dst_masked;
>>
>> Idem ditto.
>
> Thanks for checking my code. Indeed, the code is incorrect.
>
> How about the following replacement?
>
> #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> /* disable transfer across 32-bit boundary */
> if (shdev->pdata->fourty_bits_addr) {
>   dma_addr_t four_gigs = 1ULL << 32;
>
>   if ((src >> 32) != ((src + *len - 1) >> 32))
>     *len = four_gigs - (src & (four_gigs - 1));
>
>   if ((dst >> 32) != ((dst + *len - 1) >> 32))
>     *len = four_gigs - (dst & (four_gigs - 1));
> }
> #endif

Thanks, that looks correct to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
