From: David Miller <davem@davemloft.net>
Date: Wed, 23 Oct 2013 20:50:34 +0000
Subject: Re: [PATCH] sh_eth: add/use RMCR.RNC bit
Message-Id: <20131023.165034.537485764263918532.davem@davemloft.net>
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

Applied, with the typo fixed, thanks.
