From: David Miller <davem@davemloft.net>
Date: Tue, 03 Nov 2015 04:01:25 +0000
Subject: Re: [PATCH] sh_eth: fix typo in RX descriptor bit name
Message-Id: <20151102.230125.542085160495385546.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <2943003.kyUQtQdRCT@wasted.cogentembedded.com>
In-Reply-To: <2943003.kyUQtQdRCT@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 03 Nov 2015 01:28:07 +0300

> The correct name of the RX descriptor 0 bit 30 is RDLE (receive descriptor
> list end),  not  RDEL.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the Dave Miller's 'net-next.git' repo.

Applied.
