From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 10 Jun 2010 06:20:58 +0000
Subject: Re: [PATCH v2] sh_tmu: compute mult and shift before registration
Message-Id: <AANLkTinfggmZIv9G_3xCasSHlgxl8obCtgZsNh3zA2az@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
In-Reply-To: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 8, 2010 at 4:28 AM, john stultz <johnstul@us.ibm.com> wrote:
> On Mon, 2010-06-07 at 16:06 +0900, Magnus Damm wrote:
>> On Wed, Jun 2, 2010 at 5:23 PM, Paul Mundt <lethal@linux-sh.org> wrote:
>> > On Mon, May 31, 2010 at 11:45:48PM +0200, Aurelien Jarno wrote:
>> >> Since commit 98962465ed9e6ea99c38e0af63fe1dcb5a79dc25 ("nohz: Prevent
>> >> clocksource wrapping during idle"), the CPU of an R2D board never goes
>> >> to idle. This commit assumes that mult and shift are assigned before
>> >> the clocksource is registered. As a consequence the safe maximum sleep
>> >> time is negative and the CPU never goes into idle.
>> >>
>> >> This patch fixes the problem by moving mult and shift initialization
>> >> from sh_tmu_clocksource_enable() to sh_tmu_register_clocksource().
>> >>
>> >> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>> >
>> > Applied, thanks.
>> >
>> > I've made a similar change for the sh_cmt driver, too.
>> >
>> > Both of these should show up in the next 2.6.34-stable release.
>>
>> Thanks for this!
>>
>> However, with the CMT patch applied the clock seems to run too fast.
>> Requesting a 5 second sleep results in less than a second. The
>> LED-based heart beat is really busy! =)
>>
>> Switching back to a jiffies-based clock source work arounds the
>> problem. This is regardless of the CONFIG_NO_HZ setting.
>>
>> Proposal:
>>
>> Since the clock frequency of the clock provided by the clock framework
>> may vary when it is disabled, perhaps it's good to keep the existing
>> CMT code as-is and instead work towards updating the generic clock
>> source code to calculate values after the clock source has been
>> enabled.
>>
>> The problem is that we don't know the frequency of the timers at
>> registration time. So most of the clock source calculation happens
>> after enable today. I added the ->enable() and ->disable() callbacks
>> last year to solve this ordering issue. The cs->max_idle_ns variable
>> seems to be a special case though.
>>
>> Perhaps cs->max_idle_ns can be calculated after the clock source has
>> been enabled, for instance inside timerkeeper_setup_internals()?
>>
>> Or are there better ways to deal with this?
>
> I recently ran into this issue when looking to convert clocksources from
> using clocksource_register() to clocksource_register_hz()/khz().
>
> The point of those patches are to try to remove the mult/shift
> calculation from the clocksource driver code, keeping that logic in the
> timekeeping core (which will allow for better optimization of other
> values like max_idle_ns).

This common code for mult/shift calculation is very useful I think.

That aside, I have to admit that I don't fully understand which of the
_hz()/khz() I'm supposed to use. Say that I have a hardware counter
that is in the MHz range, which should I use?

And for a 4Khz counter?

Isn't it possible to just have a single __clocksource_update_freq()
function that checks the range and adjusts the scale? Perhaps there is
something that I'm not getting...

> So I'd suggest a generic method to the effect of
> "__clocksource_update_hz/khz" which can allow clocksource drivers to
> update the freq in enable call path. This can then hook into the
> timekeeping core so we update things there.
>
> Does that sound reasonable?

I think so. So like I mentioned earlier, we don't know what frequency
range is suitable at clock source registration time. So from that
point of view I can't really see why we should keep the
clocksource_register_hz()/khz() functions. Updating the frequency in
the ->enable() callback and using clocksource_register() sounds simple
and straightforward to me. Ideally I'd like to avoid setting up the
mult and shift values before registration and instead put all logic in
the ->enable() callback.

The ->enable() callback is optional so we will have to deal with
clocksources without ->enable() callbacks. This should be trivial -
such drivers can manually setup shift/mult or call
__clocksource_update_freq() before clocksource_register().

> The timekeeping code really isn't expecting clocksource values to change
> under it. So we'll also have to carefully review some of the max_idle_ns
> users to make sure they can handle the change.

I may be wrong, but it looks like the clocksource is still unused when
->enable() callback is invoked.

Thanks,

/ magnus
