From: David Miller <davem@davemloft.net>
Date: Thu, 13 Nov 2014 20:04:43 +0000
Subject: Re: [PATCH] sh_eth: Optimization for RX excess judgement
Message-Id: <20141113.150443.289073124712490803.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1415862031-27925-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1415862031-27925-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ykaneko0929@gmail.com
Cc: netdev@vger.kernel.org, horms@verge.net.au, magnus.damm@gmail.com, linux-sh@vger.kernel.org

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Thu, 13 Nov 2014 16:00:31 +0900

> From: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
> 
> Both of 'boguscnt' and 'quota' have nearly meaning as the condition of
> the reception loop.
> In order to cut down redundant processing, this patch changes excess judgement.
> 
> Signed-off-by: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
> 
> This patch is based on net tree.

On what basis is an optimization like this appropriate for 'net'?  I really
don't think it is.
