From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2008 13:52:40 +0000
Subject: Re: [PATCH 04/10] timer_inc: timer helper code, clockevent only
Message-Id: <aec7e5c30812040552n19434617va5a16769541c9660@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20081201103300.26620.32206.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081201103300.26620.32206.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 4, 2008 at 1:35 AM, John Stultz <johnstul@us.ibm.com> wrote:
> On Thu, 2008-12-04 at 00:30 +0900, Magnus Damm wrote:
>> So maybe it's better to scrap the timer_inc part and just include that
>> logic in the cmt driver? We can always go back later on if there is a
>> direct need.
>
> I think I'd be happier with this. Hopefully this will make any needed
> changes to the clockevent or clocksource code more apparent.

Sure!

>> Regarding read2() patch, the enable()/disable() patch and a future
>> unregistration patch - I still like to see that included. Do you see
>> any disadvantages with that?
>
> The enable/disable bits seem great. The read2() bit I'm not against, but
> would like to see how it ends up being used before we commit to the
> interface change. And unregistration is something that's been needed.

Ok, I'm not 100% sure how to do the unregistration properly, but I'll
try to come up with something. That goes for the clockevent stuff
too..

> Thanks again for dealing with my feedback. I know its not fun to rework
> or throwout code and start again. But I think in this case it will help
> the amount of future maintenance needed.

No worries, I usually do a couple of iterations of my code before
everyone gets happy. =)

Thanks for your help so far!

/ magnus
