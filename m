From: Simon Horman <horms@verge.net.au>
Date: Tue, 30 Jul 2013 05:29:22 +0000
Subject: Re: [PATCH 4/6 v2] ARM: shmobile: r8a7778: cleanup registration of i2c
Message-Id: <20130730052921.GA27074@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <871u6ldb9z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871u6ldb9z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 29, 2013 at 09:54:48PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > This is the back-ground.
> > > Is it enough for you ?
> > 
> > Yes thanks, that is enough.
> 
> Thank you
> 
> > > Please let me know if you need more explain/background
> > 
> > I do have one more question, which I forgot to ask earlier.
> > 
> > I notice that you are now registering i2c devices in
> > r8a7778_add_dt_devices(). Which I believe means that they
> > will be registered in C when bockw-reference is used.
> > Is that intentional?
> 
> Oops, it is my mistake.
> I2C should not be called from C when bockw-reference.
> Can I send v2 patch ?

Please do.

Could you also re-post 5/6 at the same time?
No changes are required.
