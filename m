From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 06 Jan 2014 01:28:27 +0000
Subject: Re: [PATCH] clk: shmobile: Fix SMTP clock index
Message-Id: <87y52tkifb.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1388155329-11124-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1388155329-11124-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine

> Use clkidx when registering SMTP clocks instead of loop counter
> since the value is then used to access the specific clock index bit
> in the smtp register.
> 
> The issue was introduced by the following commit:
> f94859c215b6d977 "clk: shmobile: Add MSTP clock support"
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---

In Subject and comment, I think...

- SMTP
+ MSTP
