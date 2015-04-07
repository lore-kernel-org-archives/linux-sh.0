From: Stephen Boyd <sboyd@codeaurora.org>
Date: Tue, 07 Apr 2015 23:09:39 +0000
Subject: Re: [PATCH 06/14] clkdev: add clkdev_create() helper
Message-Id: <552463B3.4040804@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk> <E1Ye59J-0001BF-CZ@rmk-PC.arm.linux.org.uk> <5522EA55.5080804@codeaurora.org> <20150407124342.GJ4027@n2100.arm.linux.org.uk>
In-Reply-To: <20150407124342.GJ4027@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org

On 04/07/15 05:43, Russell King - ARM Linux wrote:
> On Mon, Apr 06, 2015 at 01:19:33PM -0700, Stephen Boyd wrote:
>> On 04/03/15 10:12, Russell King wrote:
>>> @@ -316,6 +329,29 @@ clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
>>>  }
>>>  EXPORT_SYMBOL(clkdev_alloc);
>>>  
>>> +/**
>>> + * clkdev_create - allocate and add a clkdev lookup structure
>>> + * @clk: struct clk to associate with all clk_lookups
>>> + * @con_id: connection ID string on device
>>> + * @dev_fmt: format string describing device name
>>> + *
>>> + * Returns a clk_lookup structure, which can be later unregistered and
>>> + * freed.
>> Please add that this returns NULL on failure.
> Will do, but please remember that _I'm_ taking the clkdev patches through
> my tree, as I'm the maintainer for clkdev.  Thanks.
>

Sounds good to me. Thanks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

