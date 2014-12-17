From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Dec 2014 14:37:46 +0000
Subject: Re: [PATCH v2 01/05] ARM: shmobile: kzm9g-reference: 0x48008000 load address
Message-Id: <CAMuHMdUC=nfvOg=8HiFKnzcYd5xM8ZYO8FJPJagD_vpdv9vRxg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141217094214.7039.68681.sendpatchset@w520>
In-Reply-To: <20141217094214.7039.68681.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wed, Dec 17, 2014 at 3:28 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> uImage built from zImage with appended DTB.
>>>
>>> These 4 steps actually:
>>> rm arch/arm/boot/zImage
>>> make -j 9 ARCH=arm CROSS_COMPILE=_ dtbs zImage
>>> cat arch/arm/boot/dts/sh73a0-kzm9g.dtb >> arch/arm/boot/zImage
>>> make -j 9 ARCH=arm CROSS_COMPILE=_ LOADADDR=0x48008000 uImage
>>
>> Thanks, that works!
>> But the machine lost 128 MiB of RAM, compared to adjusting the "reg" property
>> of the memory node :-(
>
> Huh, I wasn't aware that we also loose memory!?

Ignoring memory range 0x41000000 - 0x48000000

It's indeed easy to miss this extra line of output, without e.g.
https://github.com/geertu/linux-scripts/blob/master/linux-dmesg-diff

> I suppose we need to update the code to allow registering memory below
> the kernel load address.

That requires enabling more NUMA features...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
