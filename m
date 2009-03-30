From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 30 Mar 2009 23:24:06 +0000
Subject: Re: sh-2.6.git fails to compile with gcc-4.3 (warnings treated as errors)
Message-Id: <20090330232406.GI19535@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49CBC30E.9020901@gentoo.org>
In-Reply-To: <49CBC30E.9020901@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 26, 2009 at 02:16:22PM -0400, Mike Frysinger wrote:
> On Thursday 26 March 2009 14:01:50 Ra?l Porcel wrote:
> > cc1: warnings being treated as errors
> > arch/sh/kernel/setup.c: In function 'early_parse_mem':
> > arch/sh/kernel/setup.c:111: error: format not a string literal and no
> > format arguments
> >
> > I just used the default sh7785lcr_defconfig .
> >
> > Paul said its easy to fix, so feel free to submit a patch.
> 
> a different patch has been posted but apparently not merged yet.
> http://lkml.org/lkml/2009/2/4/259
> -mike

And probably not going to be merged without a nudge. I've just fixed up
the offending printk() for now instead.
