From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 15 May 2012 04:47:44 +0000
Subject: Re: [PATCH v3 6/6] net: sh_eth: use NAPI
Message-Id: <4FB1DFF0.4040709@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4FB0AA7C.1000603@renesas.com>
 <20120514.185034.399229364191924851.davem@davemloft.net>
In-Reply-To: <20120514.185034.399229364191924851.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

2012/05/15 7:50, David Miller wrote:
> From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
> Date: Mon, 14 May 2012 15:47:24 +0900
> 
>> This patch modifies the driver to use NAPI.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> I think your TX path is still extremely racey.
> 
> No locks are held here, so you tell me what happens if we execute:
> 
>> +	/* check txdesc */
>> +	txfree_num = sh_eth_txfree(ndev);
>> +	if (txfree_num)
> 

Thank you for your review.
In the sh_eth_txfree(), it check the tx descriptors. If the tx descriptor
is completed, it calls dev_kfree_skb_irq(), and it returns value 1 or more.
So, the sh_eth_poll() calls netif_wake_queue() if the dev_kfree_skb_irq() is
called.

> and at this exact moment the queue was in fact already awake and
> another thread of control transmits packets, and this action fills up
> the TX queue and stops the queue.
> 
>>  		netif_wake_queue(ndev);
> 
> This will erroneously wake the queue and trigger the debugging
> message in your TX function.
> 
> You need strict synchronization between your TX queueing and TX
> liberation flows.  So that queue stop and wake are only performed
> at the correct moment.

I will add netif_queue_stopped() in the sh_eth_poll().

> In fact, looking at how the mdp->lock is used in your TX routine, it
> seems to protect absolutely against nothing.

I wlll remove the mdp->lock in the sh_eth_start_xmit().

> Please read the TX flow of drivers/net/ethernet/broadcom/tg3.c to see
> how to do this correctly, and lock free, in a NAPI driver.
> 

Thank you for your suggestion.
I will add netif_tx_lock/unlock before and after netif_wake_queue().

Best regards,
Yoshihiro Shimoda
