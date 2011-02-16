From: Saravana Kannan <skannan@codeaurora.org>
Date: Wed, 16 Feb 2011 04:53:09 +0000
Subject: Re: [RFC,PATCH 1/3] Add a common struct clk
Message-Id: <4D5B5835.4070407@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1297233693.242364.862698430999.1.gpush@pororo>	<4D53749B.6010102@codeaurora.org>	<201102151041.40655.jeremy.kerr@canonical.com>
	<4D5A100F.9000809@codeaurora.org>
In-Reply-To: <4D5A100F.9000809@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 02/14/2011 09:33 PM, Saravana Kannan wrote:
> Russell, A question for you further down this email. Please take a look.

Russell, Ping... I will snip the rest of the discussion so that it's 
easy to spot the question.

>>>> +int clk_set_parent(struct clk *clk, struct clk *parent)
>>>> +{
>>>> + if (clk->ops->set_parent)
>>>> + return clk->ops->set_parent(clk, parent);
>>>
>>> I'm not sure on this one. If the prepare ops for a clock also calls the
>>> prepare ops on the parent, shouldn't we prevent changing the parent
>>> while the prepare/unprepare is going on?
>>
>> Again, this is related to set_rate during enable/disable or
>> prepare/unprepare;
>> we don't have defined semantics for this at present.
>
> After thinking about this the past couple of days, this looks like a
> location where the locking is more necessary than inside set rate. I
> always saw the parent clock as the clock that generates the clock signal
> from which this clock derives (divide, etc) it's clock signal from.
>
> Assuming Russell and/or the community agrees on the semantics of
> "parent", without the generic implementation grabbing the prepare_lock
> while setting the parent, there is no way for the specific clock driver
> implementations to cleanly ensure correctness. The only option for them
> would be to peek into the generic clock struct and grab the prepare lock
> -- to me that would be an ugly hack and/or layering violation that would
> cause problems later on.
>
> Russell/All,
>
> What's the meaning of a parent clock? Do you agree with my definition --
> "the parent clock is the clock that generates the clock signal from
> which the child clock derives (divide, etc) it's clock signal from."? Or
> is it open to interpretation by each implementation?

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
