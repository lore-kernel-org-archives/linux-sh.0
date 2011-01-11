From: Stephen Hemminger <shemminger@vyatta.com>
Date: Tue, 11 Jan 2011 15:49:14 +0000
Subject: Re: [PATCH v2] sh: sh_eth: Add support ethtool
Message-Id: <20110111074914.60915b2b@s6510>
List-Id: <linux-sh.vger.kernel.org>
References: <1294747109-11511-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1294747109-11511-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nobuhiro.iwamatsu.yj@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com, bhutchings@solarflare.com

On Tue, 11 Jan 2011 20:58:29 +0900
nobuhiro.iwamatsu.yj@renesas.com wrote:

> From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> 
> This commit supports following functions.
>  - get_drvinfo
>  - get_settings
>  - set_settings
>  - nway_reset
>  - get_msglevel
>  - set_msglevel
>  - get_link
>  - get_strings
>  - get_ethtool_stats
>  - get_sset_count
> 
> About other function, the device does not support.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

I agree with Eric, the statistics interface is not necessary if all
the statistics are only the standard values.  The netdev stats are available
through several other interfaces already.

It would be nice to allow configuring the ring sizes.
