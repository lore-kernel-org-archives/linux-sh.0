From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Sep 2010 22:01:52 +0000
Subject: Re: [bug-patch] Re: [BUG?] rename patch accepted with --dry-run,
Message-Id: <20100904220152.GB20444@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <201009042333.51419.agruen@suse.de> <20100904214527.GA20444@n2100.arm.linux.org.uk> <201009042346.11787.agruen@suse.de>
In-Reply-To: <201009042346.11787.agruen@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Gruenbacher <agruen@suse.de>
Cc: bug-patch@gnu.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org

On Sat, Sep 04, 2010 at 11:46:11PM +0200, Andreas Gruenbacher wrote:
> On Saturday 04 September 2010 23:45:27 Russell King - ARM Linux wrote:
> > It also makes them incompatible with GNU patch, whether or not GNU patch
> > understands the GIT headers.
> 
> Aha?  Then why do you think GNU patch tries to understand the GIt patch 
> headers?  So that it can be incompatible with GIT?

Read what you said last time around.  "In this case, the patch itself is
broken."

So, because GNU patch doesn't understand the patch file, the patch file
must be broken?  No, the patch file is fine with GIT which can apply it
correctly, but incompatible with GNU patch because of the way GNU patch
works (as you yourself said, GNU patch doesn't keep the intermediate
states.)

I repeat - if you want maximum compatibility, want GNU patch to be able
to apply the patch with or without --dry-run, then don't use -C or -M
when generating patches with git.

Simples.
