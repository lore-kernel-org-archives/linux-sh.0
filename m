From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 28 Jan 2016 17:51:39 +0000
Subject: Re: [PATCH/RFC v4 net-next] ravb: Add dma queue interrupt support
Message-Id: <56AA552B.9080608@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453650775-19886-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1453650775-19886-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On 01/24/2016 06:52 PM, Yoshihiro Kaneko wrote:

> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>
> This patch supports the following interrupts.
>
> - One interrupt for multiple (descriptor, error, management)

    Looking at the code again, ravb_multi_interrupot() only handles error and 
gPTP interrupt now.

> - One interrupt for emac
> - Four interrupts for dma queue (best effort rx/tx, network control rx/tx)
>
> This patch improve efficiency of the interrupt handler by adding the
> interrupt handler corresponding to each interrupt source described
> above. Additionally, it reduces the number of times of the access to
> EthernetAVB IF.

    I'd still like to see there a statement about not being dependent on the 
whim of a boot loader any more...

>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

[...]

MBR, Sergei

