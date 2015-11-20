From: David Miller <davem@davemloft.net>
Date: Fri, 20 Nov 2015 19:53:08 +0000
Subject: Re: [PATCH v3 net-next] ravb: use clock rate as basis for GTI.TIV
Message-Id: <20151120.145308.462101495816748076.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1448047779-21242-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1448047779-21242-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms+renesas@verge.net.au
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com

From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 20 Nov 2015 11:29:39 -0800

> The GTI.TIV may be set to 2GHz^2 / rate, where rate is
> that of the clock of the device. Rather than assuming a
> rate of 130MHz use the actual rate of the clock.
> 
> The motivation for this is to use the correct rate on
> the r8a7795/Salvator-X which is advertised as 133MHz but
> may differ depending on the extal present on the Salvator-X.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied, thanks Simon.
