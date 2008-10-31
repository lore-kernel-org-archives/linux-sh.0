From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 31 Oct 2008 07:05:27 +0000
Subject: Re: [RFC PATCH] Correct the interrupt handler in sh4 serial device.
Message-Id: <20081031070527.GC26928@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <490756B9.7000902@gandalf.sssup.it>
In-Reply-To: <490756B9.7000902@gandalf.sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: michael <trimarchi@gandalf.sssup.it>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Trimarchi <trimarchimichael@yahoo.it>

On Tue, Oct 28, 2008 at 07:15:21PM +0100, michael wrote:
> Correct the interrupt handler in sh4 serial device,
> return the correct value and check for what is anabled
>  in the SCSCR register. The sh7722 is broken just sending
> a break using minicom. I'm not sure for the value of
> SCI_CTRL_FLAGS_REIE in all architecture.
> 
> Signed-off-by: Michael Trimarchi <trimarchimichael@yahoo.it>
> 
Yes, this looks like a good change. It's a good indicator that the
original implementation of sci_mpxed_interrupt() was written with a
particular sub-type in mind ;-)

Applied, thanks.
