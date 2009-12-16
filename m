From: David Miller <davem@davemloft.net>
Date: Wed, 16 Dec 2009 05:17:09 +0000
Subject: Re: [PATCH] net: sh_eth alignment fix for sh7724 using
Message-Id: <20091215.211709.59661976.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20091215110344.13016.27379.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091215110344.13016.27379.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: magnus.damm@gmail.com
Cc: netdev@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Dec 2009 20:03:44 +0900

> From: Magnus Damm <damm@opensource.se>
> 
> Fix sh_eth for sh7724 by adding NET_IP_ALIGN support V2.
> Without this patch the receive data is misaligned.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied, thanks.
