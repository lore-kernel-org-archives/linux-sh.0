From: David Miller <davem@davemloft.net>
Date: Mon, 08 Jan 2018 19:32:09 +0000
Subject: Re: [PATCH] sh_eth: fix TXALCR1 offsets
Message-Id: <20180108.143209.1582638715239179133.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20180106212652.818833413@cogentembedded.com>
In-Reply-To: <20180106212652.818833413@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 07 Jan 2018 00:26:47 +0300

> The  TXALCR1 offsets are incorrect in the register offset tables, most
> probably due to copy&paste error.  Luckily, the driver never uses this
> register. :-)
> 
> Fixes: 4a55530f38e4 ("net: sh_eth: modify the definitions of register")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
