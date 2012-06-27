From: David Miller <davem@davemloft.net>
Date: Wed, 27 Jun 2012 08:24:54 +0000
Subject: Re: [PATCH net-next 3/4 v2] net: sh_eth: fix up the buffer pointers
Message-Id: <20120627.012454.376798396628515657.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4FEAA161.4030001@renesas.com>
In-Reply-To: <4FEAA161.4030001@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro.shimoda.uh@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 27 Jun 2012 15:00:01 +0900

> After freeing the buffer, the driver should change the value of
> the pointer to NULL.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied.
