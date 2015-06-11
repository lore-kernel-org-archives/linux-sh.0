From: David Miller <davem@davemloft.net>
Date: Thu, 11 Jun 2015 07:14:55 +0000
Subject: Re: [PATCH v6 2/2] Renesas Ethernet AVB PTP clock driver
Message-Id: <20150611.001455.377939359927165224.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <2950738.iaDWZVkjG3@wasted.cogentembedded.com>
In-Reply-To: <2950738.iaDWZVkjG3@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, linux-sh@vger.kernel.org, masaru.nagai.vx@renesas.com

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 11 Jun 2015 01:02:30 +0300

> Ethernet AVB device includes the gPTP  timer, so we can implement a PTP clock
> driver.  We're doing that in a separate file, with  the main Ethernet driver
> calling the PTP driver's [de]initialization and interrupt handler functions.
> Unfortunately, the clock seems tightly coupled with the AVB-DMAC, so when that
> one leaves the operation mode, we have to unregister the PTP clock... :-(
> 
> Based on the original patches by Masaru Nagai.
> 
> Signed-off-by: Masaru Nagai <masaru.nagai.vx@renesas.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
