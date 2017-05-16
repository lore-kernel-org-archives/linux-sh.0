From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Tue, 16 May 2017 07:01:56 +0000
Subject: Re: [PATCH 0/5] Convert more books to ReST
Message-Id: <20170516090156.47d55338@bbrezillon>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1494672881.git.mchehab@s-opensource.com>
 <20170515140912.100c9cac@bbrezillon>
 <20170515111519.7bbb449b@lwn.net>
In-Reply-To: <20170515111519.7bbb449b@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Herton
 R. Krzesinski" <herton@redhat.com>, linux-mtd@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>, Markus Heiser <markus.heiser@darmarit.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Marek Vasut <marek.vasut@gmail.com>, sayli karnik <karniksayli1995@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, Silvio Fricke <silvio.fricke@gmail.com>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>

Hi Jonathan,

On Mon, 15 May 2017 11:15:19 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> On Mon, 15 May 2017 14:09:12 +0200
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> 
> > >   mtd: adjust kernel-docs to avoid Sphinx/kerneldoc warnings    
> > 
> > Not sure how you plan to merge these changes, but if it goes through
> > a single tree I'll probably need an immutable topic branch, because I
> > plan to change a few things in nand_base.c nand.h for the next release.  
> 
> docs-next doesn't rebase, so there shouldn't be trouble there.  But we
> could also just separate this patch into two pieces.  I suspect we could
> live with a couple of warnings for a period during the 4.13 merge window
> without too much pain...

I like this idea. This way I can take the nand_base.c/nand.h changes
through my tree and let you pick the Doc migration bits.

Thanks,

Boris
