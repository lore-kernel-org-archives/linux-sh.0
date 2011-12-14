From: Ulf Hansson <ulf.hansson@stericsson.com>
Date: Wed, 14 Dec 2011 09:00:58 +0000
Subject: Re: [PATCH/RFC] mmc: add a device PM QoS constraint when a host is
Message-Id: <4EE865CA.8000407@stericsson.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1112121642080.10378@axis700.grange> <4EE76CC2.9080308@stericsson.com> <Pine.LNX.4.64.1112131658330.20293@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1112131658330.20293@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Guennadi Liakhovetski wrote:
> Hi Ulf
> 
> On Tue, 13 Dec 2011, Ulf Hansson wrote:
> 
>> Guennadi Liakhovetski wrote:
>>> Some MMC hosts implement a fine-grained runtime PM, whereby they
>>> runtime-suspend and -resume the host interface on each transfer. This can
>>> negatively affect performance, if the user was trying to transfer data
>>> blocks back-to-back. This patch adds a PM QoS constraint to avoid such a
>>> throughput reduction. This constraint prevents runtime-suspending the
>>> device, if the expected wakeup latency is larger than 100us.
>>>
>>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> I think host drivers can use autosuspend with some ms delay for this instead.
>> This will mean that requests coming in bursts will not be affected (well only
>> the first request in the burst will suffer from the runtime resume latency).
> 
> I think, Rafael is the best person to explain, why exactly this is not 
> desired. In short, this is the wrong location to make such decisions and 
> to define these criteria. The only thing, that the driver may be aware of 
> is how quickly it wants to be able to wake up, if it got suspended. And 
> it's already the PM subsystem, that has to decide, whether it can satisfy 
> this requirement or not. Rafael will correct me, if my explanation is 
> wrong.

You have a point. But I am not convinced. :-)

Some host drivers already make use of autosuspend. I think this is most 
straightforward solution to this problem right now.

However, we could also do pm_runtime_get_sync of the host device in 
claim host and vice verse in release host, thus preventing the host 
driver from triggering runtime_suspend|resume for every request. Though, 
I am not 100% sure this is really what you want either.

Using PM QoS as you propose, might prevent some hosts from doing 
runtime_suspend|resume completely and thus those might not fulfill power 
consumption requirements instead. I do not think we can take this 
decision at this level. Is performance more important than power save, 
that is kind of the question.


> 
>> I believe that runtime resume callback should ofcourse be optimized so they
>> are executed as fast as possible. But moreover, if they take more 100us, is
>> that really a reason for not executing them at all?
> 
> I think it is a reason not to execute them during an intensive IO, yes. I 
> cannot imagine a case, where if you have multiple IO requests waiting in 
> the queue to your medium, you would want to switch off and immediately on 
> again. Well, of course, such situations might exist, but then you just 
> have to define and use a different governor on your system. This is also 
> the flexibility, that this API is giving you.

I totally agree.

> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 


Br
Ulf Hansson
