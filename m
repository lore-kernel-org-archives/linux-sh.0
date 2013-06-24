From: David Miller <davem@davemloft.net>
Date: Mon, 24 Jun 2013 07:10:52 +0000
Subject: Re: [PATCH 2/2] sh_eth: fix misreporting of transmit abort
Message-Id: <20130624.001052.717125614529984964.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201306210113.43087.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306210113.43087.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 21 Jun 2013 01:13:42 +0400

> Due to obviously missing braces, EESR.TABT (transmit abort) interrupt may be
> reported even if it hasn't happened, just when EESR.TWB (transmit descriptor
> write-back) interrupt happens. Luckily (?), EESR.TWB is disabled by the driver
> via the TRIMD register and all the interrupt masks, so that transmit abort is
> never actually logged...
> 
> Put the braces where they should be and fix the incoherent comment, while at it. 
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Also applied to 'net'.
