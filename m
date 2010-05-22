From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 22 May 2010 07:33:33 +0000
Subject: Re: [PATCH 0/3] tmio: let platforms decide upon write-protection availability
Message-Id: <20100522073332.GA17814@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005191815491.3099@axis700.grange> <20100521123827.a8d7a87a.akpm@linux-foundation.org>
In-Reply-To: <20100521123827.a8d7a87a.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org

On Fri, May 21, 2010 at 12:38:27PM -0700, Andrew Morton wrote:
> On Wed, 19 May 2010 20:35:57 +0200 (CEST)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > No changes to patches themselves, just re-sending with an ack added.
> > 
> > Applies on top of the
> > 
> > "[PATCH 0/10] add DMA support to tmio_mmc, using dmaengine API, use it on SH"
> > 
> > patch series.
> > 
> 
> Paul, are you planning on merging the tem patches in the
> above-mentioned series for 2.6.35-rc1?
> 
Yes, they'll be in my next round of updates for -rc1. Since I don't have
much else, I'll send those out today or tomorrow.
