From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 Oct 2014 09:01:07 +0000
Subject: Re: [PATCH 07/12] ARM: shmobile: koelsch: fixup overkill I2C2 clock frequency
Message-Id: <20141031090105.GF23848@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87r3xo1xak.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87r3xo1xak.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 31, 2014 at 01:44:35AM -0700, Kuninori Morimoto wrote:
> 
> Hi Wolfram, Simon
> 
> > > Current Koelsch I2C2 has 400kHz settings,
> > > but, ak4643 audio codec chip which is connected to I2C2 can't
> > > work such frequency.
> > > Fixup I2C2 clock frequency.
> > 
> > Basically OK, but we should better explicitly set it to 100000 and not
> > rely on a default coming from somewhere.
> 
> OK.
> 
> Simon
> Lager board is expecting that I2C is working with 100000 too.
> Can you accept this patch as-is ? if so, I will send 
> additional clock frequency 100000 setting patch for both lager/koelsch.
> If not, I will send v2 of this patch-set + lager clock frequency patch.

Could send a small patchset that only fixes up all the clock frequency
problems? That would be easiest for me.
