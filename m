From: Simon Horman <horms@verge.net.au>
Date: Fri, 08 Jan 2016 06:56:46 +0000
Subject: Re: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <20160108065642.GA1215@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx>
 <20160108044054.GA7130@brightrain.aerifal.cx>
In-Reply-To: <20160108044054.GA7130@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uClinux.org>, Rob Landley <rob@landley.net>

On Thu, Jan 07, 2016 at 11:40:54PM -0500, Rich Felker wrote:
> From: Rich Felker <dalias@libc.org>
> 
> Recently the bulk of traffic on the linux-sh list has been unrelated
> to arch/sh but instead focused on Renesas hardware for their ARM-based
> SoCs. As part of resuming maintenance of arch/sh, remove the linux-sh
> list from the MAINTAINERS file sections for these other components so
> that new arch/sh development is not drowned out by unrelated
> cross-postings.

The use of the linux-sh mailing list has evolved somewhat over time,
from SH related to ARM related. Its name (obviously) has not evolved.

Dropping linux-sh@vger.kernel.org from portions of the MAINTAINERS file as
you suggest would essentially leave the Renesas ARM work without a mailing
list or patchwork instance. Both of which are actively used for that work.

Off-hand I can think of three solutions to this problem:

1. Live with the noise
2. Establish a new list (and possibly patchwork instance) for the SH work.
3. Establish a new list and patchwork instance for the ARM work.
