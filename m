From: morimoto.kuninori@renesas.com
Date: Wed, 08 Apr 2009 06:40:02 +0000
Subject: Question about sh-sci on SH7723
Message-Id: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi all

I have question about sh-sci on SH7723.
There are SCSPTRx define on sh-sci.h

--------------------------------------------
#elif defined(CONFIG_CPU_SUBTYPE_SH7723)
# define SCSPTR0                0xa4050160
# define SCSPTR1                0xa405013e
# define SCSPTR2                0xa4050160
# define SCSPTR3                0xa405013e
# define SCSPTR4                0xa4050128
# define SCSPTR5                0xa4050128
--------------------------------------------

0xa4050xxxx are IO port.
And this define is used on sci_rxd_in function.

--------------------------------------------
#elif defined(CONFIG_CPU_SUBTYPE_SH7723)
static inline int sci_rxd_in(struct uart_port *port)
{
        if (port->mapbase = 0xffe00000)
                return ctrl_inb(SCSPTR0) & 0x0008 ? 1 : 0; /* SCIF0 */
        if (port->mapbase = 0xffe10000)
                return ctrl_inb(SCSPTR1) & 0x0020 ? 1 : 0; /* SCIF1 */
        if (port->mapbase = 0xffe20000)
                return ctrl_inb(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF2 */
        if (port->mapbase = 0xa4e30000)
                return ctrl_inb(SCSPTR3) & 0x0001 ? 1 : 0; /* SCIF3 */
        if (port->mapbase = 0xa4e40000)
                return ctrl_inb(SCSPTR4) & 0x0001 ? 1 : 0; /* SCIF4 */
        if (port->mapbase = 0xa4e50000)
                return ctrl_inb(SCSPTR5) & 0x0008 ? 1 : 0; /* SCIF5 */
        return 1;
}
--------------------------------------------

This function seems check "rx break".
But, for example
------------------------------
ctrl_inb(SCSPTR0) & 0x0008 ? 1 : 0; /* SCIF0 */
------------------------------

seems return SCIF0_TXD value.
                   ~~~
But TXD is output isn't it ?
Can we read this value though it is output ?
And why TXD ?
Can not we use SCFSR :: BRK value ?

Best regards
--
Kuninori Morimoto
 
