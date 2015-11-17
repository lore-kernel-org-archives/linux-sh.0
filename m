From: Rob Herring <robh@kernel.org>
Date: Tue, 17 Nov 2015 21:00:50 +0000
Subject: Re: [PATCH v2] iommu/ipmmu-vmsa: Include SoC part number in DT binding docs
Message-Id: <20151117210050.GA11889@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <20151117035320.30676.88818.sendpatchset@little-apple>
In-Reply-To: <20151117035320.30676.88818.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org

On Tue, Nov 17, 2015 at 12:53:20PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Add part numbers for APE6 and current set of R-Car Gen2 SoCs to the
> IPMMU DT binding documentation. The example is also updated to show
> how the generic compatible string may be used as fallback.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> 
>  Changes since V1:
>  - Updated compat string section to the following:
>    "Must contain SoC-specific and generic entries from below."
> 
>  Thanks to Laurent for feedback!
> 
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt |   12 ++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> --- 0001/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> +++ work/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt	2015-11-17 12:45:26.080513000 +0900
> @@ -7,7 +7,15 @@ connected to the IPMMU through a port ca
>  
>  Required Properties:
>  
> -  - compatible: Must contain "renesas,ipmmu-vmsa".
> +  - compatible: Must contain SoC-specific and generic entries from below.
> +
> +    - "renesas,ipmmu-r8a73a4" for the R8A73A4 (R-Mobile APE6) IPMMU.
> +    - "renesas,ipmmu-r8a7790" for the R8A7790 (R-Car H2) IPMMU.
> +    - "renesas,ipmmu-r8a7791" for the R8A7791 (R-Car M2-W) IPMMU.
> +    - "renesas,ipmmu-r8a7793" for the R8A7793 (R-Car M2-N) IPMMU.
> +    - "renesas,ipmmu-r8a7794" for the R8A7794 (R-Car E2) IPMMU.
> +    - "renesas,ipmmu-vmsa" for generic R-Car Gen2 VMSA-compatible IPMMU.
> +
>    - reg: Base address and size of the IPMMU registers.
>    - interrupts: Specifiers for the MMU fault interrupts. For instances that
>      support secure mode two interrupts must be specified, for non-secure and
> @@ -27,7 +35,7 @@ node with the following property:
>  Example: R8A7791 IPMMU-MX and VSP1-D0 bus master
>  
>  	ipmmu_mx: mmu@fe951000 {
> -		compatible = "renasas,ipmmu-vmsa";
> +		compatible = "renasas,ipmmu-r8a7791", "renasas,ipmmu-vmsa";
>  		reg = <0 0xfe951000 0 0x1000>;
>  		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
