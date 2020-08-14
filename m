From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 14 Aug 2020 13:37:04 +0000
Subject: Re: [PATCH] sh: landisk: Add missing initialization of sh_io_port_base
Message-Id: <7e919aa9-44d0-d1ce-da34-d76653126d8e@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200814124245.29692-1-geert+renesas@glider.be>
In-Reply-To: <20200814124245.29692-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert!

On 8/14/20 2:42 PM, Geert Uytterhoeven wrote:
> The Landisk setup code maps the CF IDE area using ioremap_prot(), and
> passes the resulting virtual addresses to the pata_platform driver,
> disguising them as I/O port addresses.  Hence the pata_platform driver
> translates them again using ioport_map().
> As CONFIG_GENERIC_IOMAP=n, and CONFIG_HAS_IOPORT_MAP=y, the
> SuperH-specific mapping code in arch/sh/kernel/ioport.c translates
> I/O port addresses to virtual addresses by adding sh_io_port_base, which
> defaults to -1, thus breaking the assumption of an identity mapping.
> 
> Fix this by setting sh_io_port_base to zero.
> 
> Fixes: 37b7a97884ba64bf ("sh: machvec IO death.")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Wow, that was fast :-).

> ---
> Tested on USL-5P, using either
> CONFIG_ATA/CONFIG_ATA_SFF/CONFIG_PATA_PLATFORM, or legacy
> CONFIG_IDE/CONFIG_BLK_DEV_PLATFORM.
> 
> Sato-san: As you said IDE works fine on Landisk using
> 	  CONFIG_BLK_DEV_AEC62XX, I assume you have a different model
> 	  than the USL-5P, with PCI IDE?
I think Yoshinori is using one which has the HDD built in [1] and not the
USL-5P boards which are for external USB disks only.

I also got one of the models with an HDD built in, but I have never tried
to install Linux on it yet.

Adrian

> [1] https://www.iodata.jp/lib/product/h/1049.htm

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
