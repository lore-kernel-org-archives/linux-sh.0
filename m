From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Jun 2014 08:57:59 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: fixup GPIO6/7 register address
Message-Id: <CAMuHMdVQRwuq25QsnPXXuQJg9NOVAq3+-+LMpWUjx32A6D-gZA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4wko5rp.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87y4wko5rp.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, Jun 26, 2014 at 10:52 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>> Apparently we already use GPIO6 and GPIO7 on Koelsch, for SDHI bits,
>> and for switches SW3[0-6]. At least the switches are known to work with
>> the old addresses (you can verify that using "hd /dev/input/event0").
>> Perhaps the GPIO blocks use incomplete address decoding?
>>
>> However, did you try this patch? On Koelsch, it now either locks up after
>
> Sorry, I didn't.
> I just checked latest datasheet (H2/M2).
> I'm asking correct address to HW team.
> Please wait.

Thanks!

P.S. In case something needs to be changed: the GPIO base addresses are
     also in arch/arm/mach-shmobile/setup-r8a7791.c.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
