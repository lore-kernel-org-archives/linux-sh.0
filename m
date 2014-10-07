From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 Oct 2014 13:10:01 +0000
Subject: Re: [PATCH] ASoC: simple-card: Add mic and hp detect gpios.
Message-Id: <CAMuHMdV39fM_TCa+WSvswij6dxD2vwfJT+FueBtxndpsymP9CQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412198720-2326-1-git-send-email-dgreid@chromium.org>
	<20141002155350.GU4273@sirena.org.uk>
	<CAMuHMdWh=sXAD59T1T=gvROX+fbF6=gFo6C0nkJdfnCrdNrwYg@mail.gmail.com>
	<20141007123856.GF4609@sirena.org.uk>
In-Reply-To: <20141007123856.GF4609@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Dylan Reid <dgreid@chromium.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, jay.xu@rock-chips.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, sonnyrao@chromium.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

(re-added some context, CC Linus, Alexandre, linux-gpio)

On Tue, Oct 7, 2014 at 2:38 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Oct 07, 2014 at 02:32:57PM +0200, Geert Uytterhoeven wrote:
>> Unfortunately there's no equivalent code for platform data, and the
>> uninitialized default of 0 for gpio_hp_det and gpio_mic_det doesn't
>> play well with asm-generic's gpio_is_valid():
>>
>> static inline bool gpio_is_valid(int number)
>> {
>>         return number >= 0 && number < ARCH_NR_GPIOS;
>> }
>>
>> Hence on r8a7740/armadillo-legacy, which uses platform devices instead of DT:
>
>>     sh-mobile-hdmi sh-mobile-hdmi: SH Mobile HDMI Audio Codec
>>     sh-mobile-hdmi sh-mobile-hdmi: ASoC: DAPM unknown pin Headphones
>>     sh-mobile-hdmi sh-mobile-hdmi: ASoC: DAPM unknown pin Mic Jack
>
>> After that the kernel log is spammed ca. 7 times per second with:
>
>>     sh-mobile-hdmi sh-mobile-hdmi: ASoC: DAPM unknown pin Headphones
>
>> Reverting commit 3fe240326cc395c66 ("ASoC: simple-card: Add mic and
>> hp detect gpios.") fixes this.
>
> The fix here is to not allow 0 as a GPIO in the core code (which
> should've been there already).

Unfortunately it's not there.

And it's not as simple as changing the definition of gpio_is_valid()
(crash in gpio_get_value()):

    gpiochip_add: GPIOs 0..211 (r8a7740_pfc) failed to register
    sh-pfc pfc-r8a7740: failed to init GPIO chip, ignoring...
    sh-pfc pfc-r8a7740: r8a7740_pfc support registered
    Unable to handle kernel NULL pointer dereference at virtual address 0000004c

Quoting Linus (https://lkml.org/lkml/2014/9/4/464):
"Fixing the old global GPIO numberspace API is a waste of time IMO".

Hence I've just sent a patch to initialize the GPIO numbers with -ENOENT.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
