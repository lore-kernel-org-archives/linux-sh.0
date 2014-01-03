From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 03 Jan 2014 09:52:45 +0000
Subject: Re: [PATCH] sh_eth: coding style fixes
Message-Id: <52C6886D.2000801@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312310325.21951.sergei.shtylyov@cogentembedded.com>	 <20140102.193407.23280653408847634.davem@davemloft.net> <1388713347.2259.86.camel@joe-AO722>
In-Reply-To: <1388713347.2259.86.camel@joe-AO722>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 03-01-2014 5:42, Joe Perches wrote:

>>> @@ -1952,8 +1949,8 @@ static void sh_eth_tx_timeout(struct net
>>>   	netif_stop_queue(ndev);
>>>
>>>   	if (netif_msg_timer(mdp))
>>> -		dev_err(&ndev->dev, "%s: transmit timed out, status %8.8x,"
>>> -	       " resetting...\n", ndev->name, (int)sh_eth_read(ndev, EESR));
>>> +		dev_err(&ndev->dev, "%s: transmit timed out, status %8.8x, resetting...\n"
>>> +			ndev->name, (int)sh_eth_read(ndev, EESR));
>>>
>>>   	/* tx_errors count up */
>>>   	ndev->stats.tx_errors++;

>> You did not build test this.

>> drivers/net/ethernet/renesas/sh_eth.c: In function ‘sh_eth_tx_timeout’:
>> drivers/net/ethernet/renesas/sh_eth.c:1953:4: error: expected ‘)’ before ‘ndev’

> Also, this would likely be better as:
>
> 	netif_err(mdp, timer, ndev, "transmit timed out, status %#08lx, resetting...\n",
> 		  sh_eth_read(ndev, EESR));

    If checkpoint.pl did point this out, I would have fixed it. Since it 
doesn't, it's probably material of another patch.

WBR, Sergei

