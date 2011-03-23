From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 23 Mar 2011 13:25:26 +0000
Subject: Re: [PATCH] sh: Fix ptrace hw_breakpoint handling
Message-Id: <20110323132526.GB17693@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4D89DB0E.5030508@sysgo.com>
In-Reply-To: <4D89DB0E.5030508@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 23, 2011 at 12:35:42PM +0100, David Engraf wrote:
> sh: Fix ptrace hw_breakpoint handling.
> 
> Since commit 34d0b5af50a063cded842716633501b38ff815fb it is no longer 
> possible to debug an application using singlestep. The old commit 
> converted singlestep handling via ptrace to hw_breakpoints. The 
> hw_breakpoint is disabled when an event is triggered and not re-enabled 
> again. This patch re-enables the existing hw_breakpoint before the 
> existing breakpoint is reused.
> 
> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> 
Applied, thanks.
