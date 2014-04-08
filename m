From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 08 Apr 2014 13:22:17 +0000
Subject: Re: [PATCH 2/9] ARM: shmobile: r8a7790: add dma defines for sys and audio dmacs
Message-Id: <1756954.RD74mEdSeA@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk> <1396901229-29117-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396901229-29117-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org, vinod.koul@intel.com, dan.j.williams@intel.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.d, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org

Hi Ben

Thank you for the patch.

On Monday 07 April 2014 21:07:02 Ben Dooks wrote:
> Add the DMA resource IDs for the R8A7790 Audio and SYS DMA controllers
> for use when specifying DMA handles.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  include/dt-bindings/dma/r8a7790-dma.h | 223 +++++++++++++++++++++++++++++++
>  1 file changed, 223 insertions(+)
>  create mode 100644 include/dt-bindings/dma/r8a7790-dma.h
> 
> diff --git a/include/dt-bindings/dma/r8a7790-dma.h
> b/include/dt-bindings/dma/r8a7790-dma.h new file mode 100644
> index 0000000..7c52132
> --- /dev/null
> +++ b/include/dt-bindings/dma/r8a7790-dma.h
> @@ -0,0 +1,223 @@
> +/*
> + * R8A7790 System and Audio DMA channel resource identifiers
> + *
> + * Copyirght (c) 2014 Codethink Ltd.
> + *	Ben Dooks <ben.dooks@codethink.co.uk>
> + *
> + * Licensed under GPLv2
> +*/
> +
> +/* System DMAC */
> +
> +#define R8A7790_DMA_SCIFA0_TX	(0x21)

Do we really need parentheses ? Also, doesn't the kernel favor lower-case hex 
values ?

> +#define R8A7790_DMA_SCIFA0_RX	(0x22)
> +#define R8A7790_DMA_SCIFA1_TX	(0x25)
> +#define R8A7790_DMA_SCIFA1_RX	(0x26)
> +#define R8A7790_DMA_SCIFA2_TX	(0x27)
> +#define R8A7790_DMA_SCIFA2_RX	(0x28)
> +
> +#define R8A7790_DMA_SCIFB0_TX	(0x3D)
> +#define R8A7790_DMA_SCIFB0_RX	(0x3E)
> +#define R8A7790_DMA_SCIFB1_TX	(0x19)
> +#define R8A7790_DMA_SCIFB1_RX	(0x1A)
> +#define R8A7790_DMA_SCIFB2_TX	(0x1D)
> +#define R8A7790_DMA_SCIFB2_RX	(0x1E)
> +
> +#define R8A7790_DMA_HSCIF0_TX	(0x39)
> +#define R8A7790_DMA_HSCIF0_RX	(0x3A)
> +#define R8A7790_DMA_HSCIF1_TX	(0x4D)
> +#define R8A7790_DMA_HSCIF1_RX	(0x4E)
> +
> +#define R8A7790_DMA_SCIF0_TX	(0x29)
> +#define R8A7790_DMA_SCIF0_RX	(0x2A)
> +#define R8A7790_DMA_SCIF1_TX	(0x2D)
> +#define R8A7790_DMA_SCIF1_RX	(0x2E)
> +
> +#define R8A7790_DMA_MSIOF0_TX	(0x81)
> +#define R8A7790_DMA_MSIOF0_RX	(0x82)
> +#define R8A7790_DMA_MSIOF1_TX	(0x85)
> +#define R8A7790_DMA_MSIOF1_RX	(0x86)
> +#define R8A7790_DMA_MSIOF2_TX	(0x41)
> +#define R8A7790_DMA_MSIOF2_RX	(0x42)
> +#define R8A7790_DMA_MSIOF3_TX	(0x45)
> +#define R8A7790_DMA_MSIOF3_RX	(0x46)
> +
> +#define R8A7790_DMA_QSPI_TX	(0x17)
> +#define R8A7790_DMA_QSPI_RX	(0x18)
> +
> +#define R8A7790_DMA_SIM_TX	(0xA1)
> +#define R8A7790_DMA_SIM_RX	(0xA2)
> +
> +#define R8A7790_DMA_IIC0_TX	(0x61)
> +#define R8A7790_DMA_IIC0_RX	(0x62)
> +#define R8A7790_DMA_IIC1_TX	(0x65)
> +#define R8A7790_DMA_IIC1_RX	(0x66)
> +#define R8A7790_DMA_IIC2_TX	(0x69)
> +#define R8A7790_DMA_IIC2_RX	(0x6A)
> +#define R8A7790_DMA_IIC3_TX	(0x77)
> +#define R8A7790_DMA_IIC3_RX	(0x78)
> +
> +#define R8A7790_DMA_SDHI0_TX	(0xCD)
> +#define R8A7790_DMA_SDHI0_RX	(0xCE)
> +#define R8A7790_DMA_SDHI1_TX	(0xC9)
> +#define R8A7790_DMA_SDHI1_RX	(0xCA)
> +#define R8A7790_DMA_SDHI2_TX	(0xC1)
> +#define R8A7790_DMA_SDHI2_RX	(0xC2)
> +#define R8A7790_DMA_SDHI2C2_TX	(0xC5)
> +#define R8A7790_DMA_SDHI2C2_RX	(0xC6)
> +#define R8A7790_DMA_SDHI3_TX	(0xD3)
> +#define R8A7790_DMA_SDHI3_RX	(0xD4)
> +#define R8A7790_DMA_SDHI3C2_TX	(0xDF)
> +#define R8A7790_DMA_SDHI3C2_RX	(0xDE)
> +
> +#define R8A7790_DMA_TPU0	(0xF1)
> +#define R8A7790_DMA_TSIF0	(0xEA)
> +#define R8A7790_DMA_TSIF1	(0xF0)
> +
> +#define R8A7790_DMA_AXISTATR	(0xA6)
> +#define R8A7790_DMA_AXISTATS0	(0xAC)
> +#define R8A7790_DMA_AXISTATS1	(0xAA)
> +#define R8A7790_DMA_AXISTATS2	(0xA8)
> +#define R8A7790_DMA_AXISTATS3	(0xA4)
> +
> +#define R8A7790_DMA_MMCIF0_TX	(0xD1)
> +#define R8A7790_DMA_MMCIF0_RX	(0xD2)
> +#define R8A7790_DMA_MMCIF1_TX	(0xE1)
> +#define R8A7790_DMA_MMCIF1_RX	(0xE2)
> +
> +/* Audio DMAC */
> +
> +#define R8A7790_DMA_DTCPC0_TX	(0xD7)
> +#define R8A7790_DMA_DTCPC0_RX	(0xD8)
> +#define R8A7790_DMA_DTCPC1_TX	(0xD9)
> +#define R8A7790_DMA_DTCPC1_RX	(0xDA)
> +#define R8A7790_DMA_DTCPP0_TX	(0xBF)
> +#define R8A7790_DMA_DTCPP0_RX	(0xC0)
> +#define R8A7790_DMA_DTCPP1_TX	(0xD5)
> +#define R8A7790_DMA_DTCPP1_RX	(0xD6)
> +
> +#define R8A7790_DMA_MLM0_TX	(0xDB)
> +#define R8A7790_DMA_MLM0_RX	(0xDC)
> +#define R8A7790_DMA_MLM1_TX	(0xE3)
> +#define R8A7790_DMA_MLM1_RX	(0xE4)
> +#define R8A7790_DMA_MLM2_TX	(0xE5)
> +#define R8A7790_DMA_MLM2_RX	(0xE6)
> +#define R8A7790_DMA_MLM3_TX	(0xE7)
> +#define R8A7790_DMA_MLM3_RX	(0xE8)
> +#define R8A7790_DMA_MLM4_TX	(0xF3)
> +#define R8A7790_DMA_MLM4_RX	(0xF4)
> +#define R8A7790_DMA_MLM5_TX	(0xF5)
> +#define R8A7790_DMA_MLM5_RX	(0xF6)
> +#define R8A7790_DMA_MLM6_TX	(0xF7)
> +#define R8A7790_DMA_MLM6_RX	(0xF8)
> +#define R8A7790_DMA_MLM7_TX	(0xF9)
> +#define R8A7790_DMA_MLM7_RX	(0xFA)
> +
> +#define R8A7790_DMA_SCU0	(0x85)
> +#define R8A7790_DMA_SCU1	(0x87)
> +#define R8A7790_DMA_SCU2	(0x89)
> +#define R8A7790_DMA_SCU3	(0x8B)
> +#define R8A7790_DMA_SCU4	(0x8D)
> +#define R8A7790_DMA_SCU5	(0x8F)
> +#define R8A7790_DMA_SCU6	(0x91)
> +#define R8A7790_DMA_SCU7	(0x93)
> +#define R8A7790_DMA_SCU8	(0x95)
> +#define R8A7790_DMA_SCU9	(0x97)
> +
> +#define R8A7790_DMA_SCUCMD0	(0xBC)
> +#define R8A7790_DMA_SCUCMD1	(0xBE)
> +
> +#define R8A7790_DMA_SCUOUT0	(0x9A)
> +#define R8A7790_DMA_SCUOUT1	(0x9C)
> +#define R8A7790_DMA_SCUOUT2	(0x9E)
> +#define R8A7790_DMA_SCUOUT3	(0xA0)
> +#define R8A7790_DMA_SCUOUT4	(0xB0)
> +#define R8A7790_DMA_SCUOUT5	(0xB2)
> +#define R8A7790_DMA_SCUOUT6	(0xB4)
> +#define R8A7790_DMA_SCUOUT7	(0xB6)
> +#define R8A7790_DMA_SCUOUT8	(0xB8)
> +#define R8A7790_DMA_SCUOUT9	(0xBA)
> +
> +#define R8A7790_DMA_SSCI00_TX	(0x15)
> +#define R8A7790_DMA_SSCI00_RX	(0x16)
> +#define R8A7790_DMA_SSCI01_TX	(0x35)
> +#define R8A7790_DMA_SSCI01_RX	(0x36)
> +#define R8A7790_DMA_SSCI02_TX	(0x37)
> +#define R8A7790_DMA_SSCI02_RX	(0x38)
> +#define R8A7790_DMA_SSCI03_TX	(0x47)
> +#define R8A7790_DMA_SSCI03_RX	(0x48)
> +
> +#define R8A7790_DMA_SSCI10_TX	(0x49)
> +#define R8A7790_DMA_SSCI10_RX	(0x4A)
> +#define R8A7790_DMA_SSCI11_TX	(0x4B)
> +#define R8A7790_DMA_SSCI11_RX	(0x4C)
> +#define R8A7790_DMA_SSCI12_TX	(0x57)
> +#define R8A7790_DMA_SSCI12_RX	(0x58)
> +#define R8A7790_DMA_SSCI13_TX	(0x59)
> +#define R8A7790_DMA_SSCI13_RX	(0x5A)
> +
> +#define R8A7790_DMA_SSCI20_TX	(0x63)
> +#define R8A7790_DMA_SSCI20_RX	(0x64)
> +#define R8A7790_DMA_SSCI21_TX	(0x67)
> +#define R8A7790_DMA_SSCI21_RX	(0x68)
> +#define R8A7790_DMA_SSCI22_TX	(0x6B)
> +#define R8A7790_DMA_SSCI22_RX	(0x6C)
> +#define R8A7790_DMA_SSCI23_TX	(0x6D)
> +#define R8A7790_DMA_SSCI23_RX	(0x6E)
> +
> +#define R8A7790_DMA_SSCI20_TX	(0x63)
> +#define R8A7790_DMA_SSCI20_RX	(0x64)
> +#define R8A7790_DMA_SSCI21_TX	(0x67)
> +#define R8A7790_DMA_SSCI21_RX	(0x68)
> +#define R8A7790_DMA_SSCI22_TX	(0x6B)
> +#define R8A7790_DMA_SSCI22_RX	(0x6C)
> +#define R8A7790_DMA_SSCI23_TX	(0x6D)
> +#define R8A7790_DMA_SSCI23_RX	(0x6E)
> +
> +#define R8A7790_DMA_SSCI3_TX	(0x6F)
> +#define R8A7790_DMA_SSCI3_RX	(0x70)
> +
> +#define R8A7790_DMA_SSCI4_TX	(0x71)
> +#define R8A7790_DMA_SSCI4_RX	(0x72)
> +
> +#define R8A7790_DMA_SSCI5_TX	(0x73)
> +#define R8A7790_DMA_SSCI5_RX	(0x74)
> +
> +#define R8A7790_DMA_SSCI6_TX	(0x75)
> +#define R8A7790_DMA_SSCI6_RX	(0x76)
> +
> +#define R8A7790_DMA_SSCI7_TX	(0x79)
> +#define R8A7790_DMA_SSCI7_RX	(0x7A)
> +
> +#define R8A7790_DMA_SSCI8_TX	(0x7B)
> +#define R8A7790_DMA_SSCI8_RX	(0x7C)
> +
> +#define R8A7790_DMA_SSCI90_TX	(0x7D)
> +#define R8A7790_DMA_SSCI90_RX	(0x7E)
> +#define R8A7790_DMA_SSCI91_TX	(0x7F)
> +#define R8A7790_DMA_SSCI91_RX	(0x80)
> +#define R8A7790_DMA_SSCI92_TX	(0x81)
> +#define R8A7790_DMA_SSCI92_RX	(0x82)
> +#define R8A7790_DMA_SSCI93_TX	(0x83)
> +#define R8A7790_DMA_SSCI93_RX	(0x84)
> +
> +#define R8A7790_DMA_SSIND0_TX	(0x01)
> +#define R8A7790_DMA_SSIND0_RX	(0x02)
> +#define R8A7790_DMA_SSIND1_TX	(0x03)
> +#define R8A7790_DMA_SSIND1_RX	(0x04)
> +#define R8A7790_DMA_SSIND2_TX	(0x05)
> +#define R8A7790_DMA_SSIND2_RX	(0x06)
> +#define R8A7790_DMA_SSIND3_TX	(0x07)
> +#define R8A7790_DMA_SSIND3_RX	(0x08)
> +#define R8A7790_DMA_SSIND4_TX	(0x09)
> +#define R8A7790_DMA_SSIND4_RX	(0x0A)
> +#define R8A7790_DMA_SSIND5_TX	(0x0B)
> +#define R8A7790_DMA_SSIND5_RX	(0x0C)
> +#define R8A7790_DMA_SSIND6_TX	(0x0D)
> +#define R8A7790_DMA_SSIND6_RX	(0x0E)
> +#define R8A7790_DMA_SSIND7_TX	(0x0F)
> +#define R8A7790_DMA_SSIND7_RX	(0x10)
> +#define R8A7790_DMA_SSIND8_TX	(0x11)
> +#define R8A7790_DMA_SSIND8_RX	(0x12)
> +#define R8A7790_DMA_SSIND9_TX	(0x13)
> +#define R8A7790_DMA_SSIND9_RX	(0x14)

-- 
Regards,

Laurent Pinchart

