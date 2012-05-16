From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 16 May 2012 02:24:59 +0000
Subject: Re: [PATCH v3 6/6] net: sh_eth: use NAPI
Message-Id: <4FB30FFB.6090708@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4FB1DFF0.4040709@renesas.com>
 <20120515.010753.2012331320750491448.davem@davemloft.net>
 <4FB225F1.20407@renesas.com>
 <20120515.130552.119728053706080493.davem@davemloft.net>
 <20120515182919.GA7157@electric-eye.fr.zoreil.com>
In-Reply-To: <20120515182919.GA7157@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-sh@vger.kernel.org

2012/05/16 3:29, Francois Romieu wrote:
> David Miller <davem@davemloft.net> :
>> From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
> [...]
>>> I will modify the code as the following. Is it correct?
>>>
>>> 	if (txfree_num) {
>>> 		netif_tx_lock(ndev);
>>> 		if (netif_queue_stopped(ndev))
>>> 			netif_wake_queue(ndev);
>>> 		netif_tx_unlock(ndev);
>>> 	}
>>
>> Yes, and then you don't need that private lock in the start_xmit()
>> method at all, since that method runs with the tx_lock held.
> 
> I agree that the lock should go but:
> 1. something must be done to prevent sh_eth_txfree() being called
>    at the same time from the xmit and poll handlers
> 2. while netif_tx locking above provides an implicit memory barrier,
>    there won't be one in sh_eth_start_xmit once the lock is removed.
>    mdp->dirty_tx changes may thus go unnoticed in sh_eth_start_xmit
> 

Thank you for the review.

I checked tg3.c, and I found a patch to fix the race condition:
commit ID 1b2a72050 : [TG3]: Fix tx race condition

I will check the patch, and I will write such a patch for the sh_eth
driver later.

Best regards,
Yoshihiro Shimoda
