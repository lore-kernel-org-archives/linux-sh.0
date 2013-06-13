From: David Miller <davem@davemloft.net>
Date: Thu, 13 Jun 2013 09:45:38 +0000
Subject: Re: [PATCH] sh_eth: remove '__maybe_unused' annotations
Message-Id: <20130613.024538.503030596736096234.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201306120307.29615.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306120307.29615.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 12 Jun 2013 03:07:29 +0400

> Now that  the SoC specific support is no longer done with help of #ifdef'fery,
> we  no longer need '__maybe_unused' annotations to sh_eth_select_mii() and
> sh_eth_set_duplex()...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
