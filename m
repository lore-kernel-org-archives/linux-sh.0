From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 05 Mar 2012 17:29:49 +0000
Subject: Re: [PATCH] sh_tmu / PM: Prevent power from being removed from TMU devices
Message-Id: <20120305172948.GA20226@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201203030041.30244.rjw@sisk.pl>
In-Reply-To: <201203030041.30244.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 05, 2012 at 05:01:20PM +0900, Magnus Damm wrote:
> On Mon, Mar 5, 2012 at 2:47 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Sun, Mar 04, 2012 at 10:50:53PM +0100, Rafael J. Wysocki wrote:
> >> On Sunday, March 04, 2012, Paul Mundt wrote:
> >> > Presumably we also need the same for the MTU2 and CMT drivers?
> >>
> >> Yes, we do in principle, although this isn't strictly necessary for things to
> >> work at the moment.
> >>
> >> I can post analogous patches for the other drivers if you want me to.
> >>
> > It would be nice to ensure that we don't run in to the same problems on
> > the other drivers in the interim at least. I'll take a look at getting
> > proper PM support taken care of for them afterwards.
> 
> I agree, but I wonder how much of an actual issue it is at this point.
> In the long run of course the drivers should be fixed up, but this
> patch more looks like a workaround for 3.3-rc.
> 
> As for actual hardware timers, MTU2 is not used on any platform with
> power domain support today and the CMT is located in a always-on power
> domain. So they should not cause any issues for 3.3-rc.
> 
It doesn't matter. If we're going to band-aid around the TMU case for a
PM incompatability then the same fix needs to be applied to the other
relevant drivers, barring a proper fix. We aren't going to be making
random band-aid fixes that in turn bring the drivers behaviourly out of
sync simply because of some imagined timeline issue with 3.3-rc. Again,
none of this thread would have even been necessary had the job been done
right from the beginning.
