From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Wed, 11 Mar 2009 13:20:17 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <49B7BA91.3080608@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus
>
> Good plan! I'd like to have this working for suspend as well.
Good.
>
> I guess your goal is to minimize power consumption by turning off
> unused clocks or at least set them to a minimal value before
> suspending.
Yes.
>  I'd like to do something like that at least. For the clock
> framework i think we should simply minimize the clock when the usage
> count drops to zero. And let the drivers disable the clock as long as
> it's not needed for wakeup.
Unfortunately it isn't so easy.
If we have one-to-one clock per device a simple counter is enough, but 
if you have shared clocks (i.e. a clock X shared between a two wakeup 
devices than on suspend the first device could asks "clock_X @ xx MHz" 
the second device could asks "clock_X @ yy MHz"  and as platform device  
the final rate of clock X will be based on how the devices were 
registered...
Moreover without a notification of the rate of each clock a wakeup 
device will be broken and it doesn't know it is broken.

> ...
> For the overall system my gut feeling is that it would be useful to
> define a set of standby modes, and let the suspend code or cpuidle
> enter the best mode possible after checking dependencies.
Not so easy for us because we have some A-SMP therefore an "idle linux" 
doesn't mean an idle hardware.
>
> Right now I have the following modes setup for SuperH Mobile:
>
> #define SUSP_MODE_SLEEP                (SUSP_SH_SLEEP)
> #define SUSP_MODE_SLEEP_SF     (SUSP_SH_SLEEP | SUSP_SH_SF)
> #define SUSP_MODE_STANDBY_SF   (SUSP_SH_STANDBY | SUSP_SH_SF)
>
>
> There is one additional level that turns off the power to the hardware
> blocks as well. This mode is close to hibernation from a software
> point of view.
Yes also us we plan something like that.
>  I guess a good match is to use dev_pm_ops->freeze to
> save hardware state before suspending and use thaw to restore state
> when resuming.

>  Obviously we can't power off hardware blocks needed for
> wakeup.
>
> How is this compared to your architecture(s)?
On  SUSP_MODE_SLEEP_SF and SUSP_MODE_STANDBY_SF.
If I understood you are speaking on 'sleep' and 'deep sleep' capability 
of sh4. In this case in the ST40 this difference was removed.
But the behavioral is similar (i.e.: mem in self-refresh, clocks 
disabled/reduced... wakeup devices still able to works).

> Are you using cpuidle?
Not currently and I think it will be not so easy to use for us.
> What about cpufreq?
Supported.
> Do you have some profiles setup for run time power management today?
We have a kernel tool to create "power profile" sits on top of 
cpufreq-clockfm-device model and until possible (currently possible) it 
doesn't touch any device driver; this means the device aren't aware of a 
change in term of power profile... they see change in term of 
clock_rate-device_state.

Regards
 Francesco
