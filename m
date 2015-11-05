From: David Miller <davem@davemloft.net>
Date: Thu, 05 Nov 2015 01:59:33 +0000
Subject: Re: [PATCH] sh_eth: kill 'ret' variable in sh_eth_ring_init()
Message-Id: <20151104.205933.1566095146723535499.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <3103690.zc6n37veWQ@wasted.cogentembedded.com>
In-Reply-To: <3103690.zc6n37veWQ@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 04 Nov 2015 00:17:08 +0300

> The 'ret' local variable in sh_eth_ring_init() serves no useful purpose as
> the only  values it gets assigned are 0 and -ENOMEM both of which could be
> returned directly...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
