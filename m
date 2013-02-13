From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 11:15:05 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: streamline mackerel SD and MMC devices
Message-Id: <20130213111505.GF22623@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360689333-13525-4-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360689333-13525-4-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 13, 2013 at 04:56:44PM +0900, Simon Horman wrote:
> On Tue, Feb 12, 2013 at 06:15:33PM +0100, Guennadi Liakhovetski wrote:
> > This patch fixes the following issues with SD and MMC interfaces on mackerel:
> > 1. replace custom card-detection functions with standard GPIO CD API
> > 2. resources don't have to be numbered
> > 3. add SDHI interrupt names
> > 4. remove OCR masks, where regulators are used
> > 5. only specify SDHI CD interrupts on interfaces where a CD pin is present -
> >    SDHI0
> > 6. don't instantiate an MMCIF device and initialise MMCIF pins if SDHI1 is
> >    selected
> 
> With this patch applied on top of next I see the following:
> 
> mmc2: host doesn't support card's voltages
> mmc2: error -22 whilst initialising MMC card
> mmc2: host doesn't support card's voltages
> mmc2: error -22 whilst initialising MMC card
> mmc2: host doesn't support card's voltages
> mmc2: error -22 whilst initialising MMC card
> mmc2: host doesn't support card's voltages
> mmc2: error -22 whilst initialising MMC card
> mmc2: host doesn't support card's voltages
> mmc2: error -22 whilst initialising MMC card
> mmc2: host doesn't support card's voltages
> 
> Am I missing some dependencies?
> 
> (I know you send me a bunch of patches off-list,
>  but I'd appreciate not having to hunt through them individually
>  to answer this question)

Please ignore that, I think I have things working now.
