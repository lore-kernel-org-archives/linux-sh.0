From: Matthew Wilcox <matthew@wil.cx>
Date: Tue, 17 Jun 2008 11:28:36 +0000
Subject: Re: architectures with ARCH_SUPPORTS_AOUT but no binfmt_aout
Message-Id: <20080617112835.GB4392@parisc-linux.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1213565555.26255.522.camel@pmac.infradead.org> <1213604973-7073-1-git-send-email-jacmet@sunsite.dk> <1213617663.26255.708.camel@pmac.infradead.org> <20080616121727.GB10854@cs181133002.pp.htv.fi> <1213619214.26255.721.camel@pmac.infradead.org> <20080617084235.GA20169@cs181133002.pp.htv.fi>
In-Reply-To: <20080617084235.GA20169@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Peter Korsgaard <jacmet@sunsite.dk>, linux-kernel@vger.kernel.org, sam@ravnborg.org, dhowells@redhat.com, andi@firstfloor.org, "Kirill A. Shutemov" <k.shutemov@gmail.com>, ysato@users.sourceforge.jp, takata@linux-m32r.org, linux-m32r@ml.linux-m32r.org, kyle@mcmartin.ca, grundler@parisc-linux.org, linux-parisc@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Tue, Jun 17, 2008 at 11:42:35AM +0300, Adrian Bunk wrote:
> On Mon, Jun 16, 2008 at 01:26:54PM +0100, David Woodhouse wrote:
> > Why _are_ there architectures which define ARCH_SUPPORTS_AOUT and have
> > <asm/a.out.h> but don't support binfmt_aout, anyway? How does that make
> > sense?
> 
> My guess would be that binfmt_aout isn't actually used there.

It was probably copied from MIPS in the early days of the parisc port
and nobody ever b othered to look at it before.  There was never an
a.out format for parisc.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
