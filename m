From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 08 Jan 2014 08:28:59 +0000
Subject: Re: spi-rspi I/O errors
Message-Id: <CAMuHMdWDwF+KcNPrKgjvH6w7Uxn-iON+nQz_+Z_RTU_yV7SVog@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.02.1401072116370.27579@ayla.of.borg>
	<6231184.EMt0gDqh7K@avalon>
In-Reply-To: <6231184.EMt0gDqh7K@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Laurent,

On Wed, Jan 8, 2014 at 1:27 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 07 January 2014 21:27:18 Geert Uytterhoeven wrote:
>> I was regularly getting I/O errors when using the Renesas RSPI/QSPI
>> driver on r8a7791:
>>
>>     m25p80 spi0.0: error -110 reading SR
>>
>> Until I applied the following patch, which re-reads RSPI_SPSR on a time-out,
>> and continues if the condition has become true:
>>
>> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
>> index 4b31d89e8568..e63e30c500da 100644
>> --- a/drivers/spi/spi-rspi.c
>> +++ b/drivers/spi/spi-rspi.c
>> @@ -442,8 +442,13 @@ static int rspi_wait_for_interrupt(struct rspi_data
>> *rspi, u8 wait_mask, rspi->spsr = rspi_read8(rspi, RSPI_SPSR);
>>       rspi_enable_irq(rspi, enable_bit);
>>       ret = wait_event_timeout(rspi->wait, rspi->spsr & wait_mask, HZ);
>> -     if (ret = 0 && !(rspi->spsr & wait_mask))
>> -             return -ETIMEDOUT;
>> +     if (ret = 0 && !(rspi->spsr & wait_mask)) {
>> +             u8 spsr = rspi_read8(rspi, RSPI_SPSR);
>> +             printk("*** rspi->spsr = 0x%02x, real spsr = 0x%02x, wait_mask > 0x%02x
>> ***\n",
>> +                    rspi->spsr, spsr, wait_mask);
>> +             if (!(spsr & wait_mask))
>> +                     return -ETIMEDOUT;
>> +     }
>>
>>       return 0;
>>  }
>>
>> Now it prints from time to time:
>>
>>     *** rspi->spsr = 0x20, real spsr = 0xa0, wait_mask = 0x80 ***
>>
>> which shows that rspi->spsr (as set from the interrupt handler) didn't
>> have bit 7 set, while RSPI_SPSR does have bit 7 set.
>>
>> So this looks like a race condition in the interrupt handling.
>
> What happens if you print rspi->spsr in the interrupt handler ? Does it have
> bit 7 set ?

I haven't tried that yet. The driver is extremely interrupt-heavy (O(n),
with n the number of bytes transfered), so adding a printk() as-is won't be
a good idea.

Will think a bit more about a better approach...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
