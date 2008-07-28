From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jul 2008 21:24:28 +0000
Subject: Re: drivers/sh/maple/maple.c compile error
Message-Id: <20080728212428.GA28055@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080728202012.GD7713@cs181140183.pp.htv.fi> <20080728204438.GC20019@linux-sh.org> <1217278308.6875.3.camel@localhost.localdomain> <20080728210121.GA27971@linux-sh.org> <1217279595.6875.11.camel@localhost.localdomain>
In-Reply-To: <1217279595.6875.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Adrian Bunk <bunk@kernel.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 28, 2008 at 10:13:15PM +0100, Adrian McMenamin wrote:
> On Tue, 2008-07-29 at 06:01 +0900, Paul Mundt wrote:
> > On Mon, Jul 28, 2008 at 09:51:48PM +0100, Adrian McMenamin wrote:
> > This seems to point to a serious problem in your working environment, as
> > you are neither able to view commits that are referenced or realize there
> > is a problem when patches fail to apply anywhere outside of your home
> > directory.
> 
> I searched in Linus's tree on kernel.org after I couldn't find it in
> mine. I can see the commit (???306cfd630a4d121cf4e08b894d8b4c4cf106e57e)
> referred to in both trees but it doesn't include any changes to the
> maple stuff.
> 
What do you think it contains? This isn't exactly difficult:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h06cfd630a4d121cf4e08b894d8b4c4cf106e57e;hpLec1a37ba7d9dce6ed5d8259b95272100a98b1f

Surprise, your header patch.

> > The problem is that the change you made to maple.c is incomplete, it
> > basically should have followed 2 other patches, one removing the logic
> > entirely from maple.c, and one removing it from the input driver, before
> > killing off the function pointers completely.  You were asked to fix up
> > and resend the input patch (which seems not to have happened due to a
> > problem in your work environment), but I'm unable to find anything
> > bordering on a maple patch that actually cleans up
> > attach_matching_maple_driver() and maple_detach_driver()
> > connect/disconnect references?
> > 
> 
> http://lkml.org/lkml/2008/6/15/121 - removes the references from
> keyboard
> http://lkml.org/lkml/2008/6/15/122 - removes the references from the
> headers
> 
And what about the changes required to maple.c? Did you even bother
reading what I was talking about in that paragraph? Or even bother
looking at the build failure? Your changes are _incomplete_, even if I
had fixed up and merged the input driver changes (which you weren't able
to see as being a problem, despite the fact the underlying code being
patch had changed completely). Until you can figure this out and get your
environment resembling something sane, please stop sending me any email
or patches, thanks.
