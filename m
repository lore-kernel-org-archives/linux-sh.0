From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Sun, 17 Feb 2008 19:40:53 +0000
Subject: Re: Current git very broken on the Dreamcast
Message-Id: <20080217204053.f2f28eef.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1203187080.6737.3.camel@localhost.localdomain>
In-Reply-To: <1203187080.6737.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sat, 16 Feb 2008 18:38:00 +0000
Adrian McMenamin <adrian@newgolddream.dyndns.info> wrote:

> Will seek to bisect this, but I have just updated my sources to the
> latest git and it is not booting at all on the Dreamcast.
> 
> With early printk on, I get nothing more than this before an instant
> reboot:

I haven't tested anything after 2.6.24 vanilla which works fine. A bisect sounds like a good idea since you
got pretty much zero clues.

> 
> [    0.000000] Linux version 2.6.25-rc2-10953-g52065cd
> (adrian@bossclass) (gcc version 3.4.6) #511 PREEMPT Sat Feb 16 18:31:43
> GMT 2008
> [    0.000000] console [sercon0] enabled
> [    0.000000] Booting machvec: Sega Dreamcast
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
