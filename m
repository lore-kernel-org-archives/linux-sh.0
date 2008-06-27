From: Jeff Garzik <jeff@garzik.org>
Date: Fri, 27 Jun 2008 06:09:02 +0000
Subject: Re: [PATCH] net: sh_eth: Fix compile error sh_eth
Message-Id: <486483FE.9090709@garzik.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4858D619.80403@renesas.com>
In-Reply-To: <4858D619.80403@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: netdev@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Linux-sh <linux-sh@vger.kernel.org>, shimoda.yoshihiro@renesas.com

Nobuhiro Iwamatsu wrote:
> Fix compile error on sh_eth and remove base address macro.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
> ---
>  drivers/net/sh_eth.c |    4 ++--
>  drivers/net/sh_eth.h |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

applied


