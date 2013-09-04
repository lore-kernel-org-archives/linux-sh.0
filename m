From: David Miller <davem@davemloft.net>
Date: Wed, 04 Sep 2013 18:12:52 +0000
Subject: Re: [PATCH] sh_eth: NAPI requires netif_receive_skb()
Message-Id: <20130904.141252.532474080722830977.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201309030303.11381.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201309030303.11381.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 3 Sep 2013 03:03:10 +0400

> Driver supporting NAPI should use NAPI-specific function for receiving packets,
> so netif_rx() should be changed to netif_receive_skb().
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
