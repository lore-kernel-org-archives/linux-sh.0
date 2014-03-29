From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 29 Mar 2014 14:50:12 +0000
Subject: Re: [PATCH 2/5] iommu/ipmmu-vmsa: Add device tree bindings documentation
Message-Id: <5336EBB8.8020204@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396049781-12941-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1396049781-12941-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396049781-12941-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Will Deacon <will.deacon@arm.com>

Hello.

On 03/29/2014 02:36 AM, Laurent Pinchart wrote:

> Cc: devicetree@vger.kernel.org
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   .../bindings/iommu/renesas,ipmmu-vmsa.txt          | 35 ++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt

> diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> new file mode 100644
> index 0000000..72e8590
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> @@ -0,0 +1,35 @@
> +* Renesas VMSA-Compatible IOMMU
> +
> +The IPMMU is an IOMMU implementation compatible with the ARM VMSA page tables.
> +It provides address translation bus masters outside of the CPU, each connected
                                   ^ "for" missing?

[...]

WBR, Sergei

