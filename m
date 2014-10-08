From: Alexandre Courbot <gnurou@gmail.com>
Date: Wed, 08 Oct 2014 07:05:59 +0000
Subject: Re: [PATCH] ASoC: simple-card: Add mic and hp detect gpios.
Message-Id: <CAAVeFuJB=bF3g2czT1ed1UX85R_hBXqFAKdeLJcASRcXQujFJw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412198720-2326-1-git-send-email-dgreid@chromium.org>
 <20141002155350.GU4273@sirena.org.uk> <CAMuHMdWh=sXAD59T1T=gvROX+fbF6=gFo6C0nkJdfnCrdNrwYg@mail.gmail.com>
 <20141007123856.GF4609@sirena.org.uk> <CAMuHMdV39fM_TCa+WSvswij6dxD2vwfJT+FueBtxndpsymP9CQ@mail.gmail.com>
 <20141007163654.GJ4609@sirena.org.uk>
In-Reply-To: <20141007163654.GJ4609@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij <linus.walleij@linaro.org>, Dylan Reid <dgreid@chromium.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, jay.xu@rock-chips.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, sonnyrao@chromium.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Wed, Oct 8, 2014 at 1:36 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Oct 07, 2014 at 03:10:01PM +0200, Geert Uytterhoeven wrote:
>> On Tue, Oct 7, 2014 at 2:38 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > The fix here is to not allow 0 as a GPIO in the core code (which
>> > should've been there already).
>
>> Unfortunately it's not there.
>
>> And it's not as simple as changing the definition of gpio_is_valid()
>> (crash in gpio_get_value()):
>
>>     gpiochip_add: GPIOs 0..211 (r8a7740_pfc) failed to register
>>     sh-pfc pfc-r8a7740: failed to init GPIO chip, ignoring...
>>     sh-pfc pfc-r8a7740: r8a7740_pfc support registered
>>     Unable to handle kernel NULL pointer dereference at virtual address 0000004c
>
> Right, obviously it's not going to work if the platform actually uses 0
> as a valid GPIO.
>
>> Quoting Linus (https://lkml.org/lkml/2014/9/4/464):
>> "Fixing the old global GPIO numberspace API is a waste of time IMO".
>
>> Hence I've just sent a patch to initialize the GPIO numbers with -ENOENT.
>
> I do think it's worth renumbering the platforms since it's *relatively*
> little work per platform compared to completing the gpiod transition.

But transition to gpiod is the way to ultimately fix this issue, as
well as many others. Not to mention that renumbering GPIOs will
certainly make a few users of the GPIO sysfs (another abomination,
agreed) unhappy. I can only recommend switching drivers to gpiod when
such issues are spotted.
