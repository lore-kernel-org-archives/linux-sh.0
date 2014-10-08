From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 08 Oct 2014 08:50:00 +0000
Subject: Re: [PATCH] ASoC: simple-card: Add mic and hp detect gpios.
Message-Id: <CACRpkdY+KQ1OMh565desoqVP-AUJL-VjFx-D5LiaNpXs5oOsnA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412198720-2326-1-git-send-email-dgreid@chromium.org>
 <20141002155350.GU4273@sirena.org.uk>
 <CAMuHMdWh=sXAD59T1T=gvROX+fbF6=gFo6C0nkJdfnCrdNrwYg@mail.gmail.com>
 <20141007123856.GF4609@sirena.org.uk>
 <CAMuHMdV39fM_TCa+WSvswij6dxD2vwfJT+FueBtxndpsymP9CQ@mail.gmail.com>
 <20141007163654.GJ4609@sirena.org.uk>
 <CAAVeFuJB=bF3g2czT1ed1UX85R_hBXqFAKdeLJcASRcXQujFJw@mail.gmail.com>
In-Reply-To: <CAAVeFuJB=bF3g2czT1ed1UX85R_hBXqFAKdeLJcASRcXQujFJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <gnurou@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux-sh list <linux-sh@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Dylan Reid <dgreid@chromium.org>, jay.xu@rock-chips.com, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

On Wed, Oct 8, 2014 at 9:05 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Wed, Oct 8, 2014 at 1:36 AM, Mark Brown <broonie@kernel.org> wrote:
>> On Tue, Oct 07, 2014 at 03:10:01PM +0200, Geert Uytterhoeven wrote:

>> Right, obviously it's not going to work if the platform actually uses 0
>> as a valid GPIO.
>>
>>> Quoting Linus (https://lkml.org/lkml/2014/9/4/464):
>>> "Fixing the old global GPIO numberspace API is a waste of time IMO".
>>
>>> Hence I've just sent a patch to initialize the GPIO numbers with -ENOENT.
>>
>> I do think it's worth renumbering the platforms since it's *relatively*
>> little work per platform compared to completing the gpiod transition.
>
> But transition to gpiod is the way to ultimately fix this issue, as
> well as many others. Not to mention that renumbering GPIOs will
> certainly make a few users of the GPIO sysfs (another abomination,
> agreed) unhappy. I can only recommend switching drivers to gpiod when
> such issues are spotted.

Yeah that is another issue ... we end up in catch 22 situations like
that, renumber the GPIOs, OK, then we break the ABI.

Admittedly that "ABI" is something people break all the time,
/sys/*gpioN just isnt what it should be, not stable at all.

I'm not against renumbering GPIO if it's minor effort, but if it
start to consume hundreds of hours and regressions and what not,
that time is better spent focusing on the gpiod transition.

Yours,
Linus Walleij
