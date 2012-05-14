From: David Miller <davem@davemloft.net>
Date: Mon, 14 May 2012 22:50:34 +0000
Subject: Re: [PATCH v3 6/6] net: sh_eth: use NAPI
Message-Id: <20120514.185034.399229364191924851.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4FB0AA7C.1000603@renesas.com>
In-Reply-To: <4FB0AA7C.1000603@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro.shimoda.uh@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 14 May 2012 15:47:24 +0900

> This patch modifies the driver to use NAPI.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

I think your TX path is still extremely racey.

No locks are held here, so you tell me what happens if we execute:

> +	/* check txdesc */
> +	txfree_num = sh_eth_txfree(ndev);
> +	if (txfree_num)

and at this exact moment the queue was in fact already awake and
another thread of control transmits packets, and this action fills up
the TX queue and stops the queue.

>  		netif_wake_queue(ndev);

This will erroneously wake the queue and trigger the debugging
message in your TX function.

You need strict synchronization between your TX queueing and TX
liberation flows.  So that queue stop and wake are only performed
at the correct moment.

In fact, looking at how the mdp->lock is used in your TX routine, it
seems to protect absolutely against nothing.

Please read the TX flow of drivers/net/ethernet/broadcom/tg3.c to see
how to do this correctly, and lock free, in a NAPI driver.
