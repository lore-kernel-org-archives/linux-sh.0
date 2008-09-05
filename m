From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 05 Sep 2008 08:48:45 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <20080905084845.GB4002@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 05, 2008 at 10:14:43AM +0200, Luca Santini wrote:
> p.s.: a little question git-related... (i'm moving my first steps with 
> git..) :
> 
> if i pull from
> 
> 	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git
> 
> it asks for a password.... ???
> 
> currently, i pull from
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git
> 
> is it the same?
> 
The first one is for people who have SSH accounts on kernel.org, and is
usually what I include in my pull requests to Linus. This is due to the
fact that the git:// data used to lag behind a bit, so if I pushed the
updates wouldn't be immediately visible through anonymous access.

The time gap between updates between the two these days has mostly been
fixed, and indeed, Linus rewrites the pull requests to go through git://
these days anyways, I've just been too lazy to update my scripts.

In any event, you should always use the git:// URLs.
