From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 07 Jan 2016 13:37:49 +0000
Subject: Re: [PATCH v2 31/32] sh: support a 2-byte smp_store_mb
Message-Id: <20160107133749.GY6344@twins.programming.kicks-ass.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-32-git-send-email-mst@redhat.com>
 <20160105232735.GC238@brightrain.aerifal.cx>
 <20160106131321-mutt-send-email-mst@redhat.com>
 <20160106114023.GU6344@twins.programming.kicks-ass.net>
 <20160106134301-mutt-send-email-mst@redhat.com>
 <20160106143218.GV6344@twins.programming.kicks-ass.net>
 <20160106182349.GD238@brightrain.aerifal.cx>
 <20160106222019-mutt-send-email-mst@redhat.com>
 <20160106235301.GA23060@brightrain.aerifal.cx>
In-Reply-To: <20160106235301.GA23060@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Landley <rob@landley.net>, Jeff Dionne <jeff@uclinux.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Wed, Jan 06, 2016 at 06:53:01PM -0500, Rich Felker wrote:
> It would be nice to have these in asm-generic for archs which don't
> define their own versions rather than having cruft like this repeated
> per-arch. 

Maybe, but I'm not sure how many archs would indeed suffer this problem,
so far I'm only aware of Alpha and SH that do not have short atomic ops.

> Strictly speaking, the volatile u32 used to access the
> 32-bit word containing the u8 or u16 should be
> __attribute__((__may_alias__)) too. Is there an existing kernel type
> for a "may_alias u32" or should it perhaps be added?

The kernel does -fno-strict-aliasing because the C aliasing rules are
crap (TM) :-), so I suspect we do not need the alias attribute here.
