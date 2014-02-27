From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 27 Feb 2014 09:59:51 +0000
Subject: Re: [PATCH 1/5 v2 RFC] PCI: host: Add Renesas R-Car PCIe driver
Message-Id: <CANqRtoT8huX5QFqU6M4t=gKCW8wrk13b0nsR2+8C84HUKHrCLg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393438283-10542-1-git-send-email-phil.edworthy@renesas.com>
	<1393438283-10542-2-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1393438283-10542-2-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-pci@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Valentine Barshak <valentine.barshak@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Ben Dooks <ben.dooks@codethink.co.uk>

On Thu, Feb 27, 2014 at 3:11 AM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> This PCIe Host driver currently does not support MSI, so cards
> fall back to INTx interrupts.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v2:
>  - Use msleep instead of udelay when waiting for the link
>  - Use pm_runtime
>  - Removed unused definition
>  - Also replaced call to devm_request_and_ioremap with devm_ioremap_resource
>    and fixed a bug with this when reporting errors.
>
>  drivers/pci/host/Kconfig     |    6 +
>  drivers/pci/host/Makefile    |    1 +
>  drivers/pci/host/pcie-rcar.c |  588 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pcie-rcar.h |   82 ++++++
>  4 files changed, 677 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-rcar.c
>  create mode 100644 drivers/pci/host/pcie-rcar.h
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 47d46c6..b1c1787 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -33,4 +33,10 @@ config PCI_RCAR_GEN2
>           There are 3 internal PCI controllers available with a single
>           built-in EHCI/OHCI host controller present on each one.
>
> +config PCI_RCAR_GEN2_PCIE
> +       bool "Renesas R-Car PCIe controller"
> +       depends on ARM && (ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST)

Hi Phil,

Thanks for the patch! Just a minor comment from my side at this point:

Please adjust the Kconfig dependencies into excluding SoC strings to
follow same style as our other drivers.

-       depends on ARM && (ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST)
+       depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)

Cheers,

/ magnus
