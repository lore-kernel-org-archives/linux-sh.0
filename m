From: Simon Horman <horms@verge.net.au>
Date: Mon, 28 Jan 2019 12:18:55 +0000
Subject: Re: [PATCH 2/7] sh_eth: RX checksum offload support
Message-Id: <20190128121855.t5w3us6kd7o6niph@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com>
 <29cb4d33-37c3-43c0-3bce-fa01737c0fa4@cogentembedded.com>
In-Reply-To: <29cb4d33-37c3-43c0-3bce-fa01737c0fa4@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Sergei,

On Sun, Jan 27, 2019 at 08:37:33PM +0300, Sergei Shtylyov wrote:
> Add support for the RX checksum offload. This is enabled by default and
> may be disabled and re-enabled using 'ethtool':
> 
> # ethtool -K eth0 rx {on|off}
> 
> Some Ether MACs provide a simple checksumming scheme which appears to be
> completely compatible with CHECKSUM_COMPLETE: sum of all packet data after
> the L2 header is appended to packet data; this may be trivially read by
> the driver and used to update the skb accordingly. The same checksumming
> scheme is implemented in the EtherAVB MACs and now supported by tha 'ravb'
> driver.
> 
> In terms of performance, throughput is close to gigabit line rate with the
> RX checksum offload both enabled and disabled.  The 'perf' output, however,
> appears to indicate that significantly less time is spent in do_csum() --
> this is as expected.

Nice.

FYI, this seems similar to what I observed for RAVB, perhaps on H3 I don't
exactly recall. On E3, which has less CPU power, I recently observed that
with rx-csum enabled I can achieve gigabit line rate, but with rx-csum
disabled throughput is significantly lower. I.e. on that system throughput
is CPU bound with 1500 byte packets unless rx-csum enabled.


Next point:

2da64300fbc ("ravb: expand rx descriptor data to accommodate hw checksum")
is fresh in my mind and I wonder if mdp->rx_buf_sz needs to grow to ensure
that there is always enough space for the csum. In particular, have you
tested this with MTU-size frames with VLANs. (My test is to run iperf3 over
a VLAN netdev, netperf over a VLAN netdev would likely work just as well.)

> 
> Test results with RX checksum offload enabled:
> 
> ~/netperf-2.2pl4# perf record -a ./netperf -t TCP_MAERTS -H 192.168.2.4
> TCP MAERTS TEST to 192.168.2.4
> Recv   Send    Send
> Socket Socket  Message  Elapsed
> Size   Size    Size     Time     Throughput
> bytes  bytes   bytes    secs.    10^6bits/sec
> 
> 131072  16384  16384    10.01     933.93
> [ perf record: Woken up 8 times to write data ]
> [ perf record: Captured and wrote 1.955 MB perf.data (41940 samples) ]
> ~/netperf-2.2pl4# perf report
> Samples: 41K of event 'cycles:ppp', Event count (approx.): 9915302763
> Overhead  Command          Shared Object             Symbol
>    9.44%  netperf          [kernel.kallsyms]         [k] __arch_copy_to_user
>    7.75%  swapper          [kernel.kallsyms]         [k] _raw_spin_unlock_irq
>    6.31%  swapper          [kernel.kallsyms]         [k] default_idle_call
>    5.89%  swapper          [kernel.kallsyms]         [k] arch_cpu_idle
>    4.37%  swapper          [kernel.kallsyms]         [k] tick_nohz_idle_exit
>    4.02%  netperf          [kernel.kallsyms]         [k] _raw_spin_unlock_irq
>    2.52%  netperf          [kernel.kallsyms]         [k] preempt_count_sub
>    1.81%  netperf          [kernel.kallsyms]         [k] tcp_recvmsg
>    1.80%  netperf          [kernel.kallsyms]         [k] _raw_spin_unlock_irqres
>    1.78%  netperf          [kernel.kallsyms]         [k] preempt_count_add
>    1.36%  netperf          [kernel.kallsyms]         [k] __tcp_transmit_skb
>    1.20%  netperf          [kernel.kallsyms]         [k] __local_bh_enable_ip
>    1.10%  netperf          [kernel.kallsyms]         [k] sh_eth_start_xmit
> 
> Test results with RX checksum offload disabled:
> 
> ~/netperf-2.2pl4# perf record -a ./netperf -t TCP_MAERTS -H 192.168.2.4
> TCP MAERTS TEST to 192.168.2.4
> Recv   Send    Send
> Socket Socket  Message  Elapsed
> Size   Size    Size     Time     Throughput
> bytes  bytes   bytes    secs.    10^6bits/sec
> 131072  16384  16384    10.01     932.04
> [ perf record: Woken up 14 times to write data ]
> [ perf record: Captured and wrote 3.642 MB perf.data (78817 samples) ]
> ~/netperf-2.2pl4# perf report
> Samples: 78K of event 'cycles:ppp', Event count (approx.): 18091442796          
> Overhead  Command          Shared Object       Symbol                           
>    7.00%  swapper          [kernel.kallsyms]   [k] do_csum                      
>    3.94%  swapper          [kernel.kallsyms]   [k] sh_eth_poll                  
>    3.83%  ksoftirqd/0      [kernel.kallsyms]   [k] do_csum                      
>    3.23%  swapper          [kernel.kallsyms]   [k] _raw_spin_unlock_irq         
>    2.87%  netperf          [kernel.kallsyms]   [k] __arch_copy_to_user          
>    2.86%  swapper          [kernel.kallsyms]   [k] arch_cpu_idle                
>    2.13%  swapper          [kernel.kallsyms]   [k] default_idle_call            
>    2.12%  ksoftirqd/0      [kernel.kallsyms]   [k] sh_eth_poll                  
>    2.02%  swapper          [kernel.kallsyms]   [k] _raw_spin_unlock_irqrestore  
>    1.84%  swapper          [kernel.kallsyms]   [k] __softirqentry_text_start    
>    1.64%  swapper          [kernel.kallsyms]   [k] tick_nohz_idle_exit          
>    1.53%  netperf          [kernel.kallsyms]   [k] _raw_spin_unlock_irq         
>    1.32%  netperf          [kernel.kallsyms]   [k] preempt_count_sub            
>    1.27%  swapper          [kernel.kallsyms]   [k] __pi___inval_dcache_area     
>    1.22%  swapper          [kernel.kallsyms]   [k] check_preemption_disabled    
>    1.01%  ksoftirqd/0      [kernel.kallsyms]   [k] _raw_spin_unlock_irqrestore  
> 
> The above results collected on the R-Car V3H Starter Kit board.
> 
> Based on the commit 4d86d3818627 ("ravb: RX checksum offload")...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  drivers/net/ethernet/renesas/sh_eth.c |   60 ++++++++++++++++++++++++++++++++--
>  drivers/net/ethernet/renesas/sh_eth.h |    1 
>  2 files changed, 59 insertions(+), 2 deletions(-)
> 
> Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
> =================================> --- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
> +++ net-next/drivers/net/ethernet/renesas/sh_eth.c
> @@ -1532,8 +1532,9 @@ static int sh_eth_dev_init(struct net_de
>  	mdp->irq_enabled = true;
>  	sh_eth_write(ndev, mdp->cd->eesipr_value, EESIPR);
>  
> -	/* PAUSE Prohibition */
> +	/* EMAC Mode: PAUSE prohibition; Duplex; RX Checksum; TX; RX */
>  	sh_eth_write(ndev, ECMR_ZPF | (mdp->duplex ? ECMR_DM : 0) |
> +		     (ndev->features & NETIF_F_RXCSUM ? ECMR_RCSC : 0) |
>  		     ECMR_TE | ECMR_RE, ECMR);
>  
>  	if (mdp->cd->set_rate)
> @@ -1592,6 +1593,19 @@ static void sh_eth_dev_exit(struct net_d
>  	update_mac_address(ndev);
>  }
>  
> +static void sh_eth_rx_csum(struct sk_buff *skb)
> +{
> +	u8 *hw_csum;
> +
> +	/* The hardware checksum is 2 bytes appended to packet data */
> +	if (unlikely(skb->len < sizeof(__sum16)))
> +		return;
> +	hw_csum = skb_tail_pointer(skb) - sizeof(__sum16);
> +	skb->csum = csum_unfold((__force __sum16)get_unaligned_le16(hw_csum));
> +	skb->ip_summed = CHECKSUM_COMPLETE;
> +	skb_trim(skb, skb->len - sizeof(__sum16));
> +}
> +
>  /* Packet receive function */
>  static int sh_eth_rx(struct net_device *ndev, u32 intr_status, int *quota)
>  {
> @@ -1666,6 +1680,8 @@ static int sh_eth_rx(struct net_device *
>  					 DMA_FROM_DEVICE);
>  			skb_put(skb, pkt_len);
>  			skb->protocol = eth_type_trans(skb, ndev);
> +			if (ndev->features & NETIF_F_RXCSUM)
> +				sh_eth_rx_csum(skb);
>  			netif_receive_skb(skb);
>  			ndev->stats.rx_packets++;
>  			ndev->stats.rx_bytes += pkt_len;
> @@ -2921,6 +2937,39 @@ static void sh_eth_set_rx_mode(struct ne
>  	spin_unlock_irqrestore(&mdp->lock, flags);
>  }
>  
> +static void sh_eth_set_rx_csum(struct net_device *ndev, bool enable)
> +{
> +	struct sh_eth_private *mdp = netdev_priv(ndev);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mdp->lock, flags);
> +
> +	/* Disable TX and RX */
> +	sh_eth_rcv_snd_disable(ndev);
> +
> +	/* Modify RX Checksum setting */
> +	sh_eth_modify(ndev, ECMR, ECMR_RCSC, enable ? ECMR_RCSC : 0);
> +
> +	/* Enable TX and RX */
> +	sh_eth_rcv_snd_enable(ndev);
> +
> +	spin_unlock_irqrestore(&mdp->lock, flags);
> +}
> +
> +static int sh_eth_set_features(struct net_device *ndev,
> +			       netdev_features_t features)
> +{
> +	netdev_features_t changed = ndev->features ^ features;
> +	struct sh_eth_private *mdp = netdev_priv(ndev);
> +
> +	if (changed & NETIF_F_RXCSUM && mdp->cd->rx_csum)
> +		sh_eth_set_rx_csum(ndev, features & NETIF_F_RXCSUM);
> +
> +	ndev->features = features;
> +
> +	return 0;
> +}
> +
>  static int sh_eth_get_vtag_index(struct sh_eth_private *mdp)
>  {
>  	if (!mdp->port)
> @@ -3102,6 +3151,7 @@ static const struct net_device_ops sh_et
>  	.ndo_change_mtu		= sh_eth_change_mtu,
>  	.ndo_validate_addr	= eth_validate_addr,
>  	.ndo_set_mac_address	= eth_mac_addr,
> +	.ndo_set_features	= sh_eth_set_features,
>  };
>  
>  static const struct net_device_ops sh_eth_netdev_ops_tsu = {
> @@ -3117,6 +3167,7 @@ static const struct net_device_ops sh_et
>  	.ndo_change_mtu		= sh_eth_change_mtu,
>  	.ndo_validate_addr	= eth_validate_addr,
>  	.ndo_set_mac_address	= eth_mac_addr,
> +	.ndo_set_features	= sh_eth_set_features,
>  };
>  
>  #ifdef CONFIG_OF
> @@ -3245,6 +3296,11 @@ static int sh_eth_drv_probe(struct platf
>  	ndev->max_mtu = 2000 - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
>  	ndev->min_mtu = ETH_MIN_MTU;
>  
> +	if (mdp->cd->rx_csum) {
> +		ndev->features = NETIF_F_RXCSUM;
> +		ndev->hw_features = NETIF_F_RXCSUM;
> +	}
> +
>  	/* set function */
>  	if (mdp->cd->tsu)
>  		ndev->netdev_ops = &sh_eth_netdev_ops_tsu;
> @@ -3294,7 +3350,7 @@ static int sh_eth_drv_probe(struct platf
>  			goto out_release;
>  		}
>  		mdp->port = port;
> -		ndev->features = NETIF_F_HW_VLAN_CTAG_FILTER;
> +		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
>  
>  		/* Need to init only the first port of the two sharing a TSU */
>  		if (port = 0) {
> Index: net-next/drivers/net/ethernet/renesas/sh_eth.h
> =================================> --- net-next.orig/drivers/net/ethernet/renesas/sh_eth.h
> +++ net-next/drivers/net/ethernet/renesas/sh_eth.h
> @@ -500,6 +500,7 @@ struct sh_eth_cpu_data {
>  	unsigned no_xdfar:1;	/* E-DMAC DOES NOT have RDFAR/TDFAR */
>  	unsigned xdfar_rw:1;	/* E-DMAC has writeable RDFAR/TDFAR */
>  	unsigned csmr:1;	/* E-DMAC has CSMR */
> +	unsigned rx_csum:1;	/* EtherC has ECMR.RCSC */
>  	unsigned select_mii:1;	/* EtherC has RMII_MII (MII select register) */
>  	unsigned rmiimode:1;	/* EtherC has RMIIMODE register */
>  	unsigned rtrate:1;	/* EtherC has RTRATE register */
> 
