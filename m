From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 14 Nov 2013 12:40:37 +0000
Subject: Re: [PATCH v2 01/03] clocksource: Add Kconfig entries for CMT, MTU2, TMU and STI
Message-Id: <201311141340.38208.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20131106110508.6806.48070.sendpatchset@w520> <20131106110518.6806.79333.sendpatchset@w520> <CANcMJZDJPbctuYgG0Wr64htUeak-XLf3EYK0vz-BbG320UkFGg@mail.gmail.com>
In-Reply-To: <CANcMJZDJPbctuYgG0Wr64htUeak-XLf3EYK0vz-BbG320UkFGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Stultz <john.stultz@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, khilman@linaro.org, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms@verge.net.au, olof@lixom.net, Thomas Gleixner <tglx@linutronix.de>

On Wednesday 13 November 2013, John Stultz wrote:
> > +config EM_TIMER_STI
> > +       bool "STI timer driver"
> > +       default y if ARM
> > +       help
> > +         This enables build of the STI timer driver.
> 
> 
> So since I do want to avoid adding user-selectable configs if
> possible, here are some concrete thoughts on this patch, trying to
> provide an example from my more abstract rants down thread. :)

I think we should be using the CONFIG_BUILD_TEST (or whatever
it's called) here to allow building the drivers everywhere but
at the same time be specific with the platform. How about this:

config EM_TIMER_STI
	bool "Renesas EMMA EV2 STI timer driver" if BUILD_TEST && !ARCH_EMEV2
	default ARCH_EMEV2
	help
	  ...

This makes it a silent option that is set correctly all the time
but lets you enable it everywhere when BUILD_TEST is set.

We could skip the "&& !ARCH_EMEV2" part to allow building an
EMEV2 kernel without this driver when build testing if that
is possible.

	Arnd
