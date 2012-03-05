From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 05 Mar 2012 20:32:26 +0000
Subject: Re: [PATCH] sh_tmu / PM: Prevent power from being removed from TMU devices
Message-Id: <201203052132.26581.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201203030041.30244.rjw@sisk.pl>
In-Reply-To: <201203030041.30244.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, March 05, 2012, Paul Mundt wrote:
> On Mon, Mar 05, 2012 at 05:01:20PM +0900, Magnus Damm wrote:
> > On Mon, Mar 5, 2012 at 2:47 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > > On Sun, Mar 04, 2012 at 10:50:53PM +0100, Rafael J. Wysocki wrote:
> > >> On Sunday, March 04, 2012, Paul Mundt wrote:
> > >> > Presumably we also need the same for the MTU2 and CMT drivers?
> > >>
> > >> Yes, we do in principle, although this isn't strictly necessary for things to
> > >> work at the moment.
> > >>
> > >> I can post analogous patches for the other drivers if you want me to.
> > >>
> > > It would be nice to ensure that we don't run in to the same problems on
> > > the other drivers in the interim at least. I'll take a look at getting
> > > proper PM support taken care of for them afterwards.
> > 
> > I agree, but I wonder how much of an actual issue it is at this point.
> > In the long run of course the drivers should be fixed up, but this
> > patch more looks like a workaround for 3.3-rc.
> > 
> > As for actual hardware timers, MTU2 is not used on any platform with
> > power domain support today and the CMT is located in a always-on power
> > domain. So they should not cause any issues for 3.3-rc.
> > 
> It doesn't matter. If we're going to band-aid around the TMU case for a
> PM incompatability then the same fix needs to be applied to the other
> relevant drivers, barring a proper fix.

There is a problem applying that "fix" (or perhaps workaround would be a better
name) to the CMT driver, because that would make the system never suspend,
which isn't exactly desirable.  Sorry that I didn't notice that earlier.

> We aren't going to be making
> random band-aid fixes that in turn bring the drivers behaviourly out of
> sync simply because of some imagined timeline issue with 3.3-rc. Again,
> none of this thread would have even been necessary had the job been done
> right from the beginning.

Well, there seems to be a problem with TMU and system suspend that isn't
directly related to turning off the A4R domain (system resume doesn't appear
to work with TMU even if that domain is always on).  And it looks like that
problem has been there forever.

Anyway, to use the same approach in all three drivers we need a flag that
will allow a driver to say "don't power down the domain this device belongs to"
to the core.  It shouldn't be very difficult to introduce it, but I'm still
not sure that will make the "TMU vs system resume" problem mentioned above go
away.

I'll try to prepare a patch for that later today anyway.

Thanks,
Rafael
