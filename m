From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jun 2013 09:29:03 +0000
Subject: Re: [PATCH] sh_eth: fix result of sh_eth_check_reset() on timeout
Message-Id: <20130611.022903.247033946592424291.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201306052354.02265.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306052354.02265.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 5 Jun 2013 23:54:01 +0400

> When  the first loop in sh_eth_check_reset() runs to its end, 'cnt' is 0, so the
> following check for 'cnt < 0' fails to catch the timeout.  Fix the  condition in
> this check, so that the timeout  is actually reported.
> While at it, fix the grammar in the failure message...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
