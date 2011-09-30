From: David Miller <davem@davemloft.net>
Date: Fri, 30 Sep 2011 07:54:49 +0000
Subject: Re: [PATCH] net: sh_eth: fix build failure
Message-Id: <20110930.035449.1012299223616580574.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4E8534A9.3050002@renesas.com>
	<CABMQnVLRO1q=Oi7CWE=CJqYcUBD6s+z1JTWrO8W1wVmFwuA45w@mail.gmail.com>
	<4E857506.5030501@renesas.com>
In-Reply-To: <4E857506.5030501@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro.shimoda.uh@renesas.com
Cc: nobuhiro.iwamatsu.yj@renesas.com, sfr@canb.auug.org.au, netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 30 Sep 2011 16:51:34 +0900

> 2011/09/30 15:55, Nobuhiro Iwamatsu wrote:
>> 2011/9/30 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>:
> < snip >
>>> +#include <linux/kernel.h>
>>> +#include <linux/spinlock.h>
>> These are not required.
> 
> The Documentation/SubmitChecklist says the following:
> 
> ============================
> 1: If you use a facility then #include the file that defines/declares
>    that facility.  Don't depend on other header files pulling in ones
>    that you use.
> ============================
> 
> The sh_eth driver uses spinlock functions and some macros of kernel.h.
> So, I think that I have to write their "#include" in the driver.

Agreed.
