From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 06 Mar 2012 02:07:14 +0000
Subject: Re: [PATCH] sh_tmu / PM: Prevent power from being removed from TMU devices
Message-Id: <20120306020713.GB20226@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201203030041.30244.rjw@sisk.pl>
In-Reply-To: <201203030041.30244.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 05, 2012 at 11:46:08PM +0100, Rafael J. Wysocki wrote:
> On Monday, March 05, 2012, Rafael J. Wysocki wrote:
> > Anyway, to use the same approach in all three drivers we need a flag that
> > will allow a driver to say "don't power down the domain this device belongs to"
> > to the core.  It shouldn't be very difficult to introduce it, but I'm still
> > not sure that will make the "TMU vs system resume" problem mentioned above go
> > away.
> > 
> > I'll try to prepare a patch for that later today anyway.
> 
> Is appended.  Without a changelog for now, because I need to add CMT and
> MTU2 to it still.
> 
The updated version looks much nicer, and the interaction with early
platform entry is quite obvious. If we can reuse this for CMT and MTU2
then that should about take care of it. Thanks for persisting!
