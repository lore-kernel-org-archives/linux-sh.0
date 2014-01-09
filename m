From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 09 Jan 2014 09:48:43 +0000
Subject: Re: spi-rspi I/O errors
Message-Id: <CAMuHMdVJNXE=6CY8k90KgPAVUF0k2R1x-fvVSJd4zLveGAx-Sw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.02.1401072116370.27579@ayla.of.borg>
	<6231184.EMt0gDqh7K@avalon>
	<CAMuHMdWDwF+KcNPrKgjvH6w7Uxn-iON+nQz_+Z_RTU_yV7SVog@mail.gmail.com>
	<30872348.jm2GxWdDk6@avalon>
	<CAMuHMdVzFeymxW2CZUyKgZ-fxsektE1EpLQksfSzoekj2ex53Q@mail.gmail.com>
	<CANqRtoRj_CybzDY3h1Caz=G=R7R-GVBxJ86xr5isWnWn1mDb2A@mail.gmail.com>
In-Reply-To: <CANqRtoRj_CybzDY3h1Caz=G=R7R-GVBxJ86xr5isWnWn1mDb2A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Magnus,

On Thu, Jan 9, 2014 at 4:26 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> What I'd like to know is whether the interrupt is trigerred before bit 7 gets
>>> set by the hardware, or if the rspi_wait_for_interrupt() function gets a stale
>>> value of rspi->spsr.
>>
>> It seems to get a stale value. I ended up doing the printk() anyway, and
>> when reading using small buffer sizes, the issues is more likely to happen.
>>
>> If I add a second copy of rspi->spsr, and make that copy volatile OR add
>> a few calls to smp_mb() around the places where it's written and read,
>> the copy has the right value inside rspi_wait_for_interrupt(), BUT only if
>> I also print the spsr value inside rspi_irq(). Note that the original rspi->spsr
>> still has the stale value.
>>
>> I'd expect wake_up() and wait_event_timeout() to have the right memory
>> barriers (cfr. Documentation/memory-barriers.txt), so I don't have to add
>> my own. And why does it need the extra printk()? What extra
>> synchronization does that give?
>>
>> Note that the interrupt handler always runs on CPU core 0,
>> while rspi_wait_for_interrupt() can run on core 0 or 1.
>> Is there a cache-coherency issue between the two CPU cores?
>>
>> Am I missing something?
>
> What happens if you run on a uniprocessor system or in case of R-Car
> disable SMP and run with a single CPU core?

As expected, I can't get it to fail in UP-mode.

In SMP-mode, it fails in ca. 1% of the transfers. It seems to happen when
switching between the write and the read part of a transfer, so the problem
is less likely to happen when using large buffer sizes, as less transfers are
involved for reading the same amount of data.

If it fails while reading the JEDEC ID from the SPI FLASH during boot up,
you end up without an MTD device.
In other cases, the error is recoverable by reading again (from userspace).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
