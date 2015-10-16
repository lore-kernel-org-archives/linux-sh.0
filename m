From: Stephen Boyd <sboyd@codeaurora.org>
Date: Fri, 16 Oct 2015 18:55:11 +0000
Subject: Re: [PATCH] clk: shmobile: r8a7778: Make r8a7778_rates[] and r8a7778_divs[] static const
Message-Id: <20151016185511.GE23912@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1445008495-27708-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1445008495-27708-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-clk@vger.kernel.org, linux-sh@vger.kernel.org

On 10/16, Geert Uytterhoeven wrote:
> r8a7778_rates[] and r8a7778_divs[] are only used in clk-r8a7778.c, and
> never modified.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
