From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 17 Jul 2008 05:53:03 +0000
Subject: Re: [PATCH 1/2] sh: update sh7343 code
Message-Id: <20080717055303.GA12007@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48720807.4020103@renesas.com>
In-Reply-To: <48720807.4020103@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 07, 2008 at 09:11:51PM +0900, Yoshihiro Shimoda wrote:
> updated the following codes for SH7343:
>  - add register_intc_controller()
>  - add EARLY_SCIF_CONSOLE_PORT
>  - add define of CPG register
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

On Mon, Jul 07, 2008 at 09:11:54PM +0900, Yoshihiro Shimoda wrote:
> updated the following codes for Solution Endine 7343:
>  - fix compile error in arch/sh/boards/se/7343/irq.c
>  - add nor flash physmaps
>  - update defconfig
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

On Wed, Jul 16, 2008 at 08:21:09PM +0900, Yoshihiro Shimoda wrote:
> This adds initial support for the Renesas R0P7785LC0011RL board.
> This patch supports 29bit address mode only.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

These are all applied, thanks.
