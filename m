From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 20 Oct 2015 08:54:59 +0000
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency
Message-Id: <CANqRtoTuK4gcc7WMTcMQ4REtRL8oGtT_hLpo7UHgPiQ8e6L+9A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151019030253.6274.46547.sendpatchset@little-apple>
	<1739171.POGWkgX12k@avalon>
In-Reply-To: <1739171.POGWkgX12k@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Hi Laurent,

On Mon, Oct 19, 2015 at 3:42 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Monday 19 October 2015 12:02:53 Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Neither the ARM page table code enabled by IOMMU_IO_PGTABLE_LPAE
>> nor the IPMMU_VMSA driver actually depends on ARM_LPAE, so get
>> rid of the dependency.
>>
>> Tested with ipmmu-vmsa on r8a7794 ALT and a kernel config using:
>>  # CONFIG_ARM_LPAE is not set
>
> The driver only supports the 40-bits page table format for now, hence the
> dependency on LPAE, but it indeed seems that the dependency is bogus. As long
> as the 8 MSBs of the translated address are all 0 I assume the output 40-bit
> address is usable on a 32-bit physical address system.
>
> How have you tested the patch ?

Modetest with local IPMMUMX enablement on r8a7794 ALT.

Cheers,

/ magnus
