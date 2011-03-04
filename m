From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Mar 2011 06:57:25 +0000
Subject: Re: [PATCH] serial: sh-sci: fix deadlock when resuming from S3 sleep
Message-Id: <20110304065725.GB13621@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1299139482-5235-1-git-send-email-gnurou@gmail.com>
In-Reply-To: <1299139482-5235-1-git-send-email-gnurou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 03, 2011 at 05:04:42PM +0900, Alexandre Courbot wrote:
> S3 sleep invokes the shutdown callback of the sh-sci driver, which
> suspends the clocks until they are reactivated by a call to startup.
> However, before the latter is invoked, sci_set_termios may be called on
> the port by uart_resume_port. In such cases it will endlessly wait for
> the TEND bit to raise, which will never happen since the clocks are
> disabled.
> 
> This patch ensures that clocks are enabled when ports registers are
> manipulated within sci_set_termios.
> 
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>

Applied, thanks.
