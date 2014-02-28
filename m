From: Stephen Boyd <sboyd@codeaurora.org>
Date: Fri, 28 Feb 2014 00:03:19 +0000
Subject: Re: [PATCH] clk: shmobile: rcar-gen2: Use kick bit to allow Z clock frequency change
Message-Id: <530FD247.6030201@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <530C9D2A.8030409@baylibre.com>
In-Reply-To: <530C9D2A.8030409@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 02/27/14 14:46, Laurent Pinchart wrote:
> I'm not familiar with the hardware, but the patch below looks good to me. 
> While you're at it, what would you think about replacing the 
> __clk_is_enabled() call with a direct call to clk_is_enabled_regmap() ? Any 
> user of __clk_is_enabled() outside the CCF core is suspect from a locking 
> point of view, and exporting that function seems like a dangerous idea. On the 
> other hand, if you had done so already I wouldn't have found the race 
> condition.

Hm.. I guess that's ok. I like not having to care about what op is
assigned to the .is_enabled op though and we can't easily access the
.ops structure because it's hidden by the clk framework.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

