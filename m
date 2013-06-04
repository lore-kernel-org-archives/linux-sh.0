From: Simon Horman <horms@verge.net.au>
Date: Tue, 04 Jun 2013 02:10:26 +0000
Subject: Re: [PATCH] thermal: rcar: set up I/O base before requesting IRQ
Message-Id: <20130604021026.GP23054@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1369817336-1953-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1369817336-1953-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 31, 2013 at 09:04:02AM +0200, Ulrich Hecht wrote:
> On Fri, May 31, 2013 at 7:48 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, May 29, 2013 at 10:48:56AM +0200, Ulrich Hecht wrote:
> >> It is used by the interrupt handler. Fixes crash when booting via kexec
> >> on APE6 board.
> >
> > could you clarify the target of this fix?
> > Is it for next and thus v3.11 or is it applicable to v3.10.
> > In the case of the latter is it also applicable to earlier
> > kernel versions and thus relevant to -stable.
> 
> The bug has been introduced by commit e0a5172 (thermal: rcar: add
> interrupt support), between v3.8-rc2 and v3.9-rc1.

Thanks and sorry for the delay, I have been travelling.

I have reposed this patch with an updated changelog, including
the information above, with the hope that Zhang Rui will
pick up the change for v3.10.
