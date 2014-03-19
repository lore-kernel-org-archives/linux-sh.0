From: David Miller <davem@davemloft.net>
Date: Wed, 19 Mar 2014 21:42:05 +0000
Subject: Re: [PATCH] micrel: fix masking off LED bits
Message-Id: <20140319.174205.1425627653050633421.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201403190258.16812.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201403190258.16812.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, ben.dooks@codethink.co.uk

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 19 Mar 2014 02:58:16 +0300

> Commit 20d8435a1cff (phy: micrel: add of configuration for LED mode) made the
> obvious mistake when masking off  the LED mode bits: forgot to do a logical NOT
> to the mask with which it ANDs the register value, so that unrelated bits are
> cleared instead.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied to net-next, thanks.
