From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Dec 2009 10:08:51 +0000
Subject: Re: [RFC][PATCH 0/14] Convert remaining arches to
Message-Id: <10f740e80912230208g6237c530k8c70d9375efbd463@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1261540762.3508.61.camel@localhost.localdomain>
	 <20091223050810.GA25791@linux-sh.org>
In-Reply-To: <20091223050810.GA25791@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Mike Frysinger <vapier@gentoo.org>, Mikael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Tony Luck <tony.luck@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Kyle McMartin <kyle@mcmartin.ca>, "David S. Miller" <davem@davemloft.net>

On Wed, Dec 23, 2009 at 06:08, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Dec 22, 2009 at 07:59:22PM -0800, john stultz wrote:
>> In this case the generic read_persistent_clock() and
>> update_persistent_clock() methods have been provided to allow the
>> generic timekeeping code to initialize xtime and set the persistent
>> clock when NTP is synced. However many arches haven't converted, so the
>> generic code has to handle the case where the arch is doing this
>> management itself.
>>
>> This patch series tries to convert the following 14 architectures over
>> to use read_persistent_clock() and update_persistent_clock() as
>> applicable, killing off about 200 lines of arch specific code.
>>
> While I think that this is a good goal, many of the underlying
> architectures have veered pretty far away from having meaningful
> persistent clock interfaces after having moved entirely to generic
> timekeeping and the RTC subsystem.

Indeed. When moving to the RTC subsystem, you loose the persistent
clock at boot;
i.e. on m68k, mach_hwclk() can no longer be set, as the RTC driver is
in a separate
(possible loadable) module.

> In the case of SH at least that interface along with the generic CMOS
> stuff is largely a stop-gap for antiquated platforms that don't have
> proper RTC drivers and likely never will, while the default for all of
> the rest of the platforms effectively returns a fixed dummy value. I
> copied this approach from MIPS originally, so there are at least a few
> architectures that this will apply to.
>
> In any event, I wonder if it might make more sense to take something like
> the SPARC implementation that is simply a wrapper around the RTC, move
> that out in to a more generic place, and permit architectures to select
> an RTC class backed persistent clock instead (it seems to be only
> platforms that haven't caught up yet in terms of generic time and RTC
> migration that would want to define this interface on their own at all at
> this point)?

Hmm, haven't looked into how SPARC handles this yet...
Yes, looks like a good idea to me. Any disadvantages with this approach?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
