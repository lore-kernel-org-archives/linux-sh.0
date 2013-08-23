From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Fri, 23 Aug 2013 23:00:53 +0000
Subject: Re: [PATCH v2 2/4] clk: implement clk_unregister
Message-Id: <5217E9A5.8030503@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1377020063-30213-1-git-send-email-s.nawrocki@samsung.com>
 <1377020063-30213-3-git-send-email-s.nawrocki@samsung.com>
 <20130823215838.8231.21635@quantum>
In-Reply-To: <20130823215838.8231.21635@quantum>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/23/2013 11:58 PM, Mike Turquette wrote:
>> +static void clk_nodrv_disable_unprepare(struct clk_hw *hw)
>> >  +{
>> >  +       WARN_ON(1);
>
> Ideally we shouldn't get here, but if we do I guess it could be very
> noisy. How about WARN_ONCE?

Yes, I guess that would be much better. I could resend it tomorrow if 
needed.

> After you address Russell's comments in patch #1 I will be happy to take
> this series.

I have posted today v3 addressing Russell's comments. Hopefully patch #3
(the patches got reordered) looks OK now. v3 includes actual assigning
of clk->owner I somehow managed to miss in previous series :/ Please have
a look at it.

--
Regards,
Sylwester
