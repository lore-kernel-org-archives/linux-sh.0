From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 15 May 2012 09:46:25 +0000
Subject: Re: [PATCH v3 6/6] net: sh_eth: use NAPI
Message-Id: <4FB225F1.20407@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4FB0AA7C.1000603@renesas.com>
 <20120514.185034.399229364191924851.davem@davemloft.net>
 <4FB1DFF0.4040709@renesas.com>
 <20120515.010753.2012331320750491448.davem@davemloft.net>
In-Reply-To: <20120515.010753.2012331320750491448.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

2012/05/15 14:07, David Miller wrote:
> From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
> Date: Tue, 15 May 2012 13:47:44 +0900
> 
>> 2012/05/15 7:50, David Miller wrote:
>>> You need strict synchronization between your TX queueing and TX
>>> liberation flows.  So that queue stop and wake are only performed
>>> at the correct moment.
>>
>> I will add netif_queue_stopped() in the sh_eth_poll().
> 
> That doesn't fix the bug.  What if someone transmits a packet and
> fills the TX queue between the netif_queue_stopped() test and the
> call to netif_wake_queue()?
> 
> Adding another test doesn't create the necessary synchronization.
> 

Thank you for the reply again.
I will modify the code as the following. Is it correct?

	if (txfree_num) {
		netif_tx_lock(ndev);
		if (netif_queue_stopped(ndev))
			netif_wake_queue(ndev);
		netif_tx_unlock(ndev);
	}

Best regards,
Yoshihiro Shimoda
