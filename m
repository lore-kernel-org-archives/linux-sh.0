From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 29 Jun 2011 08:39:37 +0000
Subject: Re: [PATCH] sh: fix the value of sh_dmae_slave_config in setup-sh7757
Message-Id: <20110629083937.GA22023@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4E0AA8CE.1020205@renesas.com>
In-Reply-To: <4E0AA8CE.1020205@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 29, 2011 at 01:23:42PM +0900, Yoshihiro Shimoda wrote:
> Fix the value of chcr for SCIF[2-4]_RX and RIIC[0-9]_RX and
> the value of mid_rid for some RIIC.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On Wed, Jun 29, 2011 at 01:23:47PM +0900, Yoshihiro Shimoda wrote:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   24 ++++++++++++------------
>  1 files changed, 12 insertions(+), 12 deletions(-)
> 
Both applied, thanks.
