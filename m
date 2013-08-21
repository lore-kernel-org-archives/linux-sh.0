From: David Miller <davem@davemloft.net>
Date: Wed, 21 Aug 2013 00:05:41 +0000
Subject: Re: [PATCH 2/2] sh_eth: remove 'register_type' field from 'struct sh_eth_plat_data'
Message-Id: <20130820.170541.1185336752082177256.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201308180308.39941.sergei.shtylyov@cogentembedded.com>
	<201308180313.26607.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308180313.26607.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 18 Aug 2013 03:13:26 +0400

> Now that the 'register_type' field of the 'sh_eth' driver's platform data is not
> used by the driver anymore, it's time to remove it and  its initializers from
> the SH platform code. Also  move *enum* declaring values for this  field from
> <linux/sh_eth.h>  to  the  local driver's  header file as they're only needed
> by the driver itself  now...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
