From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 11 Jan 2016 18:02:02 +0000
Subject: Re: Bootable sh4 qemu images.
Message-Id: <20160111180202.GE6344@twins.programming.kicks-ass.net>
List-Id: <linux-sh.vger.kernel.org>
References: <568FFC28.2010409@landley.net>
In-Reply-To: <568FFC28.2010409@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 08, 2016 at 12:12:56PM -0600, Rob Landley wrote:
> The sh4 images are "qemu-system-sh4.tar.gz", the current release (1.4.4)
> is based on musl-libc and kernel 4.2

> P.S. Sorry I've fallen a couple kernel versions behind, I'm trying to
> catch up

Ah, so you've not yet found if I broken SH in 4.3 with:

b31fdac2a921 ("sched, sh: Fold finish_arch_switch() into switch_to()")

:-)
