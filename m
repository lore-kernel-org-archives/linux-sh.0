From: David Miller <davem@davemloft.net>
Date: Tue, 09 Dec 2014 23:06:22 +0000
Subject: Re: [PATCH v3] sh_eth: Optimization for RX excess judgement
Message-Id: <20141209.180622.1299267904682284783.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1418127822-16904-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1418127822-16904-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ykaneko0929@gmail.com
Cc: netdev@vger.kernel.org, horms@verge.net.au, magnus.damm@gmail.com, linux-sh@vger.kernel.org

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Tue,  9 Dec 2014 21:23:42 +0900

> From: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
> 
> Both of 'boguscnt' and 'quota' have nearly meaning as the condition of
> the reception loop.
> In order to cut down redundant processing, this patch changes excess
> judgement.
> 
> Signed-off-by: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Applied.
