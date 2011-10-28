From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 28 Oct 2011 06:17:45 +0000
Subject: Re: [PATCH 16/49] SH: irq: Remove IRQF_DISABLED
Message-Id: <20111028061745.GI32187@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1319277421-9203-1-git-send-email-yong.zhang0@gmail.com> <1319277421-9203-17-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1319277421-9203-17-git-send-email-yong.zhang0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, linux-sh@vger.kernel.org

On Sat, Oct 22, 2011 at 05:56:28PM +0800, Yong Zhang wrote:
> Since commit [e58aa3d2: genirq: Run irq handlers with interrupts disabled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
> 
> So now this flag is a NOOP and can be removed.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

Applied, thanks.
