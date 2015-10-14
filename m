From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Date: Wed, 14 Oct 2015 12:11:12 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: enable HDMI output for RCar
Message-Id: <561E4660.5020106@rvc.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1407974835-11064-1-git-send-email-khilman@linaro.org>
In-Reply-To: <1407974835-11064-1-git-send-email-khilman@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/14/2015 3:22 PM, Geert Uytterhoeven wrote:
> Hi Magnus,
>
> On Wed, Oct 14, 2015 at 10:09 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> Or do you mean disabling them upfront?
>>> There are some clocks that must not be disabled. Some of them are not
>>> documented.
>>
>> Disabling them upfront with sparse documentation seems fun, but also a
>> bit like asking for trouble. =)
>
> I have hackish code that does it for all boards I have, and use it actively.
>
>> So disabling clocks upfront may be a troublesome but good way to
>> trigger incorrect dependencies, and unless I'm mistaken it should give
>> the same behaviour as the updated u-boot version, right?
>
> More or less (U-Boot still keeps a few enabled for its own use, e.g. Ethernet).

AFAIK, in some recent versions of Gen2 BSP, all the devices (including 
all devices enabled by u-boot for its processing, like Ethernet, TMU, 
serial) will be turned off right before jumping to kernel start address.

> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
