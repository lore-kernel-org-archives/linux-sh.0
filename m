From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 02 Jun 2010 06:37:21 +0000
Subject: Re: [PATCH 4/4] Modify sh-sci.h to adopt specific serial behaviour of SH-2007
Message-Id: <20100602063721.GG15411@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 31, 2010 at 04:59:56PM +0900, Hitoshi Mitake wrote:
> Two points are changed,
>  * At end of sci_set_termios(), the value SCSCR_INIT(port)
>    is written to SCSCR. And the value of it for Subtype 7780
>    is 0x3a. This containts CKE1=1.
>    But, when this value is written to serial device of SH-2007,
>    this will stop. So we have to drop the flag of CKE1.
> 
>  * Baud rate written to SCBRR should be caliculated with this expression:
>    ((clk+16*bps)/(32*bps)-1)
>    Original form of this expression is:
>    ((clk+16*bps)/(16*bps)-1)
> 
I don't have any particular problems with this, the entire serial setup
is incredibly messy. I've been slowly rewriting most of the header to get
rid of this stuff, but it will still be some time before that work is
complete.

> These two points are really mysterious.
> But I don't have the way to validate processor on SH-2007,
> so I've mocked the kernel provided by the manufacture of this board :(
> ( http://ms-n.org/sh-linux/kernel/ )
> 
> This patch fix sh-sci.h in dirty way,
> but fortunately, this has no harm for other board and processors supports.
> If you permit to apply this patch,
> I'd like to find cause of this behaviour and revert this change someday.
> 
> Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
> ---
>  drivers/serial/sh-sci.h |   16 +++++++++++++++-
>  1 files changed, 15 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
> index f70c49f..f8c684c 100644
> --- a/drivers/serial/sh-sci.h
> +++ b/drivers/serial/sh-sci.h
>  # define SCIF_ORER	0x0001		/* Overrun error bit */
> -# define SCSCR_INIT(port)	0x3a	/* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
> +
> +#if defined(CONFIG_SH_SH2007)
> +/* TIE=0,RIE=0,TE=1,RE=1,REIE=1,CKE1=0 */
> +# define SCSCR_INIT(port)	0x38
> +#else
> +/* TIE=0,RIE=0,TE=1,RE=1,REIE=1,CKE1=1 */
> +# define SCSCR_INIT(port)	0x3a
> +#endif
> +
>  #elif defined(CONFIG_CPU_SUBTYPE_SH7785) || \
>        defined(CONFIG_CPU_SUBTYPE_SH7786)
>  # define SCSPTR0	0xffea0024	/* 16 bit SCIF */

This is ok, but..

> @@ -602,7 +610,13 @@ static inline int sci_rxd_in(struct uart_port *port)
>  #if defined(CONFIG_CPU_SUBTYPE_SH7780) || \
>      defined(CONFIG_CPU_SUBTYPE_SH7785) || \
>      defined(CONFIG_CPU_SUBTYPE_SH7786)
> +
> +#if defined(CONFIG_SH_SH2007)
> +#define SCBRR_VALUE(bps, clk) ((clk+16*bps)/(32*bps)-1)
> +#else
>  #define SCBRR_VALUE(bps, clk) ((clk+16*bps)/(16*bps)-1)
> +#endif
> +
>  #elif defined(CONFIG_CPU_SUBTYPE_SH7705) || \
>        defined(CONFIG_CPU_SUBTYPE_SH7720) || \
>        defined(CONFIG_CPU_SUBTYPE_SH7721) || \

This is just defaulting to the generic SH baudrate calculation, so you
can accomplish the same thing by just changing this to:

	#if defined(CONFIG_CPU_SUBTYPE_SH7780) || \
	    defined(CONFIG_CPU_SUBTYPE_SH7785) || \
	    defined(CONFIG_CPU_SUBTYPE_SH7786) && \
	    !defined(CONFIG_SH_SH2007)
