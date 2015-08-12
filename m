From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Aug 2015 15:13:31 +0000
Subject: Re: [PATCH] mmc: sh_mmcif: Silence DMA slave ID compile warnings on 64-bit
Message-Id: <CAMuHMdWR0u9X36Dsw0QufmGO0phiY_w-tn1f-EmnL69FZ7NhMQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1439297314-29118-1-git-send-email-geert+renesas@glider.be>
	<1539991.LpcThZV47z@wuerfel>
In-Reply-To: <1539991.LpcThZV47z@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Arnd,

On Wed, Aug 12, 2015 at 4:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 11 August 2015 14:48:34 Geert Uytterhoeven wrote:
>>         dma_cap_mask_t mask;
>> @@ -413,12 +413,11 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
>>         dma_cap_set(DMA_SLAVE, mask);
>>
>>         if (pdata)
>> -               slave_data = direction = DMA_MEM_TO_DEV ?
>> -                       (void *)pdata->slave_id_tx :
>> -                       (void *)pdata->slave_id_rx;
>> +               slave_id = direction = DMA_MEM_TO_DEV ?
>> +                       pdata->slave_id_tx : pdata->slave_id_rx;
>>
>>         chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
>> -                               slave_data, dev,
>> +                               (void *)(uintptr_t)slave_id, dev,
>>                                 direction = DMA_MEM_TO_DEV ? "tx" : "rx");
>>
>>         dev_dbg(dev, "%s: %s: got channel %p\n", __func__,
>
> How about changing the type of the slave_id_rx/slave_id_tx fields
> to void*? That way, the hack can be moved to arch/sh/boards/board-sh7757lcr.c,
> which is now the only file passing data this way. Ideally, we'd also

And to the other SH boards... This is not limited to the mmcif driver.

Ah, I see tmio_mmc_data already does it this way.

This will break out-of-tree boards at compile-time though. Given the limited
number of wired up DMA channels under arch/sh/, they may actually be
more in use out-of-tree than in-tree?

Alternatively, perhaps we should just drop pdata DMA configuration from
some drivers?

> pass the shdma_chan_filter function pointer in pdata to avoid the link
> time dependency on a particular dmaengine driver.

That's actually more tricky, as a NULL filter function means something
completely different, and causes funny failures if the DTS lacks "dmas"
properties, cfr. "dmaengine: shdma: Make dummy shdma_chan_filter() always
return false".
https://git.kernel.org/cgit/linux/kernel/git/vkoul/slave-dma.git/commit/?h=next&id6f6c87028544de934f27caf95aa1545d585767

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
