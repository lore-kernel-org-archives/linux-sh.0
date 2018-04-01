From: David Miller <davem@davemloft.net>
Date: Sun, 01 Apr 2018 18:10:17 +0000
Subject: Re: [PATCH 0/2] sh_eth: remove SH_ETH_OFFSET_INVALID abuses
Message-Id: <20180401.141017.689185979742178948.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <998029b4-9400-ebc3-51c1-623c3f72b6cc@cogentembedded.com>
In-Reply-To: <998029b4-9400-ebc3-51c1-623c3f72b6cc@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 1 Apr 2018 00:15:04 +0300

> Hello!
> 
> Here's a set of 2 patches against DaveM's 'net-next.git' repo. They get rid of
> the abuse of SH_ETH_OFFSET_INVALID for the register existence checks, so that
> only its necessary uses would remain...
> 
> [1/2] sh_eth: add sh_eth_cpu_data::no_xdfar flag
> [2/2] sh_eth: kill useless check in __sh_eth_get_regs()

Series applied, thank you.
