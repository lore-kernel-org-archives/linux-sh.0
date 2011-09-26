From: Federico Fuga <ml@studiofuga.com>
Date: Mon, 26 Sep 2011 11:50:53 +0000
Subject: sh-sci blocked for sh7203
Message-Id: <FC11CF24-702F-485C-9B97-464C8746E4B0@studiofuga.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, 

I am working on a sh7203 platform, running linux 2.6.37.
It worked just fine, except some other problem do not worth mention here.
Now I wanted to update the kernel - I once tried with 2.6.38 but faced problems while booting, and I kept my working version.
Now tried again with 3.0.x but the same problem occurred.
While using the e10a emulator I found that the boot process blocks while setting up the kernel.
It locks up here:

static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
                            struct ktermios *old)
{

// ....
        do {
                status = sci_in(port, SCxSR);
        } while (!(status & SCxSR_TEND(port)));

// ....


Here the sci0 registers dump :

SCSMR: 0000
SCBRR: 0008
SCSCR: 0038
SCFSR: 0060
SCFCR: 0000
SCFDR: 0000
SCSPTR: 0051
SCLSR: 0000
SCEMR: 0000

It seems that the SCSCR register disables the TX and RX, so the flags can't pass the loop.
Did anyone find similar issue? Where can I check if these registers are correctly setup?

thank you in advance

best regards

ing. Federico Fuga



