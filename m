From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 28 Oct 2011 06:09:00 +0000
Subject: Re: [PATCH] sh: modify the asm/sh_eth.h to linux/sh_eth.h in some boards
Message-Id: <20111028060900.GE32187@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4E82D17A.7050108@renesas.com>
In-Reply-To: <4E82D17A.7050108@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 28, 2011 at 04:49:14PM +0900, Yoshihiro Shimoda wrote:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  - This patch depends on the following patch:
>   - net: sh_eth: move the asm/sh_eth.h to include/linux/
>  - This patch doesn't contain board-sh7757lcr.c, because
>    it needs more modification.
> 
>  arch/sh/boards/board-espt.c           |    2 +-
>  arch/sh/boards/mach-ecovec24/setup.c  |    2 +-
>  arch/sh/boards/mach-se/7724/setup.c   |    2 +-
>  arch/sh/boards/mach-sh7763rdp/setup.c |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
Applied, thanks.
