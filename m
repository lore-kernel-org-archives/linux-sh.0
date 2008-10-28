From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 28 Oct 2008 08:17:54 +0000
Subject: Re: [PATCH] SH 7366 needs SCIF_ONLY
Message-Id: <20081028081754.GA24850@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <u63ndp678.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u63ndp678.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 28, 2008 at 05:14:29PM +0900, morimoto.kuninori@renesas.com wrote:
> 
> Hi Paul
> 
> Thank you for your comment.
> 
> > Which platform are you building for? Can you provide your .config? We
> > presently do not have an in-tree SH7366 board, which is how this was
> > missed. I'll apply your patch for 2.6.28. For 2.6.29, all of that has
> > been rewritten.
> 
> Now I use UL2 board.
> Attached .config file is for that board.
> The part that depended on UL2 board was erased.
> 
> compile error is following.
> ----------
>   CHK     include/linux/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
>   CC      drivers/serial/sh-sci.o
> drivers/serial/sh-sci.c: In function 'sci_transmit_chars':
> drivers/serial/sh-sci.c:490: error: implicit declaration of function 'scif_txroom'
> drivers/serial/sh-sci.c: In function 'sci_receive_chars':
> drivers/serial/sh-sci.c:552: error: implicit declaration of function 'scif_rxroom'
> drivers/serial/sh-sci.c: In function 'sci_config_port':
> drivers/serial/sh-sci.c:1129: error: 'sci_init_pins_scif' undeclared (first use in this function)
> drivers/serial/sh-sci.c:1129: error: (Each undeclared identifier is reported only once
> drivers/serial/sh-sci.c:1129: error: for each function it appears in.)
> make[2]: *** [drivers/serial/sh-sci.o] Error 1
> make[1]: *** [drivers/serial] Error 2
> make: *** [drivers] Error 2
> ----------
> 
> The patch works well on my local environment.
> 
Ok, I'll add in the defconfig so we can hook that in to the nightly
builds. It can use the generic machvec until you are ready to submit
extended board support for UL2. Thanks.
