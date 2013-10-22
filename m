From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 22 Oct 2013 22:16:46 +0000
Subject: Re: [PATCH] sh_eth: add/use RMCR.RNC bit
Message-Id: <5266F94E.9030406@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201310160229.58735.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201310160229.58735.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, David Miller <davem@davemloft.net>
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org, horms@verge.net.au

Hello.

On 10/16/2013 02:29 AM, Sergei Shtylyov wrote:

> Declare 'enum EMCR_BIT' containing the single member for the RMCR.RNC bit and

    Hm, looks like I typoed here, should have been RMCR_BIT. David, should I 
resubmit or you can fix it while applying? Or simply not worth the trouble?

> replace bare numbers in the driver by  this mnemonic.

> Suggested-by: David Miller <davem@davemloft.net>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
> This patch is against DaveM's 'net.git' repo but it intended for 'net-next.git'
> repo -- it's  because 'net-next.git' doesn't contain the required Simon Horman's
> patch yet.

WBR, Sergei

