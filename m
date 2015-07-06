From: Stephen Boyd <sboyd@codeaurora.org>
Date: Mon, 06 Jul 2015 21:48:05 +0000
Subject: Re: [PATCH] clk: shmobile: emev2: annotate smu base pointer
Message-Id: <20150706214805.GD20866@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1436216708-1815-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1436216708-1815-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mike Turquette <mturquette@linaro.org>, linux-clk@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>

On 07/06, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> sparse rightfully says:
> 
> drivers/clk/shmobile/clk-emev2.c:39:14: warning: symbol 'smu_base' was not declared. Should it be static?
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Yep, and it was already fixed and merged

$ git tag -l --contains 43f535702bb2c7b96091c0267fc105d44c18348c v4.*
v4.2-rc1

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
