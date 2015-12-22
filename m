From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 22 Dec 2015 06:42:57 +0000
Subject: Re: [PATCH] sh: sh-sci build failure fix.
Message-Id: <87bn9jt24u.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1447648066-1761-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1447648066-1761-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 22 Dec 2015 00:51:24 +0900,
Geert Uytterhoeven wrote:
> 
> Hi Sato-san,
> 
> On Mon, Nov 16, 2015 at 5:27 AM, Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
> > We need little update.
> >
> > Build failed on CONFIG_SERIAL_EARLYCON=y and CONFIG_SERIAL_SH_SCI=m.
> > I think it only COMPILE_TEST.
> >
> > earlycon code depend on CONFIG_SERIAL_SH_SCI_EARLYCON
> 
> Thanks!
> 
> You forgot to update the third test for CONFIG_SERIAL_EARLYCON.
> Without that fixed, I still get:
> 
> drivers/tty/serial/sh-sci.c:926:13: warning: 'sci_poll_put_char'
> defined but not used [-Wunused-function]
>  static void sci_poll_put_char(struct uart_port *port, unsigned char c)
>              ^
> (ignore the wrong line number)
> 
> I'll fix that, squash it into the original commit, and forward to GregKH, now
> commit e1dd3bef6d03c908 ("serial: earlycon: Add missing spinlock
> initialization") is upstream.

OK.
Please try this patch.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9078443..51ee286 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -581,7 +581,7 @@ static void sci_clear_SCxSR(struct uart_port *port, unsigned int mask)
 }
 
 #if defined(CONFIG_CONSOLE_POLL) || defined(CONFIG_SERIAL_SH_SCI_CONSOLE) \
-	|| defined(CONFIG_SERIAL_EARLYCON)
+	|| defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
 
 #ifdef CONFIG_CONSOLE_POLL
 static int sci_poll_get_char(struct uart_port *port)
@@ -622,7 +622,8 @@ static void sci_poll_put_char(struct uart_port *port, unsigned char c)
 	serial_port_out(port, SCxTDR, c);
 	sci_clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
 }
-#endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE */
+#endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE
+	  || CONFIG_SERIAL_SH_SCI_EARLYCON_*/
 
 static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 {

> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > ---
> >  drivers/tty/serial/sh-sci.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> > index 39e5358..9078443 100644
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -2412,7 +2412,7 @@ static void sci_cleanup_single(struct sci_port *port)
> >         pm_runtime_disable(port->port.dev);
> >  }
> >
> > -#if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || defined(CONFIG_SERIAL_EARLYCON)
> > +#if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
> >  static void serial_console_putchar(struct uart_port *port, int ch)
> >  {
> >         sci_poll_put_char(port, ch);
> > @@ -2793,7 +2793,7 @@ static void __exit sci_exit(void)
> >  early_platform_init_buffer("earlyprintk", &sci_driver,
> >                            early_serial_buf, ARRAY_SIZE(early_serial_buf));
> >  #endif
> > -#ifdef CONFIG_SERIAL_EARLYCON
> > +#ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
> >  static struct __init plat_sci_port port_cfg;
> >
> >  static int __init early_console_setup(struct earlycon_device *device,
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
