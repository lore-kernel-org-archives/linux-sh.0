From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 06 Dec 2015 19:18:00 +0000
Subject: Re: [PATCH net] ravb: Remove clear unhandled interrupt
Message-Id: <566489E8.8040605@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449402140-24272-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1449402140-24272-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hello.

On 12/06/2015 02:42 PM, Yoshihiro Kaneko wrote:

> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>
> AVB-DMAC Reception Warning interrupt is not enabled, so it is not
> necessary to clear the interrupt.
>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

    In principle I agree but perhaps we should clear RIC1 in probe() to not 
depend on a state left from a bootloader?

MBR, Sergei

