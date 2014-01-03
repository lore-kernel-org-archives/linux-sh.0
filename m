From: Joe Perches <joe@perches.com>
Date: Fri, 03 Jan 2014 01:42:27 +0000
Subject: Re: [PATCH] sh_eth: coding style fixes
Message-Id: <1388713347.2259.86.camel@joe-AO722>
List-Id: <linux-sh.vger.kernel.org>
References: <201312310325.21951.sergei.shtylyov@cogentembedded.com>
	 <20140102.193407.23280653408847634.davem@davemloft.net>
In-Reply-To: <20140102.193407.23280653408847634.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Miller <davem@davemloft.net>
Cc: sergei.shtylyov@cogentembedded.com, netdev@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, 2014-01-02 at 19:34 -0500, David Miller wrote:
> From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Date: Tue, 31 Dec 2013 03:25:21 +0300
> 
> > @@ -1952,8 +1949,8 @@ static void sh_eth_tx_timeout(struct net
> >  	netif_stop_queue(ndev);
> >  
> >  	if (netif_msg_timer(mdp))
> > -		dev_err(&ndev->dev, "%s: transmit timed out, status %8.8x,"
> > -	       " resetting...\n", ndev->name, (int)sh_eth_read(ndev, EESR));
> > +		dev_err(&ndev->dev, "%s: transmit timed out, status %8.8x, resetting...\n"
> > +			ndev->name, (int)sh_eth_read(ndev, EESR));
> >  
> >  	/* tx_errors count up */
> >  	ndev->stats.tx_errors++;
> 
> You did not build test this.
> 
> drivers/net/ethernet/renesas/sh_eth.c: In function ‘sh_eth_tx_timeout’:
> drivers/net/ethernet/renesas/sh_eth.c:1953:4: error: expected ‘)’ before ‘ndev’

Also, this would likely be better as:

	netif_err(mdp, timer, ndev, "transmit timed out, status %#08lx, resetting...\n",
		  sh_eth_read(ndev, EESR));



