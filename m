From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Apr 2012 06:19:38 +0000
Subject: Re: [PATCH 6/6] ARM: mach-shmobile: kzm9g: add PCF8757 gpio-key
Message-Id: <20120425061937.GA19454@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8762d63oni.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8762d63oni.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 24, 2012 at 05:11:05PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > I am having a little trouble getting this working on top of 3.4-rc4
> > with your "[PATCH 0/6] ARM: mach-shmobile: add KZM-A9-GT board support"
> > series and the rest of this series.
> > 
> > I have enabled INPUT_PCF8574, but perhaps that isn't sufficient?
> 
> Thank you for testing this.
> But sorry, I didn't explain about it.
> 
> please enable GPIO_PCF857X, not INPUT_PCF8574
> 
> O  GPIO_PCF857X
> X  INPUT_PCF8574
> 
> and enable KEYBOARD_GPIO_POLLED too

Thanks, I have it working now.

Do you think it is worth updating the default config?
