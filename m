From: Joerg Roedel <joro@8bytes.org>
Date: Wed, 06 Feb 2013 10:23:50 +0000
Subject: Re: [PATCH v6 1/4] iommu/shmobile: Add iommu driver for Renesas IPMMU modules
Message-Id: <20130206102348.GA2634@8bytes.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1358765669-14567-1-git-send-email-hdk@igel.co.jp>
 <1358765669-14567-2-git-send-email-hdk@igel.co.jp>
 <20130201135456.GG25591@8bytes.org>
 <20130205.194209.52400155.hdk@igel.co.jp>
In-Reply-To: <20130205.194209.52400155.hdk@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 05, 2013 at 07:42:09PM +0900, Hideki EIRAKU wrote:
> From: Joerg Roedel <joro@8bytes.org>

> > Why is it necessary to call dma_map_single() for IOMMU page-tables?
> > usually the dma_* functions call into IOMMU drivers, so why are they
> > used inside an IOMMU driver?
> 
> I use dma_map_single() for flushing the page table to the IOMMU
> device.  The dma_map_ops set by arch/arm/mm/dma-mapping.c are
> per-device (unlike the intel-iommu).  The dma_* functions call into
> IOMMU drivers if the device is attached by arm_iommu_attach_device(),
> but I am using a NULL device here, so that shouldn't happen.

Okay, I applied the patches to a new arm/shmobile branch. Will push them
out soon. The use of the dma_* functions is dangerous anyway (but it
works for now). Please send a follow-on patch to replace the use of the
dma_* functions in the driver with explicit flushing routines. This
protects the code from any future changes in the dma-api implementation.


	Joerg


