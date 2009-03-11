From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 11 Mar 2009 07:29:34 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <aec7e5c30903110029j145611e5n649f3d8bf03ff971@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi again Francesco,

On Wed, Mar 11, 2009 at 3:50 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> While we are 'fixing' the clock framework on resume from hibernation.
> I'd like to do some similar thing on suspend/resume from standby.

Good plan! I'd like to have this working for suspend as well.

> I was thinking to add some flags/capability able to say to the framework
> what it has to be done in standby.
> Something like:
>
> #define CLK_TURNOFF_ON_SUSPEND =A0 ....
> #define CLK_REDUCE_ON_SUSPEND ...
>
> In this manner in the single file where the clock tree is described we ha=
ve
> a clear view of all the scenario
> (normal runtime, suspend, hibernation)...
> Moreover this should not impact "medium" power level.

I guess your goal is to minimize power consumption by turning off
unused clocks or at least set them to a minimal value before
suspending. I'd like to do something like that at least. For the clock
framework i think we should simply minimize the clock when the usage
count drops to zero. And let the drivers disable the clock as long as
it's not needed for wakeup.

If you're talking about frequency control then maybe cpufreq is a good
option. I'm not sure about this yet, it's still on my TODO list.

For the overall system my gut feeling is that it would be useful to
define a set of standby modes, and let the suspend code or cpuidle
enter the best mode possible after checking dependencies.

Right now I have the following modes setup for SuperH Mobile:

#define SUSP_MODE_SLEEP                (SUSP_SH_SLEEP)
#define SUSP_MODE_SLEEP_SF     (SUSP_SH_SLEEP | SUSP_SH_SF)
#define SUSP_MODE_STANDBY_SF   (SUSP_SH_STANDBY | SUSP_SH_SF)

The first is just plain old light sleep using the sleep instruction -
nothing exciting.

The second is a bit better since it puts the system ram in
self-refresh mode but the processor is still sleeping lightly. Before
entering this mode the code needs to make sure that no hardware is
using the system memory, ie we cannot enter this if some hardware is
bus mastering. We can however enter this mode waiting for incoming
data on a SCIF.

The third mode turns off the clock so system ram self-refresh is
needed. We cannot enter this mode if hardware blocks that use the
clocks are active. Or if we need the clock enabled to be able to
wakeup. =3D)

There is one additional level that turns off the power to the hardware
blocks as well. This mode is close to hibernation from a software
point of view. I guess a good match is to use dev_pm_ops->freeze to
save hardware state before suspending and use thaw to restore state
when resuming. Obviously we can't power off hardware blocks needed for
wakeup.

How is this compared to your architecture(s)?
Are you using cpuidle?
What about cpufreq?
Do you have some profiles setup for run time power management today?

Cheers,

/ magnus
