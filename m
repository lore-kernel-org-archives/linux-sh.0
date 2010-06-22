From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 22 Jun 2010 12:05:51 +0000
Subject: Re: [PATCH] kmemleak: config-options: Default buffer size for
Message-Id: <1277208351.29532.5.camel@e102109-lin.cambridge.arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTimb7rP0rS0OU8nan5uNEhHx_kEYL99ImZ3c8o0D@mail.gmail.com>
	 <1277189909-16376-1-git-send-email-sankar.curiosity@gmail.com>
	 <4C20702C.1080405@cs.helsinki.fi>
	 <1277196403-20836-1-git-send-email-sankar.curiosity@gmail.com>
	 <20100622113135.GB20140@linux-sh.org>
In-Reply-To: <20100622113135.GB20140@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Sankar P <sankar.curiosity@gmail.com>, penberg@cs.helsinki.fi, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, lrodriguez@atheros.com, rnagarajan@novell.com, teheo@novell.com, linux-mm@kvack.org, paulmck@linux.vnet.ibm.com, mingo@elte.hu, akpm@linux-foundation.org

On Tue, 2010-06-22 at 12:31 +0100, Paul Mundt wrote:
> On Tue, Jun 22, 2010 at 02:16:43PM +0530, Sankar P wrote:
> > If we try to find the memory leaks in kernel that is
> > compiled with 'make defconfig', the default buffer size
> > of DEBUG_KMEMLEAK_EARLY_LOG_SIZE seem to be inadequate.
> >
> > Change the buffer size from 400 to 1000,
> > which is sufficient for most cases.
> >
> Or you could just bump it up in your config where you seem to be hitting
> this problem. The default of 400 is sufficient for most people, so
> bloating it up for a corner case seems a bit premature. Perhaps
> eventually we'll have no choice and have to tolerate the bloat, as we did
> with LOG_BUF_SHIFT, but it's not obvious that we've hit that point with
> kmemleak yet.

I agree. The 400 seems to be sufficient with standard kernel
configurations (I usually try some of the Ubuntu configs on x86). The
error message is hopefully clear enough about what needs to be changed.

The defconfig change for this specific platform may be a better option
but I thought defconfigs are to provide a stable (and maybe close to
optimal) configuration without all the debugging features enabled
(especially those slowing things down considerably).

-- 
Catalin

