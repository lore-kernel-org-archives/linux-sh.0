From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jun 2013 00:03:28 +0000
Subject: Re: [PATCH v2 1/2] sh_eth: define/use EESR_RX_CHECK macro
Message-Id: <20130619.170328.1736421710188084110.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201306192329.24022.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306192329.24022.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 19 Jun 2013 23:29:23 +0400

> sh_eth_interrupt() uses the same Rx interrupt mask twice to check the interrupt
> status register -- #define EESR_RX_CHECK  and use it instead. 
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
