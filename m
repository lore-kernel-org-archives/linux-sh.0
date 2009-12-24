From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 24 Dec 2009 05:10:21 +0000
Subject: Re: [RFC][PATCH 0/14] Convert remaining arches to read/update_persistent_clock
Message-Id: <20091224051021.GA28878@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1261540762.3508.61.camel@localhost.localdomain> <20091223050810.GA25791@linux-sh.org> <20091223.205415.232734959.davem@davemloft.net>
In-Reply-To: <20091223.205415.232734959.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org, rth@twiddle.net, linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org, linux@arm.linux.org.uk, hskinnemoen@atmel.com, vapier@gentoo.org, starvik@axis.com, dhowells@redhat.com, ysato@users.sourceforge.jp, tony.luck@intel.com, takata@linux-m32r.org, geert@linux-m68k.org, yasutake.koichi@jp.panasonic.com, kyle@mcmartin.ca

On Wed, Dec 23, 2009 at 08:54:15PM -0800, David Miller wrote:
> From: Paul Mundt <lethal@linux-sh.org>
> Date: Wed, 23 Dec 2009 14:08:10 +0900
> 
> > In any event, I wonder if it might make more sense to take something like
> > the SPARC implementation that is simply a wrapper around the RTC, move
> > that out in to a more generic place, and permit architectures to select
> > an RTC class backed persistent clock instead (it seems to be only
> > platforms that haven't caught up yet in terms of generic time and RTC
> > migration that would want to define this interface on their own at all at
> > this point)?
> 
> This sounds nice but don't we have a slew of RTC types that need
> to be accessed over I2C and thus you can't touch them without
> sleeping?

Yes, and SPI and so on. We do however have plenty of available room for
adding a valid-for-persistent-clock flag to permit drivers to opt-in, so
we can certainly still do better than the status quo. I'll hack something
up and see how it goes.
