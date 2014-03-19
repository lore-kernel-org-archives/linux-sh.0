From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 19 Mar 2014 08:12:33 +0000
Subject: Re: [PATCH] micrel: fix masking off LED bits
Message-Id: <53295171.3020700@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <201403190258.16812.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201403190258.16812.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

On 19/03/14 00:58, Sergei Shtylyov wrote:
> Commit 20d8435a1cff (phy: micrel: add of configuration for LED mode) made the
> obvious mistake when masking off  the LED mode bits: forgot to do a logical NOT
> to the mask with which it ANDs the register value, so that unrelated bits are
> cleared instead.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Ben Dooks <ben.dooks@codethink.co.uk>

Oops, thanks for noticing that.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
