From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Jun 2014 08:21:33 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: fixup GPIO6/7 register address
Message-Id: <CAMuHMdUhJD1EDoQZQXqpyjQiYp5jBkps=qqGmCP_WFcFAC+-Aw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4wko5rp.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87y4wko5rp.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, Jun 26, 2014 at 9:59 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Jun 26, 2014 at 2:47 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@gmail.com> wrote:
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> This patch is based on R-Car M2 v0.4 datasheet
>>
>> Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Apparently we already use GPIO6 and GPIO7 on Koelsch, for SDHI bits,
and for switches SW3[0-6]. At least the switches are known to work with
the old addresses (you can verify that using "hd /dev/input/event0").
Perhaps the GPIO blocks use incomplete address decoding?

However, did you try this patch? On Koelsch, it now either locks up after

gpio_rcar e6055100.gpio: map hw irq = 6, irq = 417
gpio_rcar e6055100.gpio: sense irq = 6, type = 3
sh_mobile_sdhi ee100000.sd: Got CD GPIO #806.
of_get_named_gpiod_flags exited with status 0
sh_mobile_sdhi ee100000.sd: Got WP GPIO #807.
platform ee100000.sd: Driver sh_mobile_sdhi requests probe deferral
of_get_named_gpiod_flags exited with status 0
gpio_rcar e6055100.gpio: map hw irq = 14, irq = 418

or, I get an infinite loop:

gpio_rcar e6055100.gpio: map hw irq = 6, irq = 417
gpio_rcar e6055100.gpio: sense irq = 6, type = 3
irq 0, desc: eec04040, depth: 1, count: 0, unhandled: 0
->handle_irq():  c0060f4c, handle_bad_irq+0x0/0x21c
->irq_data.chip(): c04c7658, 0xc04c7658
->action():   (null)
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
irq 0, desc: eec04040, depth: 1, count: 0, unhandled: 0
->handle_irq():  c0060f4c, handle_bad_irq+0x0/0x21c
->irq_data.chip(): c04c7658, 0xc04c7658
->action():   (null)
   IRQ_NOPROBE set
 IRQ_NOREQUEST set

Am I missing something?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
