From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 22 Jan 2016 21:08:52 +0000
Subject: Re: [PATCH] MAINTAINERS: return arch/sh to maintained state, with new maintainers
Message-Id: <20160122130852.1c9153fe74546f6e391f8d97@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20160122052614.GA21960@brightrain.aerifal.cx>
In-Reply-To: <20160122052614.GA21960@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, "D. Jeff Dionne" <jeff@uClinux.org>, Rob Landley <rob@landley.net>, Peter Zijlstra <peterz@infradead.org>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 22 Jan 2016 00:26:15 -0500 Rich Felker <dalias@libc.org> wrote:

> From: Rich Felker <dalias@libc.org>
> 
> Add Yoshinori Sato and Rich Felker as maintainers for arch/sh
> (SUPERH).
> 
> Signed-off-by: Rich Felker <dalias@libc.org>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Acked-by: D. Jeff Dionne <jeff@uClinux.org>
> Acked-by: Rob Landley <rob@landley.net>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> ---
> 
> Andrew, since we don't have our own repo up for Linus to pull from
> yet, could you commit this? Geert (who's the closest there is to an
> acting maintainer for sh right now) and I thought that would make the
> most sense. If possible I'd really like to get this in the merge
> window to make it official that sh isn't abandoned.

No probs.  I'll cc:stable as well, so you get bug reports for older
kernel versions :)

