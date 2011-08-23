From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 23 Aug 2011 10:31:48 +0000
Subject: Re: [PATCH] serial: sh-sci: report CTS as active for get_mctrl
Message-Id: <20110823103148.GA26391@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4E536466.6020604@renesas.com>
In-Reply-To: <4E536466.6020604@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 23, 2011 at 05:27:18PM +0900, Yoshii Takashi wrote:
> Hi, anybody want to use RTS/CTS on sh-sci?
> 
> It does not seems to have been working for long time.
> Here is the one-line fix.
> 
> I'm not sure what is the optimal set of the "false" signal for get_mctrl.
> I guess it might be CD|DSR|CTS, but this patch does only minimum change.
> 
> Description follows...
> 
> sh-sci.c sets hardware up and then let the HW do all flow controls.
> There is no software code, nor needs to get/set real CTS signal.
> 
> But, when turning CRTSCTS on through termios, uart_set_termios() in
> serial_core.c checks CTS, and stops TX if it is inactive at the moment.
> 
> Because sci_get_mctrl() returns a fixed value DTR|RTS|DSR but CTS,
> the sequence
>   open -> set CRTSCTS -> write
> hit the case and stop working, no more outputs.
> 
> This patch makes sci_get_mctrl() report CTS in addition.
> 
> Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>

This looks reasonable, but what application specifically was hitting
this? I'd like for this to hang around a bit before sending it off for
-stable in any event. There are a lot of CPUs and port types to check..
