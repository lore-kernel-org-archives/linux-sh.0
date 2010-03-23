From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 23 Mar 2010 07:45:46 +0000
Subject: Re: [PATCH 2/4] panic: Allow taint flag for warnings to be changed from TAINT_WARN
Message-Id: <20100323074546.GK13417@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1269126097.18314.111.camel@localhost> <1269126340.18314.115.camel@localhost>
In-Reply-To: <1269126340.18314.115.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, David Woodhouse <dwmw2@infradead.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-parisc@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org

On Sat, Mar 20, 2010 at 11:05:40PM +0000, Ben Hutchings wrote:
> WARN() is used in some places to report firmware or hardware bugs that
> are then worked-around.  These bugs do not affect the stability of the
> kernel and should not set the usual TAINT_WARN flag.  To allow for
> this, add WARN_TAINT() and WARN_TAINT_ONCE() macros that take a taint
> flag as argument.
> 
> Architectures that implement warnings using trap instructions instead
> of calls to warn_slowpath_*() must now implement __WARN_TAINT(taint)
> instead of __WARN().
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> The architecture-specific changes here are untested and need to be
> reviewed by architecture maintainers.
> 
I'm a bit confused about how this is supposed to work, the TAINT_xxx
values are bit positions presently from 0 to 10, while BUGFLAG_xxx are
ranged from 0 up. You've set up BUGFLAG_TAINT() to that the TAINT_xxx
value is shifted up 8 bits but neglected the fact that the trap type is
16-bits on most (all?) of the platforms using trap-based BUG handling.

If the 'taint' in question is just the TAINT_xxx value by itself and will
never be a bitmap then that's fine, but there's certainly not enough room
to pass the bitmap in on top of the bugflag otherwise (I don't know if
this is your intention or not though).

Also note that some platforms (like SH) implement additional bugflags, so
we at least want to keep the lower byte available for architecture
private use.

Having said that, the current patch does work for me, although I'm a bit
nervous about someone thinking it's ok to pass in a taint bitmap here.

Tested-by: Paul Mundt <lethal@linux-sh.org>
