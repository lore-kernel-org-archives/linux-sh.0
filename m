From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Tue, 18 Jun 2013 08:24:26 +0000
Subject: Re: [PATCH/RFC] clockevents: Ignore C3STOP when CPUIdle is disabled
Message-Id: <51C0193A.40607@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20130618071756.22598.51046.sendpatchset@w520> <51C00D08.3080406@linaro.org> <CANqRtoR-f6SXE0HFw_giJj3PMas-WZA_WvmkTL2rA-jVj_2QCA@mail.gmail.com>
In-Reply-To: <CANqRtoR-f6SXE0HFw_giJj3PMas-WZA_WvmkTL2rA-jVj_2QCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, SH-Linux <linux-sh@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Simon Horman [Horms]" <horms@verge.net.au>, John Stultz <john.stultz@linaro.org>, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>, Thomas Gleixner <tglx@linutronix.de>

On 06/18/2013 09:39 AM, Magnus Damm wrote:
> On Tue, Jun 18, 2013 at 4:32 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 06/18/2013 09:17 AM, Magnus Damm wrote:
>>> From: Magnus Damm <damm@opensource.se>
>>>
>>> Introduce the function tick_device_may_c3stop() that
>>> ignores the C3STOP flag in case CPUIdle is disabled.
>>>
>>> The C3STOP flag tells the system that a clock event
>>> device may be stopped during deep sleep, but if this
>>> will happen or not depends on things like if CPUIdle
>>> is enabled and if a CPUIdle driver is available.
>>>
>>> This patch assumes that if CPUIdle is disabled then
>>> the sleep mode triggering C3STOP will never be entered.
>>> So by ignoring C3STOP when CPUIdle is disabled then it
>>> becomes possible to use high resolution timers with only
>>> per-cpu local timers - regardless if they have the
>>> C3STOP flag set or not.
>>>
>>> Observed on the r8a73a4 SoC that at this point only uses
>>> ARM architected timers for clock event and clock sources.
>>>
>>> Without this patch high resolution timers are run time
>>> disabled on the r8a73a4 SoC - this regardless of CPUIdle
>>> is disabled or not.
>>>
>>> The less short term fix is to add support for more timers
>>> on the r8a73a4 SoC, but until CPUIdle support is enabled
>>> it must be possible to use high resoultion timers without
>>> additional timers.
>>>
>>> I'd like to hear some feedback and also test this on more
>>> systems before merging the code, see the non-SOB below.
>>
>> Do we need a broadcast timer when cpuidle is not compiled in the kernel ?
>=20
> Yes, if there is no per-cpu timer available. It depends on what the
> SMP support code for a particular SoC or architecture happen to
> enable.

Ok thanks for the information.

There is here a multiple occurrence of the information "the timer will
stop when power is saved": CLOCK_EVT_FEAT_C3STOP and
CPUIDLE_FLAG_TIMER_STOP, so I am wondering if some code simplification
couldn't be done before your patch.

The function:

tick_broadcast_oneshot_control is called from clockevents_notify. This
one is called from the cpuidle framework or the back-end cpuidle driver.
The caller knows the timer will be stop and this is why it is switching
to the broadcast mode. But we have a sanity check in
tick_broadcast_oneshot_control function:

        if (!(dev->features & CLOCK_EVT_FEAT_C3STOP))
                return;

In other words, CPUIDLE_FLAG_TIMER_STOP will tell the framework to call
clockevents_notify and the tick broadcast code will re-check the device
will effectively go down. IMHO, we can get rid of this check.

The same happens for the tick_do_broadcast_on_off function.

That reduces the number of C3STOP usage.

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

