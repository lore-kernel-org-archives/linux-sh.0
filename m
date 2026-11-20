Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178834;
	b=OfjNuCupliP8S1WdZ2FP1HRPQimo9pvymNThpgW/vK9uLz1xXKIV/26Yk27NNSZp9puJ
	 LZ8IlukpDoxEPlUn9yFMVhshSKQQd/uD/gezSk/vnWUGTCzZermtu5TWlCdcJDcWB/BpF
	 2gxMpxN0W3AY6U+R6kXL5D3ZgwnDcHfPiHyjkKqdNWyMV5L1atkcVtP8I/xqDOQF/8w7n
	 Q8pqscxvOMMfVgiUwCP1Tr+vNB8A8NjkU8PFE9suWS8i2/PLVn6NoBYHl+Y4heALMKGiJ
	 yXAmBxj/V4hHbp09vHN+rzJh7QFVG0/fp8nKiUBYJWdU2uDXI1YZU96m6JFwG6c/biA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178834;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cFPvlgUy0TvBWcDjM5/jmutsQzuYr3kEfyGp2bpsx6Y=;
	b=G2JuZVN69ilieHjAeEQtfWDubL9NC9sFg04/g70IWOyrTA5PWK+1HDp4Gz8qdBBWA8WV
	 OXhCB5gWtqp1sY/gk5WKnKyR4oAAf+vO91K/sZN1tA4pBpiSojMMPmVygRjXWRvoAqzAt
	 0agmp+NFjZMFgiUJqfT02hOKeooXV3pyjhOOXo3g5vCyGb7q9innUJBZz9oDHqpg2dTga
	 YY/IVOuVGS8nDcCqolElwyuLIcquzmEwjncUpn9cQ86Onegp3umpI+gVJ9rsHsvdu2pph
	 85qOCQILxwSd5yX4waI0OiPS5euo6sPeqYvQHA9RNSXRDl8k6g3jkiJAVyHJPfFAgfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ko6Lt8So;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFCD60A3834
	for <linux-sh@vger.kernel.org>; Fri, 20 Nov 2026 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ko6Lt8So
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2748F1F02EF0
	for <linux-sh@vger.kernel.org>; Fri, 20 Nov 2026 12:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795178834;
	bh=cFPvlgUy0TvBWcDjM5/jmutsQzuYr3kEfyGp2bpsx6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ko6Lt8So1k4Kpkskymig/ldqmyFw5l3nc8bEgsgAwDisD8pK7KcdCYf7/EXHNgfv4
	 fJVwZqOsbobHKaDFoXCZuJfAnfU1gMwPnG6kEMJ5dwz1ZuLVENW3NtIi5/hDuIn4Q4
	 zYBnQLtlNcxDmvgiq74w6u4omDx2udPHobszbEVHGOLRvQ8db3dx1Z+gPvKR4A2LwW
	 VAb6p34LZZKKmNzrqfMW3UWqKMrWz6T1uL4Iqs/Yaq1XRyGTQU/YCCjnur+6I/XBgk
	 hUN7HtiMswmZo0lY9e8T40uEnSB1BeSDpSkXpedWXlDniB0DJox5YVBOwtBhmD+wn9
	 5Cq8E4/Y+QCdw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3adff684a52so6834401fa.1
        for <linux-sh@vger.kernel.org>; Fri, 20 Nov 2026 04:47:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGIvv2qxG1rWfNW6wcqioPan0PNCq1ezB9uu0C/05REC1lSej2BmCodt7zkpx/H/FBqCFzAeHDjoA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8142VeMH4pe4fktkvbm4o/JZkOeR57+ahOYhzV/Ulaegk/jSuL
	4KVVmGDnS7hPRTGXvLrdAx32OfEQCnjnumC7zUJhsiBcJB8Pe20kSuVgUFPggVRaDPxZQOiX5ov
	M7+lTG7NoJftvQw8NZw3/bVn0jQktkJA=
X-Received: by 2002:a2e:a9a7:0:b0:3ae:25c8:dce3 with SMTP id
 38308e7fff4ca-3ae7afa4af0mr11615641fa.0.1795178832340; Fri, 20 Nov 2026
 04:47:12 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com> <20261116152403.2672-2-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20261116152403.2672-2-ilpo.jarvinen@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 13:46:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gaGkw=WF5SNh3HqAQj1BBuKrQX4c=gQmr7u5u1ZazZ3Q@mail.gmail.com>
X-Gm-Features: Aa3M54oz3LF47L5PDAhm_echVts1Tg_ShC1H7XciRhRSEPVLCqbGWtF1x-1ZQPo
Message-ID: <CAJZ5v0gaGkw=WF5SNh3HqAQj1BBuKrQX4c=gQmr7u5u1ZazZ3Q@mail.gmail.com>
Subject: Re: [PATCH 01/13] PCI: Add pci_bus_size_and_assign_resources()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Russell King <linux@armlinux.org.uk>, Greg Ungerer <gerg@linux-m68k.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Dominik Brodowski <linux@dominikbrodowski.net>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 4:24=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Bridge window sizing and resource assignment must not run concurrently
> with another sizing and assignment pass or with device removal.
> Preventing that requires holding locks across both phases. Many callers
> outside of PCI core call pci_bus_size_bridges() immediately followed by
> pci_bus_assign_resources() and cannot hold the PCI core internal locks
> across the two calls.
>
> Add pci_bus_size_and_assign_resources() into PCI core which combines
> these two operations and convert the callers that call them back to
> back.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

LGTM

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  arch/arm/kernel/bios32.c           | 5 ++---
>  arch/m68k/coldfire/pci.c           | 3 +--
>  arch/mips/pci/pci-legacy.c         | 5 ++---
>  arch/sh/drivers/pci/pci.c          | 3 +--
>  drivers/parisc/lba_pci.c           | 7 ++-----
>  drivers/pci/hotplug/acpiphp_glue.c | 3 +--
>  drivers/pci/setup-bus.c            | 7 +++++++
>  drivers/pcmcia/cardbus.c           | 3 +--
>  include/linux/pci.h                | 1 +
>  9 files changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index ac0e890510da..555bfb091d30 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -510,15 +510,14 @@ void pci_common_init_dev(struct device *parent, str=
uct hw_pci *hw)
>                 /*
>                  * We insert PCI resources into the iomem_resource and
>                  * ioport_resource trees in either pci_bus_claim_resource=
s()
> -                * or pci_bus_assign_resources().
> +                * or pci_bus_size_and_assign_resources().
>                  */
>                 if (pci_has_flag(PCI_PROBE_ONLY)) {
>                         pci_bus_claim_resources(bus);
>                 } else {
>                         struct pci_bus *child;
>
> -                       pci_bus_size_bridges(bus);
> -                       pci_bus_assign_resources(bus);
> +                       pci_bus_size_and_assign_resources(bus);
>
>                         list_for_each_entry(child, &bus->children, node)
>                                 pcie_bus_configure_settings(child);
> diff --git a/arch/m68k/coldfire/pci.c b/arch/m68k/coldfire/pci.c
> index 5afb207ccc51..dd21c77c43a6 100644
> --- a/arch/m68k/coldfire/pci.c
> +++ b/arch/m68k/coldfire/pci.c
> @@ -250,8 +250,7 @@ static int __init mcf_pci_init(void)
>         rootbus->resource[0] =3D &mcf_pci_io;
>         rootbus->resource[1] =3D &mcf_pci_mem;
>
> -       pci_bus_size_bridges(rootbus);
> -       pci_bus_assign_resources(rootbus);
> +       pci_bus_size_and_assign_resources(rootbus);
>         pci_bus_add_devices(rootbus);
>         return 0;
>  }
> diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
> index dae6dafdd6e0..ec0e42d9a895 100644
> --- a/arch/mips/pci/pci-legacy.c
> +++ b/arch/mips/pci/pci-legacy.c
> @@ -129,15 +129,14 @@ static void pcibios_scanbus(struct pci_controller *=
hose)
>         /*
>          * We insert PCI resources into the iomem_resource and
>          * ioport_resource trees in either pci_bus_claim_resources()
> -        * or pci_bus_assign_resources().
> +        * or pci_bus_size_and_assign_resources().
>          */
>         if (pci_has_flag(PCI_PROBE_ONLY)) {
>                 pci_bus_claim_resources(bus);
>         } else {
>                 struct pci_bus *child;
>
> -               pci_bus_size_bridges(bus);
> -               pci_bus_assign_resources(bus);
> +               pci_bus_size_and_assign_resources(bus);
>                 list_for_each_entry(child, &bus->children, node)
>                         pcie_bus_configure_settings(child);
>         }
> diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
> index 878a27a1acfb..c91ca8f4cb1c 100644
> --- a/arch/sh/drivers/pci/pci.c
> +++ b/arch/sh/drivers/pci/pci.c
> @@ -81,8 +81,7 @@ static void pcibios_scanbus(struct pci_channel *hose)
>                 need_domain_info =3D 1;
>         }
>
> -       pci_bus_size_bridges(hose->bus);
> -       pci_bus_assign_resources(hose->bus);
> +       pci_bus_size_and_assign_resources(hose->bus);
>         pci_bus_add_devices(hose->bus);
>  }
>
> diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
> index 5197a3c93c70..39ab93ba458b 100644
> --- a/drivers/parisc/lba_pci.c
> +++ b/drivers/parisc/lba_pci.c
> @@ -1639,11 +1639,8 @@ lba_driver_probe(struct parisc_device *dev)
>         if (is_pdc_pat()) {
>                 /* assign resources to un-initialized devices */
>
> -               DBG_PAT("LBA pci_bus_size_bridges()\n");
> -               pci_bus_size_bridges(lba_bus);
> -
> -               DBG_PAT("LBA pci_bus_assign_resources()\n");
> -               pci_bus_assign_resources(lba_bus);
> +               DBG_PAT("LBA pci_bus_size_and_assign_resources()\n");
> +               pci_bus_size_and_assign_resources(lba_bus);
>
>  #ifdef DEBUG_LBA_PAT
>                 DBG_PAT("\nLBA PIOP resource tree\n");
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acp=
iphp_glue.c
> index 78e3effbb32d..632344f34cae 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -465,8 +465,7 @@ static void acpiphp_native_scan_bridge(struct pci_dev=
 *bridge)
>                 max =3D pci_scan_bridge(bus, dev, max, 1);
>                 if (dev->subordinate) {
>                         pcibios_resource_survey_bus(dev->subordinate);
> -                       pci_bus_size_bridges(dev->subordinate);
> -                       pci_bus_assign_resources(dev->subordinate);
> +                       pci_bus_size_and_assign_resources(dev->subordinat=
e);
>                 }
>         }
>  }
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index ed16ef7c26fa..29ec9ba59d92 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2492,3 +2492,10 @@ void pci_assign_unassigned_bus_resources(struct pc=
i_bus *bus)
>         __pci_bus_assign_resources(bus, &add_list, NULL);
>  }
>  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
> +
> +void pci_bus_size_and_assign_resources(struct pci_bus *bus)
> +{
> +       pci_bus_size_bridges(bus);
> +       __pci_bus_assign_resources(bus, NULL, NULL);
> +}
> +EXPORT_SYMBOL_GPL(pci_bus_size_and_assign_resources);
> diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
> index 5e5cf2c3e2c8..19df3f9228a7 100644
> --- a/drivers/pcmcia/cardbus.c
> +++ b/drivers/pcmcia/cardbus.c
> @@ -81,8 +81,7 @@ int __ref cb_alloc(struct pcmcia_socket *s)
>         /*
>          * Size all resources below the CardBus controller.
>          */
> -       pci_bus_size_bridges(bus);
> -       pci_bus_assign_resources(bus);
> +       pci_bus_size_and_assign_resources(bus);
>         cardbus_config_irq_and_cls(bus, s->pci_irq);
>
>         /* socket specific tune function */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aa3765a20a96..d89aeb7c9ff7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1569,6 +1569,7 @@ resource_size_t pcibios_retrieve_fw_addr(struct pci=
_dev *dev, int idx);
>  void pci_bus_assign_resources(const struct pci_bus *bus);
>  void pci_bus_claim_resources(struct pci_bus *bus);
>  void pci_bus_size_bridges(struct pci_bus *bus);
> +void pci_bus_size_and_assign_resources(struct pci_bus *bus);
>  int pci_claim_resource(struct pci_dev *, int);
>  int pci_claim_bridge_resource(struct pci_dev *bridge, int i);
>  void pci_assign_unassigned_resources(void);
> --
> 2.47.3
>
