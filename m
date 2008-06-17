From: Adrian Bunk <bunk@kernel.org>
Date: Tue, 17 Jun 2008 08:42:35 +0000
Subject: architectures with ARCH_SUPPORTS_AOUT but no binfmt_aout
Message-Id: <20080617084235.GA20169@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
References: <1213565555.26255.522.camel@pmac.infradead.org> <1213604973-7073-1-git-send-email-jacmet@sunsite.dk> <1213617663.26255.708.camel@pmac.infradead.org> <20080616121727.GB10854@cs181133002.pp.htv.fi> <1213619214.26255.721.camel@pmac.infradead.org>
In-Reply-To: <1213619214.26255.721.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-kernel@vger.kernel.org, sam@ravnborg.org, dhowells@redhat.com, andi@firstfloor.org, "Kirill A. Shutemov" <k.shutemov@gmail.com>, ysato@users.sourceforge.jp, takata@linux-m32r.org, linux-m32r@ml.linux-m32r.org, kyle@mcmartin.ca, matthew@wil.cx, grundler@parisc-linux.org, linux-parisc@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Mon, Jun 16, 2008 at 01:26:54PM +0100, David Woodhouse wrote:
>...
> Actually, I think we can drop the preceding patch too -- it's not
> necessary to fix the regression in 2.6.26, and dhowells suggests that we
> might still want to use ARCH_SUPPORTS_AOUT, by making BINFMT_AOUT depend
> on it instead of that hard-coded list of architectures.
> 
> If we do that, then ARCH_SUPPORTS_AOUT would need to be defined on a
> different set of architectures to the ones it's currently defined on --
> so I don't really want to go there before 2.6.26. I'll push just the
> parts which were included in the mail I just sent.
> 
> Why _are_ there architectures which define ARCH_SUPPORTS_AOUT and have
> <asm/a.out.h> but don't support binfmt_aout, anyway? How does that make
> sense?

My guess would be that binfmt_aout isn't actually used there.

The affected architectures are:
- h8300
- m32r
- parisc
- sh
- v850

v850 is broken beyond repair, and I hope my patch to remove the 
architecture will make it into 2.6.27.

For the other 4 architectures I have Cc'ed the architecture maintainers.

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

