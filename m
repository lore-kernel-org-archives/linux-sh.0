From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 09 Feb 2011 07:28:22 +0000
Subject: Re: [PATCH] serial: sh-sci: prevent setup of uninitialized serial console
Message-Id: <20110209072822.GB16518@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1297221526-32283-1-git-send-email-gnurou@gmail.com>
In-Reply-To: <1297221526-32283-1-git-send-email-gnurou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 09, 2011 at 12:18:46PM +0900, Alexandre Courbot wrote:
> Commit 906b17dc089f7fa87e37a9cfe6ee185efc90e0da introduced a condition
> where the kernel will crash unless a earlyprintk parameter is specified.
> 
> Without this parameter, sci_console_init is called during early console
> setup without any port being initialized, and the kernel crashes a
> little bit later when uart_set_options attemps to invoke set_termios on a
> port with an ops member equal to NULL.
> 
> This patch just checks in sci_console_init that the port is properly
> initialized, and aborts the early console setup if it is not.
> 
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>

Looks good. Applied, thanks.
