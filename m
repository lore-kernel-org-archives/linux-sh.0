From: Simon Horman <horms@verge.net.au>
Date: Thu, 30 Oct 2014 00:16:13 +0000
Subject: Re: [PATCH v3 0/9] R-Car Gen2 DMA Controller driver
Message-Id: <20141030001612.GC22052@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 29, 2014 at 12:05:15PM +0200, Laurent Pinchart wrote:
> Hi Geert,
> 
> On Wednesday 29 October 2014 10:59:48 Geert Uytterhoeven wrote:
> > On Wed, Oct 29, 2014 at 10:49 AM, Laurent Pinchart wrote:
> > > I've performed quick SDHI performance tests yesterday. Read performance
> > > were around 7.5% lower with DMA support. Write performances varied but
> > > seemed similar on average.
> > > 
> > > - PIO
> > > 
> > > # time dd if=/dev/mmcblk1 of=/mnt/ram/mmc.bin count2768 bs@96
> > > 262144+0 records in
> > > 262144+0 records out
> > 
> > 262144 records? Did it get split in 512 byte records?
> 
> I knew I should have replaced the whole results instead of copying only the 
> lines I thought had changed between tests :-) The times correspond to 32768 
> blocks of 4kB despite what the number of records say.

As discussed elsewhere, I've dropped the following two patches for now,
pending further investigation of the problem.

ARM: shmobile: r8a7791: Reference DMA channels in SDHI DT nodes
ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes

> > > # time dd of=/dev/mmcblk1 if=/mnt/ram/mmc.bin count2768 bs@96
> > > 32+0 records in
> > > 32+0 records out
> > 
> > Only 32 records?
> > 
> > > - DMA
> > > 
> > > # time dd if=/dev/mmcblk1 of=/mnt/ram/mmc.bin count2768 bs@96
> > > 32+0 records in
> > > 32+0 records out
> > 
> > Only 32 records?
> > 
> > > # time dd of=/dev/mmcblk1 if=/mnt/ram/mmc.bin count2768 bs@96
> > > 32768+0 records in
> > > 32768+0 records out
> > 
> > OK
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
