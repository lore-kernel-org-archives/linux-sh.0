From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Jul 2012 01:22:34 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Add compilation support for dtbs using 'make dtbs'
Message-Id: <20120724012234.GL22631@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1343033857-9053-1-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1343033857-9053-1-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 24, 2012 at 10:20:28AM +0900, Simon Horman wrote:
> On Mon, Jul 23, 2012 at 05:57:37PM +0900, Tetsuyuki Kobayshi wrote:
> > From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> > 
> > Add compilation support for dtbs using 'make dtbs'
> 
> I see the following with this patch applied to the next branch
> of Rafael's renesas tree.
> 
> # make armadillo800eva_defconfig
> # make dtb
> make[1]: *** No rule to make target `arch/arm/boot/r8a7740-armadillo800eva.dts', needed by `arch/arm/boot/dtbs'.  Stop.
> make: *** [dtbs] Error 2

Sorry, I now see that you have posted v2 which fixes the problem above.
