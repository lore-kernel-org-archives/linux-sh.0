From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Oct 2010 13:41:31 +0000
Subject: Re: [PATCH 4/7] ARM: oprofile: Move non-ARM code into separate init/exit
Message-Id: <20101006134130.GB29273@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1286222593.git.matt@console-pimps.org> <74092b0d162aafc21e408033cec6146e227363b5.1286222593.git.matt@console-pimps.org> <20101006133309.GP13563@erda.amd.com>
In-Reply-To: <20101006133309.GP13563@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Richter <robert.richter@amd.com>
Cc: Matt Fleming <matt@console-pimps.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Grant Likely <grant.likely@secretlab.ca>

On Wed, Oct 06, 2010 at 03:33:09PM +0200, Robert Richter wrote:
> On 04.10.10 16:44:22, Matt Fleming wrote:
> > @@ -388,7 +387,14 @@ out:
> >  	return ret;
> >  }
> >  
> > -void __exit oprofile_arch_exit(void)
> > +int __init oprofile_arch_init(struct oprofile_operations *ops)
> > +{
> 
> We should do here a:
> 
> 	memset(ops, 0, sizeof(*ops));
> 
> Otherwise it looks good.
> 
What kind of crap interface is oprofile peddling, seriously?

You expect every single architecture to clear this structure that gets
passed in from the oprofile code without having any idea if there are
defaults assigned or not, instead of just having the oprofile code clear
it out before passing it along?
