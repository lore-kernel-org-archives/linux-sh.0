From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Mar 2008 09:24:42 +0000
Subject: Re: sh sh7710voipgw_defconfig compile error
Message-Id: <20080306092442.GA21177@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080303153843.GD26072@cs181133002.pp.htv.fi>
In-Reply-To: <20080303153843.GD26072@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 03, 2008 at 05:38:43PM +0200, Adrian Bunk wrote:
> It seems commit 9a7ef6d59f9d4780ff5bc9c4d05266b52dcb9211 broke the 
> support for this board:
> 
> <--  snip  -->
> 
> ...
>   CC      arch/sh/boards/renesas/sh7710voipgw/setup.o
> arch/sh/boards/renesas/sh7710voipgw/setup.c:15: error: array type has incomplete element type
> arch/sh/boards/renesas/sh7710voipgw/setup.c:16: error: 'TIMER2_IRQ' undeclared here (not in a function)
> arch/sh/boards/renesas/sh7710voipgw/setup.c:16: error: 'TIMER2_IPR_ADDR' undeclared here (not in a function)
> arch/sh/boards/renesas/sh7710voipgw/setup.c:16: error: 'TIMER2_IPR_POS' undeclared here (not in a function)
> arch/sh/boards/renesas/sh7710voipgw/setup.c:16: error: 'TIMER2_PRIORITY' undeclared here (not in a function)
> arch/sh/boards/renesas/sh7710voipgw/setup.c:17: error: 'WDT_IRQ' undeclared here (not in a function)
> arch/sh/boards/renesas/sh7710voipgw/setup.c:17: error: 'WDT_IPR_ADDR' undeclared here (not in a function)
> arch/sh/boards/renesas/sh7710voipgw/setup.c:17: error: 'WDT_IPR_POS' undeclared here (not in a function)
> arch/sh/boards/renesas/sh7710voipgw/setup.c:17: error: 'WDT_PRIORITY' undeclared here (not in a function)
> ...
> 
> <--  snip  -->
> 
Fixed now, this will go out with the -rc5 updates. Thanks.
