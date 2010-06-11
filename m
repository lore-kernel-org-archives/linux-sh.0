From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 11 Jun 2010 04:38:33 +0000
Subject: Re: [PATCH v2] sh_tmu: compute mult and shift before registration
Message-Id: <AANLkTimDPtdNGdip28i1Yv7vdrUcT0020Z-hmpw9EpFH@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
In-Reply-To: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 11, 2010 at 4:27 AM, john stultz <johnstul@us.ibm.com> wrote:
> On Thu, 2010-06-10 at 15:20 +0900, Magnus Damm wrote:
>> On Tue, Jun 8, 2010 at 4:28 AM, john stultz <johnstul@us.ibm.com> wrote:
>> > I recently ran into this issue when looking to convert clocksources from
>> > using clocksource_register() to clocksource_register_hz()/khz().
>> >
>> > The point of those patches are to try to remove the mult/shift
>> > calculation from the clocksource driver code, keeping that logic in the
>> > timekeeping core (which will allow for better optimization of other
>> > values like max_idle_ns).
>>
>> This common code for mult/shift calculation is very useful I think.
>>
>> That aside, I have to admit that I don't fully understand which of the
>> _hz()/khz() I'm supposed to use. Say that I have a hardware counter
>> that is in the MHz range, which should I use?
>
> You probably want use the _hz interface if possible. The khz() interface
> is for very high frequency counters (like the TSC) where its possible
> the hz value wouldn't fit in a u32.

Ah, I see. Thanks for the explanation.

>> And for a 4Khz counter?
>
> Again, _hz is probably ideal for precision, but there's no issue using
> the khz value if that's what the platform provides you with (ie: you
> won't get any better precision by multiplying it up).
>
>
>> Isn't it possible to just have a single __clocksource_update_freq()
>> function that checks the range and adjusts the scale? Perhaps there is
>> something that I'm not getting...

I don't understand why you need two separate functions for the
scaling? Perhaps for readability or making the code more determinstic
somehow?

Sorry if this has been discussed before, but to me it seems easier to
just pass the frequency as an u64 and calculate the khz/hz scaling
from that. Although I have to admit that I'm somewhat lost in all the
time calculations, so perhaps my suggestion is impossible...

Thanks,

/ magnus
