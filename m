From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Sep 2015 09:52:29 +0000
Subject: Re: [PATCH v3 0/5] r8a7778/bockw: fix SMSC Ethernet for MP
Message-Id: <CAMuHMdWJw9vAgsOeHcfeuNuM8nGVS-ddmGCFfHgzkAB_MQU2wA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441726946-30131-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1441726946-30131-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich, Simon,

On Wed, Sep 9, 2015 at 2:52 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Sep 08, 2015 at 05:42:21PM +0200, Ulrich Hecht wrote:
>> This series enables the DT-wise IRLM setup in the intc-irqpin driver (same
>> as on r8a7779) and configures the FPGA correctly.

>> Ulrich Hecht (5):
>>   irqchip: renesas-intc-irqpin: r8a7778 IRLM setup support
>>   ARM: shmobile: r8a7778: enable IRLM setup via DT
>>   ARM: shmobile: bockw dts: enable SMSC interrupt
>>   ARM: shmobile_defconfig: enable PINCTRL_SINGLE
>>   ARM: multi_v7_defconfig: enable PINCTRL_SINGLE
>
> Jason,
>
> could you consider picking-up the irqchip patch, the first of the series?
> With that in place I can go ahead and queue up the remaining patches.

I think you should send it to all of

IRQCHIP DRIVERS
M:      Thomas Gleixner <tglx@linutronix.de>
M:      Jason Cooper <jason@lakedaemon.net>
M:      Marc Zyngier <marc.zyngier@arm.com>
L:      linux-kernel@vger.kernel.org

Cfr. Thomas' recent complaint in
http://www.spinics.net/lists/arm-kernel/msg445781.html

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
