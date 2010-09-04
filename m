From: Andreas Gruenbacher <agruen@suse.de>
Date: Sat, 04 Sep 2010 21:57:34 +0000
Subject: Re: [bug-patch] [BUG?] rename patch accepted with --dry-run, rejected without (Re: [PATCH V3] arm &
Message-Id: <201009042357.34237.agruen@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <201009040058.18028.agruen@suse.de> <20100903233252.GD30310@burratino>
In-Reply-To: <20100903233252.GD30310@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: bug-patch@gnu.org, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, git@vger.kernel.org

On Saturday 04 September 2010 01:32:52 Jonathan Nieder wrote:
> Andreas Gruenbacher wrote:
> 
> > something pretty bizarre is going on here.  The wget output modifies the same 
> > file twice, but both patches to this file have the same source sha1 (5645f35):
> 
> From the git v1.6.0-rc0~92 changelog entry:
> 
>     apply: fix copy/rename breakage
>     
>     7ebd52a (Merge branch 'dz/apply-again', 2008-07-01) taught "git-apply" to
>     grok a (non-git) patch that is a concatenation of separate patches that
>     touch the same file number of times, by recording the postimage of patch
>     application of previous round and using it as the preimage for later
>     rounds.
>     
>     This "incremental" mode of patch application fundamentally contradicts
>     with the way git rename/copy patches are designed.  When a git patch talks
>     about a file A getting modified, and a new file B created out of A, like
>     this:
>     
>         diff --git a/A b/A
>         --- a/A
>         +++ b/A
>         ... change text here ...
>         diff --git a/A b/B
>         copy from A
>         copy to B
>         --- a/A
>         +++ b/B
>         ... change text here ...
>     
>     the second change to produce B does not depend on what is done to A with
>     the first change in any way.  This is explicitly done so for reviewability
>     of individual patches.
>     
>     With this commit, we do not look at 'fn_table' that records the postimage
>     of previous round when applying a patch to produce a new file out of an
>     existing file.

Ouch ... this gets really messy when a user concatenates git style patches
and they are not applied to exactly the same source tree.

Thanks for digging out this commit message!

Andreas
