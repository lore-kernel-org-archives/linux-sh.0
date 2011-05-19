From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 19 May 2011 13:07:24 +0000
Subject: Re: [PATCH] PM: Remove CONFIG_PM_VERBOSE
Message-Id: <20110519130723.GB4996@elf.ucw.cz>
List-Id: <linux-sh.vger.kernel.org>
References: <201105140042.04064.rjw@sisk.pl>
 <201105162032.33480.rjw@sisk.pl>
In-Reply-To: <201105162032.33480.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org

On Mon 2011-05-16 20:32:33, Rafael J. Wysocki wrote:
> On Saturday, May 14, 2011, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Now that we have CONFIG_DYNAMIC_DEBUG there is no need for yet
> > another flag causing dev_dbg() and pr_debug() statements in the
> > core PM code to produce output.  Moreover, CONFIG_PM_VERBOSE
> > causes so much output to be generated that it's not really useful
> > and almost no one sets it.
> > 
> > References: https://bugzilla.kernel.org/show_bug.cgi?id#182
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK

> There are no comments, so my understanding is that no one has any objections to
> this patch.  If that really is the case, I'm going to put it into
> suspend-2.6/linux-next for 2.6.40.

And sorry for slow responses.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
