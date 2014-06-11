From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 11 Jun 2014 22:21:12 +0000
Subject: Re: [PATCH v2 0/2] net: sh_eth: Fix two issues in sh_eth_rx()
Message-Id: <5398D658.2090100@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <539653E4.9080808@renesas.com> <20140611.151555.814836065790733997.davem@davemloft.net>
In-Reply-To: <20140611.151555.814836065790733997.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, yoshihiro.shimoda.uh@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 06/12/2014 02:15 AM, David Miller wrote:

>> I used the latest net.git repository.
>>   commit id = 87757a917b0b3c0787e0563c679762152be81312
>>   (net: force a list_del() in unregister_netdevice_many())

>> I tested these patches on r8a7790.

>> Changes from v1:
>>   - Remove unnecessary parens in patch 1.

> Applied, thanks.

    Eh, haven't had time to look at these patches in detail... :-/

WBR, Sergei

