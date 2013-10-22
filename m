From: David Miller <davem@davemloft.net>
Date: Tue, 22 Oct 2013 23:08:21 +0000
Subject: Re: [PATCH] sh_eth: add/use RMCR.RNC bit
Message-Id: <20131022.190821.1644728583015494563.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201310160229.58735.sergei.shtylyov@cogentembedded.com>
	<5266F94E.9030406@cogentembedded.com>
In-Reply-To: <5266F94E.9030406@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org, horms@verge.net.au

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 23 Oct 2013 02:16:46 +0400

> Hello.
> 
> On 10/16/2013 02:29 AM, Sergei Shtylyov wrote:
> 
>> Declare 'enum EMCR_BIT' containing the single member for the RMCR.RNC
>> bit and
> 
>    Hm, looks like I typoed here, should have been RMCR_BIT. David, should
>    I resubmit or you can fix it while applying? Or simply not worth the
>    trouble?

I'll fix it when I apply it, thanks.
