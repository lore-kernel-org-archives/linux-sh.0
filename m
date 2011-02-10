From: Saravana Kannan <skannan@codeaurora.org>
Date: Thu, 10 Feb 2011 04:26:44 +0000
Subject: Re: [RFC, PATCH 3/3] clk: add warnings for incorrect enable/prepare
Message-Id: <4D536904.5080708@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>	<1297058877.800990.238556019385.3.gpush@pororo>	<20110207080555.GC27982@pengutronix.de>	<201102071608.42855.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1102070908120.14920@xanadu.home>
In-Reply-To: <alpine.LFD.2.00.1102070908120.14920@xanadu.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 02/07/2011 06:24 AM, Nicolas Pitre wrote:
> On Mon, 7 Feb 2011, Jeremy Kerr wrote:
>
>> Hi Uwe,
>>
>>> This implies the warning is only issued on clocks that have a prepare
>>> callback.  If we want to enforce the new API the warning here shouldn't
>>> depend on clk->ops->prepare.  (clk_prepare and clk_unprepare need to
>>> be changed then to adapt the prepare_count even in the absence of
>>> clk->ops->prepare.)
>>
>> Yeah, it's a decision about either adding a small cost to all clk_prepare()s
>> (ie, adding cost when there is no prepare callback), or checking for the
>> correct prepare/enable semantics for all clocks (even when it doesn't matter
>> for that particular clock). I chose the first as more important, but happy to
>> go either way here.
>
> The prepare method being called from non-atomic context cannot be
> considered to be in a speed critical path.  Most of the time, this is
> going to be called on driver initialization or the like, and that's a
> relatively rare event. Therefore this really small cost to clk_prepare()
> is definitively worth it to help proper usage of the API.  If this ever
> becomes a problem then this could be confined to some CONFIG_CLK_DEBUG
> or the like.  But when introducing a new API it is best to be more
> strict to help people get its usage right (without going overboard with
> it of course).
>

Agree with Nicholas and Uwe. +1 for this request.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
