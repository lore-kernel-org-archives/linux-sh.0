From: David Miller <davem@davemloft.net>
Date: Tue, 03 Nov 2015 20:03:23 +0000
Subject: Re: [PATCH v2] sh_eth: use DMA barriers
Message-Id: <20151103.150323.2050849842791800571.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1753153.kv41W3qdJQ@wasted.cogentembedded.com>
In-Reply-To: <1753153.kv41W3qdJQ@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 03 Nov 2015 22:36:04 +0300

> Commit  7d7355f58ba4 ("sh_eth: Ensure proper ordering of descriptor active
> bit write/read") did the right thing  but used too "heavy" barriers while
> there were already "lighter" DMA barriers exactly  for this case...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied, thanks.
