From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Tue, 11 Jan 2011 12:19:03 +0000
Subject: Re: [PATCH v2] sh: sh_eth: Add support ethtool
Message-Id: <1294748343.2927.57.camel@edumazet-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1294747109-11511-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1294747109-11511-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: nobuhiro.iwamatsu.yj@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com, bhutchings@solarflare.com

Le mardi 11 janvier 2011 à 20:58 +0900, nobuhiro.iwamatsu.yj@renesas.com
a écrit :
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
> ---

> +static const char sh_eth_gstrings_stats[][ETH_GSTRING_LEN] = {
> +	"rx_packets", "tx_packets", "rx_bytes", "tx_bytes", "rx_errors",
> +	"tx_errors", "rx_dropped", "tx_dropped", "multicast", "collisions",
> +	"rx_length_errors", "rx_over_errors", "rx_crc_errors",
> +	"rx_frame_errors", "rx_fifo_errors", "rx_missed_errors",
> +	"tx_aborted_errors", "tx_carrier_errors", "tx_fifo_errors",
> +	"tx_heartbeat_errors", "tx_window_errors",
> +	/* device-specific stats */
> +	"rx_current", "tx_current",
> +	"rx_dirty", "tx_dirty",
> +};
> +#define SH_ETH_NET_STATS_LEN  21
> +#define SH_ETH_STATS_LEN  ARRAY_SIZE(sh_eth_gstrings_stats)

Why is it needed to report standard device stats ?


> +
> +static int sh_eth_get_sset_count(struct net_device *netdev, int sset)
> +{
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		return SH_ETH_STATS_LEN;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static void sh_eth_get_ethtool_stats(struct net_device *ndev,
> +			struct ethtool_stats *stats, u64 *data)
> +{
> +	struct sh_eth_private *mdp = netdev_priv(ndev);
> +	int i = SH_ETH_NET_STATS_LEN;
> +
> +	memcpy(data, (unsigned long *)&ndev->stats,
> +				SH_ETH_NET_STATS_LEN * sizeof(unsigned long));

This is wrong on 32bit arches.
ndev->stats is an array of "long" values, not u64 ones.

> +
> +	/* device-specific stats */
> +	data[i++] = mdp->cur_rx;
> +	data[i++] = mdp->cur_tx;
> +	data[i++] = mdp->dirty_rx;
> +	data[i++] = mdp->dirty_tx;
> +}
> +



