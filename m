From: David Miller <davem@davemloft.net>
Date: Mon, 17 Mar 2014 20:05:31 +0000
Subject: Re: [PATCH] sh_eth: exit probe with unknown register layout
Message-Id: <20140317.160531.2098314333892795669.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201403150311.25173.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201403150311.25173.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 15 Mar 2014 03:11:24 +0300

> Exit the driver's probe() method when the register layout is unknown as the
> driver would cause kernel oops in this case anyway.
> 
> While at it, move the corresponding error message printout and convert it from
> pr_err() to dev_err().
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied, thanks.
