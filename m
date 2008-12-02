From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Tue, 02 Dec 2008 05:51:13 +0000
Subject: Re: [PATCH 09/10] clocksource: add enable() and disable() callbacks
Message-Id: <aec7e5c30812012151l58dfd6c1x68bcb9a80c0b2ba5@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20081201103347.26620.3670.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081201103347.26620.3670.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 2, 2008 at 5:43 AM, john stultz <johnstul@us.ibm.com> wrote:
> On Mon, 2008-12-01 at 19:33 +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@igel.co.jp>
>>
>> Add enable() and disable() callbacks for clocksources. This allows
>> us to put unused clocksources in power save mode. The functions
>> clocksource_enable() and clocksource_disable() wrap the callbacks
>> and are inserted in the timekeeping code to enable before use and
>> disable after switching to a new clocksource.
>>
>> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Hi John,

> I like this! Its a nice addition to the clocksource structure to allow
> for improved power management.

Great, thank you!

> I've got some worries that if clocksource_enable() is allowed to fail it
> might give us some grief in early boot (you don't check for errors
> there, but understandably, as there isn't much we can do).

I've been changing the code back and forth between returning void or
int, but I settled on int since the clock framework returns an int
from clk_enable(). So apparently that can fail. The clock framework is
the main reason why I want to be add enable() and disable(), and if we
can't enable the clock then it's very likely that we can't use the
clocksource hardware either.

At boot, maybe being a bit more verbose about what is failing would be good.

> However, maybe if a clocksource fails to be enabled, we need to eject it
> from the list of usable clocksources, as if clocksource with a high
> rating value, were to fail to be enabled, every tick we'd try to swap
> the bad clocksource in and fail, never to move to a good clocksource
> with slightly lower rating.

Yeah, moving it out from the list that sounds like a good idea. I
wonder if this problem overlaps with unregistration of clocksources?
My feeling is that we need to extend the clocksource state to include
a broken-state somehow. But that raises all sorts of other questions.

Also while at the topic, it would be nice if we could use clocksources
for other purposes such as trace clocks. Or maybe that is being done
already?

> But other then that nit, I think this is a good change.

Excellent! Do you want to extend this patch with smarter logic for
failing clocksources? I'd prefer to keep this as-is and try to get
unregistration and improved handling of failing clocksources solved
together.

Cheers,

/ magnus
