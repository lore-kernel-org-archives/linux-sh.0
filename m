From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Nov 2015 02:45:41 +0000
Subject: Re: [PATCH 00/04] ARM: shmobile: IPMMU compat string SoC part number update
Message-Id: <20151124024541.GF21853@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20151117043047.4521.84234.sendpatchset@little-apple>
In-Reply-To: <20151117043047.4521.84234.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 17, 2015 at 01:30:47PM +0900, Magnus Damm wrote:
> ARM: shmobile: IPMMU compat string SoC part number update
> 
> [PATCH 01/04] ARM: shmobile: r8a7790: IPMMU compat string SoC part number update
> [PATCH 02/04] ARM: shmobile: r8a7791: IPMMU compat string SoC part number update
> [PATCH 03/04] ARM: shmobile: r8a7793: IPMMU compat string SoC part number update
> [PATCH 04/04] ARM: shmobile: r8a7794: IPMMU compat string SoC part number update
> 
> Update R-Car Gen2 DT compat strings for IPMMU devices to follow the updated
> DT binding documentation included in:
> "[PATCH v2] iommu/ipmmu-vmsa: Include SoC part number in DT binding docs"
> 
> With this compat string change we may in the future add SoC-specific features
> such as IPMMU performance counters that only exist on some SoCs.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

I have marked these patches as deferred pending the binding changes being
accepted. Please repost or otherwise ping me once that has happened.
