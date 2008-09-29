From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Sep 2008 11:17:39 +0000
Subject: Re: [PATCH] sh: Rework sh7720 GPIO header usage
Message-Id: <20080929111739.GA20424@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080929104626.5354.80315.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080929104626.5354.80315.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 29, 2008 at 07:46:26PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch reworks the sh7720 gpio includes. Makes space for the
> generic GPIO code.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Compile tested with the magicpanelr2_defconfig.
> 
>  arch/sh/include/asm/gpio.h         |    8 --------
>  arch/sh/include/asm/magicpanelr2.h |    2 +-
>  drivers/serial/sh-sci.h            |    4 +++-
>  3 files changed, 4 insertions(+), 10 deletions(-)
> 
Churn in drivers/ for this kind of thing is pretty uninspiring. I'll just
change the asm/gpio.h ifdef to reference cpu-sh3 explicitly instead. It
will serve as a reminder that SH-3 still needs to be converted.
