From: Paul Mundt <paul.mundt@renesas.com>
Date: Tue, 11 Mar 2008 03:43:24 +0000
Subject: Re: SH7760,7780,7785 sh-sci.c bugfix
Message-Id: <20080311034324.GC16685@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <24C8828EFB268Eebiharaml@si-linux.com>
In-Reply-To: <24C8828EFB268Eebiharaml@si-linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 10, 2008 at 06:13:19PM +0900, Yutaro Ebihara wrote:
> --- linux-2.6.24_cat/drivers/serial/sh-sci.c-old        2008-03-06 19:
> 40:13.000000000 +0900
> +++ linux-2.6.24_cat/drivers/serial/sh-sci.c    2008-03-06 19:40:27.
> 000000000 +0900
> @@ -412,12 +412,12 @@
>      defined(CONFIG_CPU_SUBTYPE_SH7785)
>  static inline int scif_txroom(struct uart_port *port)
>  {
> -       return SCIF_TXROOM_MAX - (sci_in(port, SCTFDR) & 0x7f);
> +       return SCIF_TXROOM_MAX - (sci_in(port, SCTFDR) & 0xff);
>  }
> 
>  static inline int scif_rxroom(struct uart_port *port)
>  {
> -       return sci_in(port, SCRFDR) & 0x7f;
> +       return sci_in(port, SCRFDR) & 0xff;
>  }
>  #else
>  static inline int scif_txroom(struct uart_port *port)
>  
>  
Looks reasonable, good catch. I'll add it to the 2.6.25 queue, thanks.
