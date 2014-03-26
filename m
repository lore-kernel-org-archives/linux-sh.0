From: Simon Horman <horms@verge.net.au>
Date: Wed, 26 Mar 2014 17:02:51 +0000
Subject: Re: [PATCH] ARM: shmobile: Include i2c-shmobile.c in shmobile_defconfig
Message-Id: <20140326170251.GB1091@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140326051619.2454.811.sendpatchset@w520>
In-Reply-To: <20140326051619.2454.811.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 26, 2014 at 08:03:02AM +0100, Wolfram Sang wrote:
> On Wed, Mar 26, 2014 at 02:16:19PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Many SoCs include I2C controller instances compatible with
> > the i2c-shmobile.c driver. To increase hardware support enable
> > the driver in the shmobile_defconfig multiplatform configuration.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Thanks, I have queued this up.
