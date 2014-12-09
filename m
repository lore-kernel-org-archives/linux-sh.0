From: David Miller <davem@davemloft.net>
Date: Tue, 09 Dec 2014 23:05:57 +0000
Subject: Re: [PATCH v2] sh_eth: Remove redundant alignment adjustment
Message-Id: <20141209.180557.368241481301484599.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1418035581-3805-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1418035581-3805-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ykaneko0929@gmail.com
Cc: netdev@vger.kernel.org, horms@verge.net.au, magnus.damm@gmail.com, linux-sh@vger.kernel.org

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Mon,  8 Dec 2014 19:46:21 +0900

> From: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
> 
> PTR_ALIGN macro after skb_reserve is redundant, because skb_reserve
> function adjusts the alignment of skb->data.
> 
> Signed-off-by: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Applied.
