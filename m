From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Wed, 13 Nov 2013 21:14:53 +0000
Subject: Re: [PATCH v2 01/03] clocksource: Add Kconfig entries for CMT, MTU2, TMU and STI
Message-Id: <5283EBCD.9050007@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20131106110508.6806.48070.sendpatchset@w520>	<20131106110518.6806.79333.sendpatchset@w520>	<527B790B.4040200@linaro.org>	<CANqRtoSn7=NeY2bSpacCXn6tKatn1S+CP3r-+mka91b0neJ4kw@mail.gmail.com>	<527D2EA0.7060605@linaro.org>	<CANqRtoQJYqBmDh1e-kA9_3ea-pp0J1Cx9Pr87HieYYfr7y435A@mail.gmail.com> <CALAqxLVZdAs0V9ghA43VdP02+Rn=t4COZw_PRkZnWC=Q=OWLWA@mail.gmail.com>
In-Reply-To: <CALAqxLVZdAs0V9ghA43VdP02+Rn=t4COZw_PRkZnWC=Q=OWLWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: John Stultz <john.stultz@linaro.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Arnd Bergmann <arnd@arndb.de>, SH-Linux <linux-sh@vger.kernel.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>

On 11/12/2013 09:47 PM, John Stultz wrote:

[ ... ]

>> I think all your goals make sense, and I would like to reach the same
>> place from a usability point of view. I would however like to allow
>> existing power users to select whatever they want enabled on their
>> platform. Ideally I also would like to share Kconfig bits between
>> multiple architectures where appropriate, but it's just a few lines of
>> code so I don't care that much.
>
> And as long as the options for the power-users actually make sense,
> that all sounds fine. But I want to make sure we aren't needlessly
> causing pain to folks building kernels all to save a few lines of
> Kconfig logic.
>
> And again, this is just my pet peeve, I'm not the directory
> submaintainer any more, so Daniel and Thomas are the ones to convince.
> :)

So to summarize:

1. We want to prevent to manually select the drivers, this is painful to=20
have the right config. We assume the SoC config will choose the right=20
driver config option.

2. We want to disable some drivers because they could conflict. Or for=20
kernel builders, it is easier to hack around the options.

3. We want to select a driver as a module because the timer could reside=20
on a PCI board.

4. Code size could be an issue if everything is selected.

IMO, John's approach makes totally sense.

I am not worried about the code size because one day or another we will=20
have to fix up the code size increasing with the single zImage for ARM,=20
and we will probably end up to unload dynamically unneeded drivers from=20
the memory after booting (I don't how. Perhaps by some magic with the=20
init sections).

Disabling some drivers, or in other words, give more customization=20
options to the kernel builders, makes also sense.

It isn't possible to select the driver as we do right now but let them=20
optional from the Kconfig ? What if we invert the logic in the Kconfig,=20
make each driver depends on a arch_option defaulting to 'yes', so it can=20
be manually unselected (similar to drivers/cpuidle/Kconfig.arm).

In any case, consolidating SH and ARM Kconfig is ok but with a change=20
which is consistent with the current Kconfig, that is following the=20
policy of the Kconfig (on top of the current one or on top of a new one).

   -- Daniel




--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

