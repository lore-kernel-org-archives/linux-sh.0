From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Jun 2009 04:22:15 +0000
Subject: Re: [PATCH 02/04] Driver Core: Add idle and wakeup functions
Message-Id: <aec7e5c30906082122v456b3e31x367a20f8a46e1b37@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100642.29671.52231.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100642.29671.52231.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Sat, Jun 6, 2009 at 5:42 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> On Friday 05 June 2009, Magnus Damm wrote:
>> On Wed, Jun 3, 2009 at 6:05 PM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
>> > On Friday 29 May 2009, Magnus Damm wrote:
>> >> 2009/5/29 Rafael J. Wysocki <rjw@sisk.pl>:
>> >> > On Wednesday 27 May 2009, Magnus Damm wrote:
>> >> >> From: Magnus Damm <damm@igel.co.jp>
>> >> >>
>> >> >> Add platform_device_idle() and platform_device_wakeup()
>> >> >> and allow architectures to implement their own versions
>> >> >> of these if CONFIG_HAVE_PLATFORM_IDLE_WAKEUP is set.
>> >> >>
>> >> >> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>> >> >> ---

>> The wakeup()/idle() code in this patch is one way to solve it on a
>> platform device level. Another more generic way would be to add
>> ->enable() and ->disable() callbacks to struct bus_type and introduce
>> device_enable() and device_disable() that takes struct device and
>> invokes the bus callbacks if set.
>
> So, you need a generic mechanism that drivers can use to notify the bus t=
ype
> code that a device is idle and therefore it should schedule an autosuspend
> request for the device. =A0Also, you want a mechanism by which drivers ca=
n notify
> the platform code that there is a need to wake-up an autosuspended device.
> Is that correct?

Yes, you are 100% correct that I want drivers to have some way to
notify the bus type that a certain device is idle or needs to be woken
up.

Exactly what should happen when the device is marked as idle is a
different question. I guess this is bus specific. Connecting the idle
notification directly to autosuspend is not a very good idea IMO since
the power management comes with latency restrictions.

If we zoom out a bit then I think that we should have something
similar to cpuidle but for devices. Maybe the driver should give a
list of suspend modes, their latencies and power savings. This per
driver (or per device) latency information is important, but even more
important IMO is latency information for the bus itself.

So for our on-chip SuperH SoC platform devices I'd like to keep track
of which devices that are idle, and if all devices within one power
domain are idle then i'd like to execute autosuspend() for those and
after that power off the bus/domain. But only if this doesn't break
any latency requirements.

Cheers,

/ magnus
