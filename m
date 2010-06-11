From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 11 Jun 2010 05:02:26 +0000
Subject: Re: [PATCH v2] sh_tmu: compute mult and shift before registration
Message-Id: <AANLkTinWaSNOjX65MSCg5_0IS-KLbHwzxgX446shFBlU@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
In-Reply-To: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 11, 2010 at 12:03 PM, john stultz <johnstul@us.ibm.com> wrote:
> On Thu, 2010-06-10 at 12:27 -0700, john stultz wrote:
>> On Thu, 2010-06-10 at 15:20 +0900, Magnus Damm wrote:
>> > On Tue, Jun 8, 2010 at 4:28 AM, john stultz <johnstul@us.ibm.com> wrote:
>> > > Does that sound reasonable?
>> >
>> > I think so. So like I mentioned earlier, we don't know what frequency
>> > range is suitable at clock source registration time. So from that
>> > point of view I can't really see why we should keep the
>> > clocksource_register_hz()/khz() functions. Updating the frequency in
>> > the ->enable() callback and using clocksource_register() sounds simple
>> > and straightforward to me. Ideally I'd like to avoid setting up the
>> > mult and shift values before registration and instead put all logic in
>> > the ->enable() callback.
>> >
>> > The ->enable() callback is optional so we will have to deal with
>> > clocksources without ->enable() callbacks. This should be trivial -
>> > such drivers can manually setup shift/mult or call
>> > __clocksource_update_freq() before clocksource_register().
>>
>> Why not instead register the tmu clocksource with a dummy freq initially
>> and then update it in ->enable()?

Sure, that's doable, no problem. If that's what you prefer then that's fine.

I do however think that the interface would be cleaner without an
initial dummy frequency.

Is there anything that actually needs the frequency at registration time?

I may be wrong, but wouldn't the same thing be accomplished by keeping
clocksource_register() as-is, use
__clocksource_updatefreq_hz() before clocksource_register() for
drivers that doesn't use ->enable(), and on top of all this extend
timekeeper_setup_internals() to include the cs->max_idle_ns
calculation?

>> I'd just prefer to not complicate the majority of clocksources just to
>> handle the few (2) cases where we don't know the frequency at
>> registration time.

Sure, I can understand that.

> So I took a rough shot at this. Would you mind checking it out and
> seeing if its sufficient?
>
> Its my first two patches from the conversion patchset here:
> http://sr71.net/~jstultz/timekeeping/clocksourceregister_hz/patches/

Thanks for your work on this!

> Specifically:
> http://sr71.net/~jstultz/timekeeping/clocksourceregister_hz/patches/0001-Add-__clocksource_updatefreq_hz-khz-methods.patch

The patch above looks good, but if you decide to update then you may
want to spellcheck the comment in the last hunk:
s/clcoksource/clocksource/g

> http://sr71.net/~jstultz/timekeeping/clocksourceregister_hz/patches/0002-Convert-sh_tmu-sh_cmt-clocksources-to-clocksource_re.patch
>
> Let me know if there's anything I'm missing.

For the CMT driver I think it's best to begin with reverting the
commit f4d7c3565c1692c54d9152b52090fe73f0029e37 and then add your
changes on top of that.

From my point of view we really don't want to have the unused
clk_enable((), clk_get_rate(), clk_disable() hackery left in the
drivers.

Perhaps the same thing should be done for the TMU as well, any ideas Paul?

I agree with adding a __clocksource_updatefreq_hz(cs, p->rate) line to
sh_cmt_clocksource_enable(), but the p->rate value should already be
up to date so I don't think you need to add any clk_get_rate() call.

Want me to hack up a replacement patch?

Thanks,

/ magnus
