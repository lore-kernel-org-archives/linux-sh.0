From: David Miller <davem@davemloft.net>
Date: Tue, 13 May 2014 22:51:52 +0000
Subject: Re: [PATCH v2] sh_eth: replace devm_kzalloc() with devm_kmalloc_array()
Message-Id: <20140513.185152.2201531561679333133.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201405130230.14743.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201405130230.14743.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 13 May 2014 02:30:14 +0400

> When I was converting the driver to the managed device API, only devm_kzalloc()
> was available for memory allocation, so I had to use it, despite zeroing out the
> PHY IRQ array right before initializing all  its entries to PHY_POLL was quite
> stupid.   Now that devm_kmalloc_array() has become available, we can avoid the
> needless zeroing out...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied, thanks Sergei.
