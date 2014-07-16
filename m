From: Will Deacon <will.deacon@arm.com>
Date: Wed, 16 Jul 2014 08:44:56 +0000
Subject: Re: [PATCH 1/2] PCI: generic: Fix GPL v2 license string typo
Message-Id: <20140716084455.GA29414@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140715225645.22578.64865.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140715225645.22578.64865.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 15, 2014 at 11:56:45PM +0100, Bjorn Helgaas wrote:
> The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not "GPLv2".
> 
> Based-on-work-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-host-generic.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index 44fe6aa6a43f..3d2076f59911 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -385,4 +385,4 @@ module_platform_driver(gen_pci_driver);
>  
>  MODULE_DESCRIPTION("Generic PCI host driver");
>  MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
> -MODULE_LICENSE("GPLv2");
> +MODULE_LICENSE("GPL v2");

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
