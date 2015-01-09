From: David Miller <davem@davemloft.net>
Date: Fri, 09 Jan 2015 04:07:30 +0000
Subject: Re: [PATCH v2] sh_eth: Fix access to TRSCER register
Message-Id: <20150108.200730.2161513801937723015.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1420698307-3707-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1420698307-3707-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nobuhiro.iwamatsu.yj@renesas.com
Cc: netdev@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com, linux-sh@vger.kernel.org, geert@linux-m68k.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu,  8 Jan 2015 15:25:07 +0900

> TRSCER register is configured differently by SoCs. TRSCER of R-Car Gen2 is
> RINT8 bit only valid, other bits are reserved bits. This removes access to
> TRSCER register reserve bit by adding variable trscer_err_mask to
> sh_eth_cpu_data structure, set the register information to each SoCs.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Applied.
