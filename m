From: David Miller <davem@davemloft.net>
Date: Sat, 29 Aug 2015 05:26:17 +0000
Subject: Re: [PATCH 1/2] ravb: propagate platform_get_irq() error upstream
Message-Id: <20150828.222617.2059651130537411431.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <9944836.IRPmWk4iN8@wasted.cogentembedded.com>
	<1625516.DmSERANoIv@wasted.cogentembedded.com>
In-Reply-To: <1625516.DmSERANoIv@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, horms@verge.net.au

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 28 Aug 2015 16:55:10 +0300

> The driver overrides the error returned by platform_get_irq() with -ENODEV
> which e.g. precludes the deferred  probing from working. Propagate the real
> error code to the driver core instead.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
