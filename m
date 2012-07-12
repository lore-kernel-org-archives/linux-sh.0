From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 12 Jul 2012 04:15:57 +0000
Subject: Re: [PATCH] SH: Convert out[bwl] macros to inline functions
Message-Id: <20120712041556.GB16064@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1341866120-18640-1-git-send-email-minyard@acm.org>
In-Reply-To: <1341866120-18640-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: minyard@acm.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

On Mon, Jul 09, 2012 at 03:35:20PM -0500, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> The macros just called BUG(), but that results in unused variable
> warnings all over the place, like in the IPMI driver.  The build
> regression emails were annoying me, so here's the fix.  I have
> not even compile tested this, but it's rather obvious.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Builds fine, I've switched the port type to unsigned long, but it looks
good otherwise. Will queue it up for -rc7, thanks.
