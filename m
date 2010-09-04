From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Sat, 04 Sep 2010 03:21:17 +0000
Subject: Re: [bug-patch] [BUG?] rename patch accepted with --dry-run,
Message-Id: <20100904032117.GL17702@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
 <20100903182323.GA17152@pengutronix.de>
 <20100903184351.GC2341@burratino>
 <201009040058.18028.agruen@suse.de>
In-Reply-To: <201009040058.18028.agruen@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Jonathan Nieder <jrnieder@gmail.com>, bug-patch@gnu.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, git@vger.kernel.org

> 
> So "git apply" and "patch --dry-run" seem to work only by accident.
> 
> How was this patch generated: with git itself?
I did as usual
git format-patch -M -B -C HEAD~
> 
> The fact that "patch --dry-run" may not work for patches that modify the same 
> file twice is a known defect.  I don't know how to solve this in a reasonably 
> elegant way.  Luckily the problem only triggers when people are doing 
> something "strange" such as concatenating patches.

Best Regards,
J.
