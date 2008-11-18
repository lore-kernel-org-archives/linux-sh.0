From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Nov 2008 15:57:35 +0000
Subject: Re: [PATCH] - Fix dreamcast irq.c formatting
Message-Id: <20081118155735.GB27417@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081118172847.1ac04194.kristoffer.ericson@gmail.com>
In-Reply-To: <20081118172847.1ac04194.kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 18, 2008 at 05:54:24PM +0100, Kristoffer Ericson wrote:
> On Wed, 19 Nov 2008 00:49:51 +0900
> Paul Mundt <lethal@linux-sh.org> wrote:
> 
> > On Tue, Nov 18, 2008 at 05:28:47PM +0100, Kristoffer Ericson wrote:
> > > This patch cleans the bad formatting
> > > found in mach-dreamcast/irq.c file.
> > > 
> > Why even bother? There are more useful things you can be doing with this
> > file, like fixing up the comment to deal with the fact there have been
> > path changes, converting to the new IRQ model (this is one of the last
> > ones left on hw_interrupt_type), etc. Once those sorts of things are out
> > of the way, the rest is fairly trivial to tidy, and you can fix up the
> > formatting as you go along with regards to new code.
> 
> Oki point taken. Ive got no dreamcast to fiddle with
> so I'll just leave it alone. Just decided to drop a patch
> when I accidently saw the mess it was in.
> 
Note that there is nothing wrong with fixing up whitespace damage as you
encounter it, I do so all the time (usually cleaning up after the emacs
people that can't work out what the hell a tab is), but you don't want
that sort of stuff to be the focus of your work. If you are interested in
cleaning up some of the dreamcast code, you are best off making a small
incremental patch series and posting it to the list to try and get people
with hardware to some testing for you.

There are plenty of useful things to be done in terms of low-hanging
fruit at least, whitespace formatting isn't one of them ;-)
