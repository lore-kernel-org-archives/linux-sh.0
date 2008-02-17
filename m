From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Sun, 17 Feb 2008 19:55:37 +0000
Subject: Re: Current git very broken on the Dreamcast
Message-Id: <20080217205537.db59a1f3.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1203187080.6737.3.camel@localhost.localdomain>
	<1203191304.6737.5.camel@localhost.localdomain>
	<1203191988.6737.11.camel@localhost.localdomain>
In-Reply-To: <1203191988.6737.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: linux-sh@vger.kernel.org, Paul Mundt <lethal@users.sourceforge.net>, Magnus Damm <magnus.damm@gmail.com>, matsu@igel.co.jp, LKML <linux-kernel@vger.kernel.org>

On Sat, 16 Feb 2008 19:59:48 +0000
Adrian McMenamin <adrian@newgolddream.dyndns.info> wrote:

> 
> On Sat, 2008-02-16 at 19:48 +0000, Adrian McMenamin wrote:
> > On Sat, 2008-02-16 at 18:38 +0000, Adrian McMenamin wrote:
> > > Will seek to bisect this, but I have just updated my sources to the
> > > latest git and it is not booting at all on the Dreamcast.
> > > 
> 
> > adrian@bossclass:~/gdrom-dev$ git bisect good
> > e036eaa681a17f71b64f6d9040fe605555623919 is first bad commit
> > commit e036eaa681a17f71b64f6d9040fe605555623919
> > Author: Magnus Damm <magnus.damm@gmail.com>
> > Date:   Thu Feb 14 13:52:43 2008 +0900
> > 
> 
> Reverting this commit *will* let my Dreamcast boot - can it be rolled
> back pending further testing for a patch please?
> 

Just had a look at the patch. If that patch made your dreamcast not boot then you had somekind of
io_base that was used in in/out. Perhaps its better to adjust your PORT defines than work around the issue?

> Adrian
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
