From: Simon Horman <horms@verge.net.au>
Date: Thu, 19 Sep 2013 21:28:20 +0000
Subject: Re: [PATCH 0/3] Lager i2c bus support
Message-Id: <20130919212820.GN2918@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1378813194-19493-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1378813194-19493-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 16, 2013 at 03:23:46PM +0200, Ulrich Hecht wrote:
> On Thu, Sep 12, 2013 at 3:51 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:

Apologies for me excessively slow response.

> > What is your preferred way to resolve this? We can choose one of the
> > following:
> >
> > 1. merge the two i2c clock patches into one - feel free to take my code
> > into "ARM: shmobile: r8a7790: add the I2C bus clock" from this series
> >
> > 2. port one of the patches on top of the other one - if this series isn't
> > going to be modified again, I can port my patch on top of it.
> 
> Since my DU stuff will have to be ported to DT anyway and I have found
> that my work towards that on the rcar-i2c driver is virtually
> identical to what Guennadi has already posted, I'd suggest to go with
> his version.

That sounds like a good resolution to me.
