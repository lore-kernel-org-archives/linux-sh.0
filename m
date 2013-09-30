From: Simon Horman <horms@verge.net.au>
Date: Mon, 30 Sep 2013 02:24:44 +0000
Subject: NOTICE: Known new problems in bockw and marzen defconfigs
Message-Id: <20130930022444.GF30501@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I am about to push the following patches as part
of renesas-devel-20130930.

ARM: shmobile: marzen: enable HPB-DMAC in defconfig
ARM: shmobile: bockw: enable HPB-DMAC in defconfig

As their names imply these patches enable compilation
of HPB-DMAC. Unfortunately compilation of this driver is currently
broken. Sergei has posted the following patches to resolve this problem.

rcar-hpbdma: add parameter to set_slave() method
rcar-hpbdma: remove shdma_free_irq() call

As a convenience to shmobile developers I will include
these two fixes in renesas-devel-20130930. Please note
that this does _not_ mean that I have queued them up
for v3.12 or any other version. My expectation is that
they will be picked up by the DMA maintainer in due course.

