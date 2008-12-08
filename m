From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 08 Dec 2008 02:33:23 +0000
Subject: Re: Bug report about udivsi3-0s.S
Message-Id: <20081208023323.GB8860@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ur64ntkcp.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ur64ntkcp.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Morimoto-san,

On Fri, Dec 05, 2008 at 11:40:54AM +0900, morimoto.kuninori@renesas.com wrote:
> I notice bug of ${LINUX}/arch/sh/lib/udivsi3-0s.
> 
> My environment is
> 
> gcc : sh4-unknown-linug-gnu-gcc
> OS  : Linux 2.6.28-rc6 (from latest git)
> CPU : SH7723
> 
> When I use latest Linux 2.6.28-rc6 and sh4-unknown-linug-gnu-gcc,
> kernel starts an infinite loop on sh-sci.c :: sci_set_termios
> 
> but it works well when I use sh4-linux-gcc
> 
> And I found the reason.
> I think __udivsi3 should not break r1 register.
> 
> following is my kernel.
> Kernel starts infinite loop on 88118408.
> 
With Yoshii-san's patch in place this should be fixed now, please see if
current git works for you.
