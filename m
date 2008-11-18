From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Nov 2008 15:49:51 +0000
Subject: Re: [PATCH] - Fix dreamcast irq.c formatting
Message-Id: <20081118154951.GA27417@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081118172847.1ac04194.kristoffer.ericson@gmail.com>
In-Reply-To: <20081118172847.1ac04194.kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 18, 2008 at 05:28:47PM +0100, Kristoffer Ericson wrote:
> This patch cleans the bad formatting
> found in mach-dreamcast/irq.c file.
> 
Why even bother? There are more useful things you can be doing with this
file, like fixing up the comment to deal with the fact there have been
path changes, converting to the new IRQ model (this is one of the last
ones left on hw_interrupt_type), etc. Once those sorts of things are out
of the way, the rest is fairly trivial to tidy, and you can fix up the
formatting as you go along with regards to new code.

Whitespace changes have a high risk of causing merge conflicts and
provide precisely zero benefit. If you don't plan to be making any
constructive changes to this file, then simply leave it alone.
