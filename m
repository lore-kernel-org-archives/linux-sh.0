From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 05 Jun 2009 20:42:07 +0000
Subject: Re: [PATCH 02/04] Driver Core: Add idle and wakeup functions
Message-Id: <200906052242.08266.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100642.29671.52231.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100642.29671.52231.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday 05 June 2009, Magnus Damm wrote:
> On Wed, Jun 3, 2009 at 6:05 PM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> > On Friday 29 May 2009, Magnus Damm wrote:
> >> 2009/5/29 Rafael J. Wysocki <rjw@sisk.pl>:
> >> > On Wednesday 27 May 2009, Magnus Damm wrote:
> >> >> From: Magnus Damm <damm@igel.co.jp>
> >> >>
> >> >> Add platform_device_idle() and platform_device_wakeup()
> >> >> and allow architectures to implement their own versions
> >> >> of these if CONFIG_HAVE_PLATFORM_IDLE_WAKEUP is set.
> >> >>
> >> >> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> >> >> ---
> >> >>
> >> >>  Yes, this needs documentation. See [00/04] for now.
> >> >>
> >> >>  arch/Kconfig                    |    3 +++
> >> >>  include/linux/platform_device.h |    8 ++++++++
> >> >>  2 files changed, 11 insertions(+)
> >> >>
> >> >> --- 0002/arch/Kconfig
> >> >> +++ work/arch/Kconfig 2009-05-26 12:31:06.000000000 +0900
> >> >> @@ -115,3 +115,6 @@ config HAVE_DEFAULT_NO_SPIN_MUTEXES
> >> >>
> >> >>  config HAVE_PLATFORM_DEVICE_ARCHDATA
> >> >>       bool
> >> >> +
> >> >> +config HAVE_PLATFORM_DEVICE_IDLE_WAKEUP
> >> >
> >> > Again, I'm not sure if the new CONFIG_ option is really necessary.
> >>
> >> At least it could be combined into a single option for platform device
> >> runtime pm. So no need to have separate kconfig options for [02/04]
> >> and [03/04].
> >>
> >> We could also drop the #ifdef stuff and go for weak symbols that can
> >> be overriden by architecture code.
> >
> > The weak symbols don't work really AFAICS.  People have been replacing them
> > with alternative things recently.
> >
> >> I'm open to suggestions. =)
> >
> > Well, that depends on what exactly you want to achieve. :-)
> 
> =)
> 
> I'd like an architecture independent interface upstream that makes it
> possible for device drivers to notify the architecture code that they
> are idle() and that need wakeup().
> 
> In the long term I hope we can share a great deal of runtime PM code
> between architectures, but for now we just need some architecture
> specific hooks to get started.
> 
> The wakeup()/idle() code in this patch is one way to solve it on a
> platform device level. Another more generic way would be to add
> ->enable() and ->disable() callbacks to struct bus_type and introduce
> device_enable() and device_disable() that takes struct device and
> invokes the bus callbacks if set.

So, you need a generic mechanism that drivers can use to notify the bus type
code that a device is idle and therefore it should schedule an autosuspend
request for the device.  Also, you want a mechanism by which drivers can notify
the platform code that there is a need to wake-up an autosuspended device.
Is that correct?

Rafael
