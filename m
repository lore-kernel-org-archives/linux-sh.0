From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 14 Dec 2015 16:57:39 +0000
Subject: Re: [PATCH v3 net] ravb: clear RIC1 in init instead of stop
Message-Id: <566EF503.10304@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450110298-21392-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1450110298-21392-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On 12/14/2015 07:24 PM, Yoshihiro Kaneko wrote:

> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>
> AVB-DMAC Receive FIFO Warning interrupt is not enabled, so it is not
> necessary to disable the interrupt in ravb_close().
> On the other hand, this patch disables the interrupt in ravb_dmac_init() to
> prevent the possibility that the interrupt is issued by the state that
> a boot loader left.
>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
>
> This patch is based on the master branch of David Miller's networking
> tree.

    I think this should rather go into net-next.git though...

MBR, Sergei

