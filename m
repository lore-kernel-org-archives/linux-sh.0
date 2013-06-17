From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 17 Jun 2013 12:54:48 +0000
Subject: Re: [PATCH 1/2] serial: sh-sci: HSCIF support
Message-Id: <201306171454.48936.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1371440327-30512-1-git-send-email-horms+renesas@verge.net.au>
 <1371440327-30512-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1371440327-30512-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 17 June 2013, Simon Horman wrote:
> -       if (likely(baud && port->uartclk))
> -               t = sci_scbrr_calc(s->cfg->scbrr_algo_id, baud, port->uartclk);
> +       if (likely(baud && port->uartclk)) {
> +               if (s->cfg->scbrr_algo_id = SCBRR_ALGO_6) {
> +                       sci_baud_calc_hscif(baud, port->uartclk, &t, &srr,
> +                                           &cks);
> +               } else {
> +                       t = sci_scbrr_calc(s->cfg->scbrr_algo_id, baud,
> +                                          port->uartclk);
> +                       for (cks = 0; t >= 256 && cks <= 3; cks++)
> +                               t >>= 2;
> +               }
> +       }


This hunk causes build warnings in linux-next now:

/git/arm-soc/drivers/tty/serial/sh-sci.c: In function 'sci_set_termios':
/git/arm-soc/drivers/tty/serial/sh-sci.c:1942:37: warning: 'srr' may be used uninitialized in this function [-Wmaybe-uninitialized]
    serial_port_out(port, HSSRR, srr | HSCIF_SRE);
                                     ^
/git/arm-soc/drivers/tty/serial/sh-sci.c:1892:15: note: 'srr' was declared here
  unsigned int srr;
               ^
/git/arm-soc/drivers/tty/serial/sh-sci.c:1938:47: warning: 'cks' may be used uninitialized in this function [-Wmaybe-uninitialized]
   serial_port_out(port, SCSMR, (smr_val & ~3) | cks);
                                               ^
/git/arm-soc/drivers/tty/serial/sh-sci.c:1890:40: note: 'cks' was declared here
  unsigned int baud, smr_val, max_baud, cks;
                                        ^

	Arnd
