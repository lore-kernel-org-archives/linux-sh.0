From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 11 Jan 2011 03:49:31 +0000
Subject: Re: sh: add PVR probing for SH7757 3rd cut
Message-Id: <20110111034931.GL3760@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4D26EA50.1000403@renesas.com>
In-Reply-To: <4D26EA50.1000403@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 07, 2011 at 07:26:24PM +0900, Yoshihiro Shimoda wrote:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  arch/sh/kernel/cpu/sh4/probe.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

On Fri, Jan 07, 2011 at 07:26:26PM +0900, Yoshihiro Shimoda wrote:
>  - disable the 8250 driver (fix the build error on sh7757lcr)
>  - enable sh_eth driver
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Both applied, thanks.
