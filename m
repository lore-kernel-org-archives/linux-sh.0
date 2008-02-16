From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sat, 16 Feb 2008 19:59:48 +0000
Subject: Re: Current git very broken on the Dreamcast
Message-Id: <1203191988.6737.11.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1203187080.6737.3.camel@localhost.localdomain>
	 <1203191304.6737.5.camel@localhost.localdomain>
In-Reply-To: <1203191304.6737.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Paul Mundt <lethal@users.sourceforge.net>, Magnus Damm <magnus.damm@gmail.com>, matsu@igel.co.jp, LKML <linux-kernel@vger.kernel.org>


On Sat, 2008-02-16 at 19:48 +0000, Adrian McMenamin wrote:
> On Sat, 2008-02-16 at 18:38 +0000, Adrian McMenamin wrote:
> > Will seek to bisect this, but I have just updated my sources to the
> > latest git and it is not booting at all on the Dreamcast.
> > 

> adrian@bossclass:~/gdrom-dev$ git bisect good
> e036eaa681a17f71b64f6d9040fe605555623919 is first bad commit
> commit e036eaa681a17f71b64f6d9040fe605555623919
> Author: Magnus Damm <magnus.damm@gmail.com>
> Date:   Thu Feb 14 13:52:43 2008 +0900
> 

Reverting this commit *will* let my Dreamcast boot - can it be rolled
back pending further testing for a patch please?

Adrian

