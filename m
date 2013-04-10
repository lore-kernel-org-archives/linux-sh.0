From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Apr 2013 02:15:34 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: bockw: enable boot from shmobile_defconfig
Message-Id: <20130410021532.GL11105@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365131070-13142-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1365131070-13142-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 09, 2013 at 06:57:07PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > To enable boot from shmobile_defconfig on Bock-W,
> > > it needs
> > >  - memory started from 0x40000000
> > >  - enable R8A7778
> > >  - enable Bock-W board
> > >  - enable TMU
> > 
> > I was expecting that the bockw needed to be started at 0x600000000.
> > Are there any side-effects of using 0x400000000?
> 
> Actually, I'm not good at shmobile_defconfig boot approach detail.
> But my understanding is that shmobile_defconfig binary is
> assuming Linux kernel is located from 0x400000000 (= CONFIG_MEM_xxx),
> and dts :: memory can remap (?) memory if it was 0x400000000 ?
> 
> Bock-W couldn't boot if I used 0x600000000 on dts :: memory

If the uboot on the bockw supports zImage then it should
be possible to load an image built with shmobile_defconfig
at 0x600000000 and execute it there.

Something like this:

dhcp
tftp 60000000 bockw/zImage
tftp 60f00000 bockw/r8a7778-bockw.dtb
bootz 60000000 - 60f00000

> > If not, then I guess I am happy with this.
> > But could you split it into two patches?
> 
> OK, thank you
