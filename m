From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 12 Mar 2009 05:47:10 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <aec7e5c30903112247j34ec3f35i72b5f218657999da@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Mar 11, 2009 at 10:20 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
>> =A0I'd like to do something like that at least. For the clock
>> framework i think we should simply minimize the clock when the usage
>> count drops to zero. And let the drivers disable the clock as long as
>> it's not needed for wakeup.
>
> Unfortunately it isn't so easy.
> If we have one-to-one clock per device a simple counter is enough, but if
> you have shared clocks (i.e. a clock X shared between a two wakeup devices
> than on suspend the first device could asks "clock_X @ xx MHz" the second
> device could asks "clock_X @ yy MHz" =A0and as platform device =A0the fin=
al rate
> of clock X will be based on how the devices were registered...

I understand the problem with the ordering. I wonder if converting
your shared clock into one parent clock and two children would help?
Each device connects to one child clock, and when requesting a clock
rate this rate gets stored in each child clock. The parent simply
determines the clock by MAX(c1, c2) where c1 and c2 are the child
clock rates.

> Moreover without a notification of the rate of each clock a wakeup device
> will be broken and it doesn't know it is broken.

Yeah, notification is needed.

>> ...
>> For the overall system my gut feeling is that it would be useful to
>> define a set of standby modes, and let the suspend code or cpuidle
>> enter the best mode possible after checking dependencies.
>
> Not so easy for us because we have some A-SMP therefore an "idle linux"
> doesn't mean an idle hardware.

Sure, but someone needs to be in control of power management. Even on
single core systems "idle linux" doesn't mean idle hardware. Say that
some hardware engine is programmed to crunch some data. The cpu is
idle. We cannot enter deep sleep because the hardware engine needs the
clock. But after the hardware engine is done it will issue an
interrupt, and the processor can wake up, do it's thing and go back to
sleep - deep sleep this time since the hardware engine isn't active.

I think the case above is very similar to multi core power management.
If you have time, please explain more about issues you've experienced
related to A-SMP.

In my mind, at least each independent domain needs some central point
(master) of power management. So if some processor would be a slave,
how about notifying the master before sleeping and let the master
handle the power management. This action may be the last part of some
application processor code where the master writes commands to an
mailbox and receives the results and get an interrupt as notification.

In the case above the application processor can sleep after that and
the power management code in the main processor will know this state.
I guess it becomes more difficult if the application processor
receives an interrupt from some other source and wakes up, but the
main processor needs to take the system ram out of self-refresh before
the application processor can start serving the interrupt..

> If I understood you are speaking on 'sleep' and 'deep sleep' capability of
> sh4. In this case in the ST40 this difference was removed.
> But the behavioral is similar (i.e.: mem in self-refresh, clocks
> disabled/reduced... wakeup devices still able to works).

The states that I mentioned are from SuperH Mobile. "sleep" and "deep
sleep" are black and white terms in a very gray world, so I should do
my best to stay away from them in the future. Other SH devices from
Renesas also do different levels of power management. In the end I
think this stuff is pretty standard all over the place, except the
clock dependencies that differ from architecture to architecture and
between processor families.

>> Are you using cpuidle?
>
> Not currently and I think it will be not so easy to use for us.

Because of A-SMP?
I have a cpuidle prototype running, but I need to improve the clock
framework code to track dependencies better before I can integrate it
upstream.

>> What about cpufreq?
>
> Supported.

Still on my TODO-list. The SuperH Mobile devices have quite a few
restrictions on which divider combinations that are allowed for the
system clocks. So if someone changes the processor clock for instance,
many other clocks may need to follow.

>> Do you have some profiles setup for run time power management today?
>
> We have a kernel tool to create "power profile" sits on top of
> cpufreq-clockfm-device model and until possible (currently possible) it
> doesn't touch any device driver; this means the device aren't aware of a
> change in term of power profile... they see change in term of
> clock_rate-device_state.

I see. Some partial system suspend (some devices suspended only) would
be good to have, don't you think?

Thanks for your comments!

/ magnus
