From: David Miller <davem@davemloft.net>
Date: Tue, 13 Oct 2009 10:46:14 +0000
Subject: Re: [PATCH] net: allow sh_eth to get mac address through platform
Message-Id: <20091013.034614.226601436.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20091009101714.31039.91896.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091009101714.31039.91896.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: magnus.damm@gmail.com
Cc: netdev@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 09 Oct 2009 19:17:14 +0900

> From: Magnus Damm <damm@opensource.se>
> 
> Extend the sh_eth driver to allow passing the mac address
> using the platform data structure. This to simplify board
> setup code.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> Tested-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Applied to net-next-2.6
