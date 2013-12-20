From: David Miller <davem@davemloft.net>
Date: Fri, 20 Dec 2013 00:11:18 +0000
Subject: Re: [PATCH 0/2] Add PHY IRQ support to the 'sh_eth' driver
Message-Id: <20131219.191118.2238735452700839030.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201312200138.09307.sergei.shtylyov@cogentembedded.com>
	<52B37684.5030206@cogentembedded.com>
In-Reply-To: <52B37684.5030206@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 20 Dec 2013 01:43:16 +0300

> On 12/20/2013 01:38 AM, Sergei Shtylyov wrote:
> 
>>     This patchset adds support for passing PHY's IRQ to the 'sh_eth'
>>     driver from
>> the platform code and removes now useless code that hinders the PHY
>> IRQ handing
>> by philib.
> 
>    Ugh, forgot to mention it's against DaveM's 'net-next.git' repo.

No need, series applied, thanks.
