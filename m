From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 Oct 2014 12:32:57 +0000
Subject: Re: [PATCH] ASoC: simple-card: Add mic and hp detect gpios.
Message-Id: <CAMuHMdWh=sXAD59T1T=gvROX+fbF6=gFo6C0nkJdfnCrdNrwYg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412198720-2326-1-git-send-email-dgreid@chromium.org>
	<20141002155350.GU4273@sirena.org.uk>
In-Reply-To: <20141002155350.GU4273@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Dylan Reid <dgreid@chromium.org>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, jay.xu@rock-chips.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, sonnyrao@chromium.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Mark, Dylan,

On Thu, Oct 2, 2014 at 5:53 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Oct 01, 2014 at 02:25:20PM -0700, Dylan Reid wrote:
>> Allow Headphone and Microphone jack detect gpios to be specified in
>> device tree.  This will allow a few systems including rk3288_max98090
>> to use simple-card instead of having their own board file.
>
> Applied, thanks.

Unfortunately there's no equivalent code for platform data, and the
uninitialized default of 0 for gpio_hp_det and gpio_mic_det doesn't
play well with asm-generic's gpio_is_valid():

static inline bool gpio_is_valid(int number)
{
        return number >= 0 && number < ARCH_NR_GPIOS;
}

Hence on r8a7740/armadillo-legacy, which uses platform devices instead of DT:

    sh-mobile-hdmi sh-mobile-hdmi: SH Mobile HDMI Audio Codec
    sh-mobile-hdmi sh-mobile-hdmi: ASoC: DAPM unknown pin Headphones
    sh-mobile-hdmi sh-mobile-hdmi: ASoC: DAPM unknown pin Mic Jack

After that the kernel log is spammed ca. 7 times per second with:

    sh-mobile-hdmi sh-mobile-hdmi: ASoC: DAPM unknown pin Headphones

Reverting commit 3fe240326cc395c66 ("ASoC: simple-card: Add mic and
hp detect gpios.") fixes this.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
