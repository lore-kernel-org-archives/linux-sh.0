From: Simon Horman <horms@verge.net.au>
Date: Wed, 26 Mar 2014 17:04:03 +0000
Subject: Re: [PATCH] ARM: shmobile: Include at24.c in shmobile_defconfig
Message-Id: <20140326170403.GC1091@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140326051911.2461.88848.sendpatchset@w520>
In-Reply-To: <20140326051911.2461.88848.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 26, 2014 at 08:04:01AM +0100, Wolfram Sang wrote:
> On Wed, Mar 26, 2014 at 02:19:11PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > The Koelsch board includes an at24-compatible EEPROM hooked up via I2C.
> > To increase hardware support enable the driver in the shmobile_defconfig
> > multiplatform configuration.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> I would have squashed those two patches, but still:
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Thanks, I have queued this up.

