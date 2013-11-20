From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Wed, 20 Nov 2013 08:33:09 +0000
Subject: Re: [PATCH v2 01/03] clocksource: Add Kconfig entries for CMT, MTU2, TMU and STI
Message-Id: <528C73C5.4050902@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20131106110508.6806.48070.sendpatchset@w520> <20131106110518.6806.79333.sendpatchset@w520> <CANcMJZDJPbctuYgG0Wr64htUeak-XLf3EYK0vz-BbG320UkFGg@mail.gmail.com> <201311141340.38208.arnd@arndb.de>
In-Reply-To: <201311141340.38208.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, khilman@linaro.org, linux-sh@vger.kernel.org, horms@verge.net.au, olof@lixom.net, Thomas Gleixner <tglx@linutronix.de>

On 11/14/2013 01:40 PM, Arnd Bergmann wrote:
> On Wednesday 13 November 2013, John Stultz wrote:
>>> +config EM_TIMER_STI
>>> +       bool "STI timer driver"
>>> +       default y if ARM
>>> +       help
>>> +         This enables build of the STI timer driver.
>>
>>
>> So since I do want to avoid adding user-selectable configs if
>> possible, here are some concrete thoughts on this patch, trying to
>> provide an example from my more abstract rants down thread. :)
>
> I think we should be using the CONFIG_BUILD_TEST (or whatever
> it's called) here to allow building the drivers everywhere but
> at the same time be specific with the platform. How about this:
>
> config EM_TIMER_STI
> 	bool "Renesas EMMA EV2 STI timer driver" if BUILD_TEST && !ARCH_EMEV2
> 	default ARCH_EMEV2
> 	help
> 	  ...
>
> This makes it a silent option that is set correctly all the time
> but lets you enable it everywhere when BUILD_TEST is set.

It sounds like a good compromise.

> We could skip the "&& !ARCH_EMEV2" part to allow building an
> EMEV2 kernel without this driver when build testing if that
> is possible.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

