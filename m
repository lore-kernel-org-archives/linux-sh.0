From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 17 Dec 2012 00:48:10 +0000
Subject: Re: [PATCH 2/2] net: sh_eth: Add Device Tree support
Message-Id: <87vcc1ijwa.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1355666066-25649-3-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1355666066-25649-3-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Bastian

> We add support for Device Tree probing in order to support the Armadillo
> DT testcase.
> 
> Until we figure out what portions of the platform config are board
> dependent and should be used as OF properties and what portions are only
> SoC related and can be stored in the driver itself, I have attached all
> platform configurations to the OF match in the driver.
> 
> Not-yet-signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
>  drivers/net/ethernet/renesas/sh_eth.c |   72 ++++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)

I'm not sure current status, 
but I guess Iwamatsu-san already had sent sh_eth DT support ?
http://permalink.gmane.org/gmane.linux.network/246019


Best regards
---
Kuninori Morimoto
