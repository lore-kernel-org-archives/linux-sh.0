From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 01 Jul 2013 14:27:16 +0000
Subject: Re: [PATCH net-next v3 2/3] sh_eth: add support RMIIMODE register
Message-Id: <51D191C4.1030103@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372652695-16606-1-git-send-email-horms+renesas@verge.net.au> <1372652695-16606-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1372652695-16606-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hello.

On 01-07-2013 8:24, Simon Horman wrote:

> This change is motivated by the lager board which uses the r8a7790 SoC,
> an R-Car SoC. For this board setting the RMIIMODE register is necessary.

> This patch assumes this is valid for all R-Car SoCs.

    This is not so for this version of the patch.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

WBR, Sergei

