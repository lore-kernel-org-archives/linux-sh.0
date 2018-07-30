From: Ulrich Hecht <uli@fpond.eu>
Date: Mon, 30 Jul 2018 15:18:43 +0000
Subject: Re: [PATCH QEMU] hw/char/sh_serial: Add timeout handling to unbreak serial input
Message-Id: <1115027626.150336.1532963923061@webmail.strato.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180730130234.30020-1-geert+renesas@glider.be>
In-Reply-To: <20180730130234.30020-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Peter Maydell <peter.maydell@linaro.org>
Cc: Rob Landley <rob@landley.net>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org


> On July 30, 2018 at 3:02 PM Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> 
> As of commit 18e8cf159177100e ("serial: sh-sci: increase RX FIFO trigger
> defaults for (H)SCIF") in Linux v4.11-rc1, the serial console on the
> QEMU SH4 target is broken: it delays serial input until enough data has
> been received.
> 
> Since aformentioned commit, the Linux SCIF driver programs the Receive
> FIFO Data Count Trigger bits in the FIFO Control Register, to postpone
> generating a receive interrupt until:
>   1. At least the receive trigger count of bytes of data are available
>      in the receive FIFO, OR
>   2. No further data has been received for at least 15 etu after the
>      last received data.
> 
> While QEMU implements the former, it does not implement the latter.
> Hence the receive interrupt is not generated until the former condition
> is met.
> 
> Fix this by adding basic timeout handling.  As the QEMU SCIF emulation
> ignores any serial speed programming, the timeout value used conforms to
> a default speed of 9600 bps, which is fine for any interative console.
> 
> Reported-by: Rob Landley <rob@landley.net>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Works for me, kernel 4.18-rc7 for rts7751r2dplus.

Tested-by: Ulrich Hecht <uli@fpond.eu>

CU
Uli
