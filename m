From: Simon Horman <horms@verge.net.au>
Date: Wed, 11 Apr 2012 00:24:26 +0000
Subject: Re: [PATCH 0/7 v2] ARM: mach-shmobile: add Armadillo800eva board support
Message-Id: <20120411002423.GD5366@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 10, 2012 at 01:27:56AM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> Thank you for checking patch
> 
> > unfortunately I seem to be having a lot of trouble reliably booting using
> > these patches. I am using tftpboot as follows:
> > 
> > hermit>  tftpboot 10.3.3.147 10.3.3.135 --kernel=armadillo/uImage
> 
> I'm using Image file here, not uImage.

Ok, its my turn to make you sigh.

Its now working using a zImage.
