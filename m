From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Oct 2015 13:32:03 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: enable HDMI output for RCar
Message-Id: <CAMuHMdXbj3zUzn5o4XEYNf9yx-4VQyiBYCQmKPv1mopuc177rQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1407974835-11064-1-git-send-email-khilman@linaro.org>
In-Reply-To: <1407974835-11064-1-git-send-email-khilman@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 14, 2015 at 3:18 PM, Khiem Nguyen
<khiem.nguyen.xt@rvc.renesas.com> wrote:
>>> AFAIK, in some recent versions of Gen2 BSP, all the devices (including
>>> all devices enabled by u-boot for its processing, like Ethernet, TMU,
>>> serial) will be turned off right before jumping to kernel start address.
>>
>> Would it make sense to keep the serial port enabled in order to support
>> early
>> printk ?
>>
>
> I don't think early printk is supported in Gen2 BSP, which is base on LTSI
> 3.10.
> Geert has introduced early printk support for Gen2 in Nov 2014.
>
> Maybe, we need to consider this point for Gen3.

INTC-RT, MFIS, INTC-SYS, IRQC, and SCIF0 are left enabled, according
to the U-Boot sources.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
