From: David Miller <davem@davemloft.net>
Date: Tue, 22 Feb 2011 18:10:37 +0000
Subject: Re: [PATCH v3] sh: sh_eth: Add support ethtool
Message-Id: <20110222.101037.112590833.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1297840652-20883-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1297840652-20883-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nobuhiro.iwamatsu.yj@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, bhutchings@solarflare.com, eric.dumazet@gmail.com, yoshihiro.shimoda.uh@renesas.com

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Wed, 16 Feb 2011 16:17:32 +0900

> This commit supports following functions.
>   - get_settings
>   - set_settings
>   - nway_reset
>   - get_msglevel
>   - set_msglevel
>   - get_link
>   - get_strings
>   - get_ethtool_stats
>   - get_sset_count
> 
> About other function, the device does not support.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Applied to net-next-2.6, thank you.
