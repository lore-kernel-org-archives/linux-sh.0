From: Simon Horman <horms@verge.net.au>
Date: Thu, 06 Mar 2014 04:19:13 +0000
Subject: Re: [PATCH 2/2] serial: sh-sci: Add missing call to uart_remove_one_port() in failure path
Message-Id: <20140306041912.GB29693@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1393593694-30262-1-git-send-email-geert@linux-m68k.org>
 <1393593694-30262-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1393593694-30262-2-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

On Fri, Feb 28, 2014 at 02:21:33PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> If cpufreq_register_notifier() fails, we have to remove the port added by
> sci_probe_single(), which is not done by sci_cleanup_single().
> 
> Else the serial port stays active from the point of view of the serial
> subsystem, and it may crash when userspace getty is started, or when the
> loadable driver module is unloaded.
> 
> This was introduced by commit 6dae14216c85eea13db7b12c469475c5d30e5499
> ("serial: sh-sci: Fix probe error paths").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

This looks reasonable to me.

Greg, could you take this one?


> ---
> This depends on "serial_core: Unregister console in uart_remove_one_port()"
> when using a serial console.
> ---
>  drivers/tty/serial/sh-sci.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index be33d2b0613b..7958115e6a51 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2564,6 +2564,7 @@ static int sci_probe(struct platform_device *dev)
>  	ret = cpufreq_register_notifier(&sp->freq_transition,
>  					CPUFREQ_TRANSITION_NOTIFIER);
>  	if (unlikely(ret < 0)) {
> +		uart_remove_one_port(&sci_uart_driver, &sp->port);
>  		sci_cleanup_single(sp);
>  		return ret;
>  	}
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
