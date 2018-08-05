From: Rob Landley <rob@landley.net>
Date: Sun, 05 Aug 2018 15:54:56 +0000
Subject: Re: [PATCH] sh: remove unneeded constructor.
Message-Id: <4e9e1599-9dbf-75dc-561e-77d5cb063714@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20180731051519.101249-1-ysato@users.sourceforge.jp>
 <CAMuHMdUQReuzR=x54gnC1XdP77RrT1TaWoFFXUhUQ02A+giPqQ@mail.gmail.com>
 <87600us5k9.wl-ysato@users.sourceforge.jp>
 <20180804103550.GA3183@bombadil.infradead.org>
 <CAMuHMdXsz-+zsxouaLP5tTKA46G34iAACSce+RXrD8AiiQc2+A@mail.gmail.com>
 <20180804105149.GB3183@bombadil.infradead.org>
In-Reply-To: <20180804105149.GB3183@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 08/04/2018 05:51 AM, Matthew Wilcox wrote:
> On Sat, Aug 04, 2018 at 12:47:08PM +0200, Geert Uytterhoeven wrote:
>> You do want to readd the __GFP_ZERO flag to the second user of PGALLOC_GFP,
>> don't you?
> 
> I missed that!  Probably only relevant for SH-64.  But yes ... probably better
> to make this explicit then:

As far as I know sh5/sh-64 never shipped, it was just some prototype hardware
that didn't go to production?

(I know the j-core project is taking a different 64 bit approach, much more like
x86-64's mode bit than itanium two completely different instruction sets, but
last I heard they're just now testing the j32 with-mmu bitstreams so it'll be a
while before that's relevant. :)

Rob
