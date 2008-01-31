From: Kieran Bingham <kieranbingham@gmail.com>
Date: Thu, 31 Jan 2008 10:44:10 +0000
Subject: SH-Sci(f) driver as console
Message-Id: <1201776250.20171.72.camel@Atlas>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I'm having problems with the sh-sci driver as a console.

The early printk code works for my board; I added the register
definitions into the sh-sci.h file.

However, When it comes to register_console for the ttySC - at that
point, the uart's havent been registered, so the console doesn't attach,
failing at the line :


static int __init serial_console_setup(struct console *co, char
*options)
{
.
.
.
/*
 * Also need to check port->type, we don't actually have any
 * UPIO_PORT ports, but uart_report_port() handily misreports
 * it anyways if we don't have a port available by the time this is
 * called.
 */

 if (!port->type)
	return -ENODEV;

.
.
.
}

 only later does uart_register_driver get called when static int __init
sci_init(void) runs.

Do I need to change something to make the call to sci_init occur earlier
in the kernel ? or should I just call register console again later on
perhaps?

Cheers
-- 
Kieran Bingham <kieranbingham@gmail.com>

