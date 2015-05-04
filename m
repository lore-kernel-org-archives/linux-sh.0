From: Axel Haslam <ahaslam@baylibre.com>
Date: Mon, 04 May 2015 12:54:22 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: skip set_wake for gic irq.
Message-Id: <CAKXjFTM5SQqR7i10SJ2qhriVYBh6WE2ZdJs272_asewZoQdG7w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430737448-29223-1-git-send-email-ahaslam@baylibre.com>
In-Reply-To: <1430737448-29223-1-git-send-email-ahaslam@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Mon, May 4, 2015 at 2:30 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Axel,
>
> On Mon, May 4, 2015 at 1:04 PM,  <ahaslam@baylibre.com> wrote:
>> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>>
>> when doing a suspend to ram with r8a7790 a warning starts appearing
>> since: commit ab82fa7da4dc ("gpio: rcar: Prevent module clock disable
>> when wake-up is enabled")
>>
>> the call trace that ends up in the waring is:
>>         gpio_rcar_irq_set_wake()
>>                 irq_set_irq_wake(p->irq_parent, on);
>>                         gic_set_wake()
>>
>> but since gic_arch_extn.irq_set_wake is not set, this returns
>> an error and  desc->wake_depth is set to 0, which generates warnings
>> on trying to disable the wake upon resume.
>>
>> To avoid this warning set the IRQCHIP_SKIP_SET_WAKE flag for the gic
>> irq's. With this flag set_irq_wake_real will avoid returning
>> errors and the calls will be balanced.
>
> I tried to handle this in the GIC driver:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331763.html
> but that was rejected by Marc Zyngier:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331813.html
>
> I wrote a patch to fix this in gpio-rcar, but forgot to send it.
> Sorry for that, will do later today.
>
>> @@ -27,6 +30,12 @@ static const char * const r8a7790_boards_compat_dt[] __initconst = {
>>         NULL,
>>  };
>>
>> +void __init r8a7790_init_irq(void)
>> +{
>> +       gic_arch_extn.flags = IRQCHIP_SKIP_SET_WAKE;
>> +       irqchip_init();
>> +}
>
> Please note that gic_arch_extn is cheduled for removal, cfr. "[PATCH] irqchip:
> gic: Drop support for gic_arch_extn"
> (http://www.spinics.net/lists/arm-kernel/msg413684.html)


I  missed your thread with Marc,
sorry for the noise.

Regards,
Axel

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
