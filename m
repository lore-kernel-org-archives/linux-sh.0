From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 06 Jan 2016 16:57:40 +0000
Subject: Re: [PATCH v2 31/32] sh: support a 2-byte smp_store_mb
Message-Id: <20160106165740.GX6344@twins.programming.kicks-ass.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-32-git-send-email-mst@redhat.com>
 <20160105232735.GC238@brightrain.aerifal.cx>
 <20160106131321-mutt-send-email-mst@redhat.com>
 <20160106114023.GU6344@twins.programming.kicks-ass.net>
 <20160106134301-mutt-send-email-mst@redhat.com>
 <20160106143218.GV6344@twins.programming.kicks-ass.net>
 <568D35EB.7090108@landley.net>
In-Reply-To: <568D35EB.7090108@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Jeff Dionne <jeff@uclinux.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Wed, Jan 06, 2016 at 09:42:35AM -0600, Rob Landley wrote:
> (I would have thought the presence of working QEMU support would tide us
> over providing an easy basic regression testing environment, but people
> keep insisting that's not real and doesn't count. But if we can keep it
> 99% working until the sh4 patents expire later this year, we can add mmu
> and have full sh4 in hardware again with BSD VHDL.)

I didn't know there was a 'working' qemu for SH.

My personal 'complaint' with SH is its lack of maintainer feedback. I do
full arch sweeps on semi-regular basis, and while I know in very board
terms how a fair number of archs work its impossible to know everything
about all 25+ we support.


