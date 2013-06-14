From: David Miller <davem@redhat.com>
Date: Fri, 14 Jun 2013 01:07:05 +0000
Subject: Re: [PATCH v2] net: sh_eth: fix incorrect RX length error if R8A7740
Message-Id: <20130613.180705.122109655034336793.davem@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <51B91D41.1000908@renesas.com>
	<20130613.030259.1909989123383615468.davem@davemloft.net>
	<51BA052C.8000907@cogentembedded.com>
In-Reply-To: <51BA052C.8000907@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: yoshihiro.shimoda.uh@renesas.com, netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 13 Jun 2013 21:45:16 +0400

> Hello.
> 
> On 06/13/2013 02:02 PM, David Miller wrote:
> 
>>> This patch fixes an issue that the driver increments the "RX length
>>> error"
>>> on every buffer in sh_eth_rx() if the R8A7740.
>>> This patch also adds a description about the Receive Frame Status
>>> bits.
> 
>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
>> Applied, thanks.
> 
>    I've already asked to do this but will you queue this for stable now?

Done.
