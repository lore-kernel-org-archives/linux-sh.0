From: Simon Horman <horms@verge.net.au>
Date: Wed, 30 Jan 2019 10:06:57 +0000
Subject: Re: [PATCH 2/7] sh_eth: RX checksum offload support
Message-Id: <20190130100656.kp6ff2zwxqs4xyzd@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com>
 <29cb4d33-37c3-43c0-3bce-fa01737c0fa4@cogentembedded.com>
 <20190128121855.t5w3us6kd7o6niph@verge.net.au>
 <d95fff4f-7750-87c4-3664-eb5efb593b75@cogentembedded.com>
 <20190129075810.rqeekk5j4npjh6wf@verge.net.au>
 <319141ef-caa5-2140-2920-c471dac086ea@cogentembedded.com>
In-Reply-To: <319141ef-caa5-2140-2920-c471dac086ea@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Jan 29, 2019 at 06:43:45PM +0300, Sergei Shtylyov wrote:
> On 01/29/2019 10:58 AM, Simon Horman wrote:
> 
> >>>> Add support for the RX checksum offload. This is enabled by default and
> >>>> may be disabled and re-enabled using 'ethtool':
> >>>>
> >>>> # ethtool -K eth0 rx {on|off}
> >>>>
> >>>> Some Ether MACs provide a simple checksumming scheme which appears to be
> >>>> completely compatible with CHECKSUM_COMPLETE: sum of all packet data after
> >>>> the L2 header is appended to packet data; this may be trivially read by
> >>>> the driver and used to update the skb accordingly. The same checksumming
> >>>> scheme is implemented in the EtherAVB MACs and now supported by tha 'ravb'
> >>>> driver.
> >>>>
> >>>> In terms of performance, throughput is close to gigabit line rate with the
> >>>> RX checksum offload both enabled and disabled.  The 'perf' output, however,
> >>>> appears to indicate that significantly less time is spent in do_csum() --
> >>>> this is as expected.
> >>>
> >>> Nice.
> >>>
> >>> FYI, this seems similar to what I observed for RAVB, perhaps on H3 I don't
> >>> exactly recall. On E3, which has less CPU power, I recently observed that
> >>> with rx-csum enabled I can achieve gigabit line rate, but with rx-csum
> >>> disabled throughput is significantly lower. I.e. on that system throughput
> >>> is CPU bound with 1500 byte packets unless rx-csum enabled.
> >>
> >>    Unfortunately, we can't teset these patches on the other gen3 boards. ISTR
> >> you have RZ/A1H board... if it's still with you, I'd appreciate testing.
> > 
> > Unfortunately, as of a few weeks ago, I no longer have that board.
> > 
> >>> Next point:
> >>>
> >>> 2da64300fbc ("ravb: expand rx descriptor data to accommodate hw checksum")
> >>> is fresh in my mind and I wonder if mdp->rx_buf_sz needs to grow to ensure
> >>> that there is always enough space for the csum.
> >>
> >>    Well, if you look at sh_eth_ring_init(), you'll see that the driver reserves
> >> plenty of space at the end the RX buffers.
> > 
> > Yes, I see that. And I assume that was enough space before this patch.
> > But is it still enough space now that 2 bytes are needed for the hardware csum?
> 
>   To quote the source:
> 
> 	/* +26 gets the maximum ethernet encapsulation, +7 & ~7 because the
> 	 * card needs room to do 8 byte alignment, +2 so we can reserve
> 	 * the first 2 bytes, and +16 gets room for the status word from the
> 	 * card.
> 	 */
> 	mdp->rx_buf_sz = (ndev->mtu <= 1492 ? PKT_BUF_SZ :
> 			  (((ndev->mtu + 26 + 7) & ~7) + 2 + 16));
> 
>    I have no idea what they mean by status word and why it takes 16 bytes (and I even
> have the R8A771x manual!) but I think these 16 bytes are where our checksum goes...
> that's why I said there's plenty of space. :-)

Ok. FWIIW, I don't know either.

> > 2 bytes that might have previously been used as packet data in some
> > circumstances.
> > 
> >>> In particular, have you
> >>> tested this with MTU-size frames with VLANs. (My test is to run iperf3 over
> >>> a VLAN netdev, netperf over a VLAN netdev would likely work just as well.)
> >>
> >>    Could you refresh me on how to bring up a VLAN on a given interface?
> > 
> > You will need a kernel with CONFIG_VLAN_8021Q enabled.
> > 
> > Then you can do something like this:
> > 
> > 	ip link add link eth0 name eth0.1 type vlan id 1
> > 	ip addr add 10.1.1.100/24 dev eth0.1
> > 	ip link set dev eth0.1 up
> 
>   Thank you! I'm not familiar with 'ip' at all, thought 'ifconfig' could do the same
> thing easier but couldn't remember all the needed incantations... :-)
>    Anyway, it worked!
> 
> >> [...]
> >>>> The above results collected on the R-Car V3H Starter Kit board.
> >>>>
> >>>> Based on the commit 4d86d3818627 ("ravb: RX checksum offload")...
> >>>>
> >>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >> [...]
> 
> MBR, Sergei
> 
