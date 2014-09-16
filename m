From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Sep 2014 14:51:55 +0000
Subject: Re: [PATCH 00/03] USB Host 2.0 and IOMMU trial on r8a7790 Lager
Message-Id: <CANqRtoRQGX_=BTCGq=xi_FFTkaPLgp=oiojYP_Lhks=LkX8mRA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140916112001.14889.62059.sendpatchset@w520>
In-Reply-To: <20140916112001.14889.62059.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

Thanks for your comments!

On Tue, Sep 16, 2014 at 9:03 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patches.
>
> On Tuesday 16 September 2014 20:20:01 Magnus Damm wrote:
>> USB Host 2.0 and IOMMU trial on r8a7790 Lager
>>
>> [PATCH 01/03] PCI: rcar: Use notifier to hook up IOMMU groups
>> [PATCH 02/03] iommu/ipmmu-vmsa: Create mapping via group notifier
>> [PATCH 03/03] ARM: shmobile: lager-reference: IOMMUSY1 and USB tests
>>
>> This patch series modifies the R-Car Gen2 PCI driver and the IPMMU-VMSA
>> driver to coexist and assign one IOMMU group per PCI host controller.
>>
>> The PCI host controllers and the IOMMU device are glued together via
>> prototype code that adds the IOMMU as a platform device and ties in
>> the 3 PCI host controllers to the IPMMUSY1 device. Patch 3/3 is not
>> intended for upstream merge, however patch 1/3 and 2/3 may be useful
>> with or without further fixes. Comments are very welcome.
>
> How the IOMMU subsystem hooks up devices with IOMMUs is being reworked by Will
> Deacon. I'm following that work, and plan to update the IPMMU driver
> accordingly. This will likely conflict with patch 2/3, and I would rather
> clean up the current code before extending it. Would that be fine schedule-
> wise with you ?

Reworking based on code from WIll Deacon sounds good. I believe it is
fine schedule-wise. It would be good to know how to tie in the PCI
bits with the new code. I assume the PCI host driver needs some
modifications even with the new code.

We've touched this topic before face-to-face, but it would be good to
discuss more about IPMMU features. For instance, how to handle things
like multiple devices associated with one UTLB and perhaps also UTLB
to ASID mapping. And then there is the per-channel DMA stuff with the
associated headache!

Thanks,

/ magnus
