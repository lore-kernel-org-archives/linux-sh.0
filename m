From: Stephen Boyd <sboyd@codeaurora.org>
Date: Wed, 04 Sep 2013 16:29:53 +0000
Subject: Re: [PATCH] clocksource: em_sti: Set cpu_possible_mask to fix SMP broadcast
Message-Id: <52276001.8070801@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20130904080151.24562.91334.sendpatchset@w520> <20130904083727.GE17329@verge.net.au> <5226F2E2.3070202@linaro.org>
In-Reply-To: <5226F2E2.3070202@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, arnd@arndb.de, linux-sh@vger.kernel.org, rob.herring@calxeda.com, olof@lixom.net, santosh.shilimkar@ti.com, grant.likely@linaro.org, tglx@linutronix.de

On 09/04/13 01:44, Daniel Lezcano wrote:
>
>> On Wed, Sep 04, 2013 at 05:01:51PM +0900, Magnus Damm wrote:
>>> From: Magnus Damm <damm@opensource.se>
>>>
>>> Update the STI driver by setting cpu_possible_mask to make EMEV2
>>> SMP work as expected together with the ARM broadcast timer.
>>>
>>> This breakage was introduced by:
>>>
>>> f7db706 ARM: 7674/1: smp: Avoid dummy clockevent being preferred over real hardware clock-event
>>>
>>> Without this fix SMP operation is broken on EMEV2 since no
>>> broadcast timer interrupts trigger on the secondary CPU cores.
>>>
>>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> Tested-by: Simon Horman <horms+renesas@verge.net.au>
>>
>> I will let this sit for a few days to see if there is any further feedback.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

