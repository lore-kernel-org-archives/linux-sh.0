From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 12 Jan 2009 12:58:26 +0000
Subject: Re: [Qemu-devel] sh: dcache flush breaks text region?
Message-Id: <20090112125826.GA14489@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4968DD28.3030709@juno.dti.ne.jp>
	<20090110195332.GD26952@edgar.se.axis.com>
	<49696E54.9030102@juno.dti.ne.jp>
In-Reply-To: <49696E54.9030102@juno.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Cc: qemu-devel@nongnu.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Sun, Jan 11, 2009 at 12:58:12PM +0900, Shin-ichiro KAWASAKI wrote:
> Edgar E. Iglesias wrote:
> >One way to handle this particular cacheflush sequence might be to delay all
> >movca stores until there's another load/store or cache control insn being
> >issued to help you figure out if you can ignore previous movca. That will
> >not by any means cover all cases though.
> It seems a good way to avoid this problem.
> My current modification plan is as follows.
> - On executing 'movca', just record the store task which movca
>   should do into CPUStatus.
> - On executing 'ocbi', delete the store task.
> - Let TCG produce 'delayed_movca' instruction for
>   the first 'memory touching insn' or 'exception producing insn'
>   after movca.
> - On executing 'delayed_movca', do the store tasks. 
> 
There are other ways in which movca is used as well, including with
ocbi/ocbwb (SH-X2 and later can also do ocbp), as well as with the movca
line being operated on by mov later without any explicit manipulation of
the dcache (common behaviour in read paths).

If you are going to model it in CPUStatus, you are going to have to
effectively have something that spans the size of the cache and watch out
for accessors. Not all will be through the dcache modifier instructions,
remember that memory-mapped access is also used for flushing in other
areas.

> >Another solution might be for linux to use a ocpb followed by a ocpi insn
> >on the line. IIUC that should achieve the same results net results.
> I'm not sure about it.  But I think we should not modify linux,
> because now I guess that the current linux works on real silicon. 
> 
Yes, we do not want to modify linux for this. Implementing real caches in
qemu is not going to be easy, but the kernel at least does have a
CONFIG_CACHE_OFF which you can select for qemu. If there is a page we can
test somewhere to figure out if we are under emulation we can likewise
just turn them off directly at boot.

Note that qemu also needs to be aware of the movca behavioural
differences between cache enabled and disabled.
