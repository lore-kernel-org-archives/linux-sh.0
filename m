From: Stephen Boyd <sboyd@codeaurora.org>
Date: Mon, 06 Apr 2015 20:19:33 +0000
Subject: Re: [PATCH 06/14] clkdev: add clkdev_create() helper
Message-Id: <5522EA55.5080804@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk> <E1Ye59J-0001BF-CZ@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1Ye59J-0001BF-CZ@rmk-PC.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org

On 04/03/15 10:12, Russell King wrote:
> @@ -316,6 +329,29 @@ clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
>  }
>  EXPORT_SYMBOL(clkdev_alloc);
>  
> +/**
> + * clkdev_create - allocate and add a clkdev lookup structure
> + * @clk: struct clk to associate with all clk_lookups
> + * @con_id: connection ID string on device
> + * @dev_fmt: format string describing device name
> + *
> + * Returns a clk_lookup structure, which can be later unregistered and
> + * freed.

Please add that this returns NULL on failure.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

