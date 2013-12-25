From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Dec 2013 13:07:59 +0000
Subject: Re: [PATCH 6/6] ARM: shmobile: r8a7791: Add SSI clocks in device tree
Message-Id: <20131225130753.GA3073@verge.net.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
List-Id: <linux-sh.vger.kernel.org>
References: <1387468266-13625-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387468266-13625-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2013 at 04:51:06PM +0100, Laurent Pinchart wrote:
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Hi Laurent,

I have queued this up and it is present in renesas-next-v3.13-rc5-20131224v4.

However, I have observed that it prevents the Koelsch board booting
to the point where anything is displayed on the serial console.
Likewise on Lager with the r8a7790 variant of this patch.

Could you take a look into this?

For reference I have attached my .config converted into
a more compact defconfig using make savedefconfig.

> ---
>  arch/arm/boot/dts/r8a7791.dtsi            | 20 ++++++++++++++++++++
>  include/dt-bindings/clock/r8a7791-clock.h | 13 +++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 19c6550..e92c1f7 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -495,6 +495,26 @@
>  				"rcan1", "rcan0", "qspi_mod", "i2c5", "i2c4", "i2c3",
>  				"i2c2", "i2c1", "i2c0";
>  		};
> +		mstp10_clks: mstp10_clks@e6150998 {
> +			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
> +			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
> +			clocks = <&p_clk>, <&mstp10_clks R8A7791_CLK_SSI>,
> +				 <&mstp10_clks R8A7791_CLK_SSI>, <&mstp10_clks R8A7791_CLK_SSI>,
> +				 <&mstp10_clks R8A7791_CLK_SSI>, <&mstp10_clks R8A7791_CLK_SSI>,
> +				 <&mstp10_clks R8A7791_CLK_SSI>, <&mstp10_clks R8A7791_CLK_SSI>,
> +				 <&mstp10_clks R8A7791_CLK_SSI>, <&mstp10_clks R8A7791_CLK_SSI>,
> +				 <&mstp10_clks R8A7791_CLK_SSI>;
> +			#clock-cells = <1>;
> +			renesas,clock-indices = <
> +				R8A7791_CLK_SSI R8A7791_CLK_SSI9 R8A7791_CLK_SSI8
> +				R8A7791_CLK_SSI7 R8A7791_CLK_SSI6 R8A7791_CLK_SSI5
> +				R8A7791_CLK_SSI4 R8A7791_CLK_SSI3 R8A7791_CLK_SSI2
> +				R8A7791_CLK_SSI1 R8A7791_CLK_SSI0
> +			>;
> +			clock-output-names =
> +				"ssi", "ssi9", "ssi8", "ssi7", "ssi6", "ssi5",
> +				"ssi4", "ssi3", "ssi2", "ssi1", "ssi0";
> +		};
>  		mstp11_clks: mstp11_clks@e615099c {
>  			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
>  			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
> diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
> index 30f82f2..1c8f00d 100644
> --- a/include/dt-bindings/clock/r8a7791-clock.h
> +++ b/include/dt-bindings/clock/r8a7791-clock.h
> @@ -103,6 +103,19 @@
>  #define R8A7791_CLK_I2C1		30
>  #define R8A7791_CLK_I2C0		31
>  
> +/* MSTP10 */
> +#define R8A7791_CLK_SSI			5
> +#define R8A7791_CLK_SSI9		6
> +#define R8A7791_CLK_SSI8		7
> +#define R8A7791_CLK_SSI7		8
> +#define R8A7791_CLK_SSI6		9
> +#define R8A7791_CLK_SSI5		10
> +#define R8A7791_CLK_SSI4		11
> +#define R8A7791_CLK_SSI3		12
> +#define R8A7791_CLK_SSI2		13
> +#define R8A7791_CLK_SSI1		14
> +#define R8A7791_CLK_SSI0		15
> +
>  /* MSTP11 */
>  #define R8A7791_CLK_SCIFA3		6
>  #define R8A7791_CLK_SCIFA4		7
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=defconfig

CONFIG_SYSVIPC=y
CONFIG_NO_HZ=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_EMBEDDED=y
CONFIG_PERF_EVENTS=y
CONFIG_SLAB=y
# CONFIG_BLOCK is not set
CONFIG_ARCH_SHMOBILE_MULTI=y
CONFIG_ARCH_R8A7790=y
CONFIG_ARCH_R8A7791=y
CONFIG_MACH_KOELSCH=y
CONFIG_MACH_LAGER=y
# CONFIG_SWP_EMULATE is not set
CONFIG_CPU_BPREDICT_DISABLE=y
CONFIG_PL310_ERRATA_588369=y
CONFIG_ARM_ERRATA_754322=y
CONFIG_SMP=y
CONFIG_SCHED_MC=y
CONFIG_NR_CPUS=8
CONFIG_AEABI=y
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_ARM_APPENDED_DTB=y
CONFIG_KEXEC=y
CONFIG_VFP=y
CONFIG_NEON=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_PM_RUNTIME=y
CONFIG_NET=y
CONFIG_INET=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_NETDEVICES=y
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_CADENCE is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_CIRRUS is not set
# CONFIG_NET_VENDOR_FARADAY is not set
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_SH_ETH=y
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_SH_SCI=y
CONFIG_SERIAL_SH_SCI_NR_UARTS=20
CONFIG_SERIAL_SH_SCI_CONSOLE=y
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
# CONFIG_HID is not set
# CONFIG_USB_SUPPORT is not set
# CONFIG_IOMMU_SUPPORT is not set
# CONFIG_DNOTIFY is not set
# CONFIG_INOTIFY_USER is not set
CONFIG_TMPFS=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
# CONFIG_ARM_UNWIND is not set

--6TrnltStXW4iwmi0--
