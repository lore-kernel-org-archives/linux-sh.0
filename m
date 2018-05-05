From: Rich Felker <dalias@libc.org>
Date: Sat, 05 May 2018 20:45:13 +0000
Subject: Re: [PATCH v3] sh: mm: Fix unprotected access to struct device
Message-Id: <20180505204513.GF1392@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <1524044555-20610-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180502074600.GC27261@w540>
 <20180502123909.GA9546@infradead.org>
 <20180503071539.GA19612@w540>
In-Reply-To: <20180503071539.GA19612@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jacopo mondi <jacopo@jmondi.org>
Cc: Christoph Hellwig <hch@infradead.org>, ysato@users.sourceforge.jp, thomas.petazzoni@free-electrons.com, robin.murphy@arm.com, geert@linux-m68k.org, sergei.shtylyov@cogentembedded.com, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 09:15:39AM +0200, jacopo mondi wrote:
> Hi Christoph,
> 
> On Wed, May 02, 2018 at 05:39:09AM -0700, Christoph Hellwig wrote:
> > On Wed, May 02, 2018 at 09:46:31AM +0200, jacopo mondi wrote:
> > > Hi again Christoph,
> > >
> > >     The gentle ping actually applies to this version of the patch.
> > >
> > > Sorry for the confusion.
> >
> > I'd expect this to go in through the sh tree, but if the sh maintainers
> > are fine with it I can take it through the dma-mapping tree.
> 
> Oh, that's fine then. I'll let Rich comment if he plans to send a pull
> requets for v4.17 fixes or not.

OK, I'll prepare a pull request with this and another fix I just made.

Rich
