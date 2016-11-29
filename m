From: Rich Felker <dalias@libc.org>
Date: Tue, 29 Nov 2016 17:09:49 +0000
Subject: Re: [PATCH/RFC linux-mtd] mtd: sh_flctl: Remove sh7372 and device tree support
Message-Id: <20161129170949.GZ1555@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <1480059181-29355-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1480059181-29355-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Fri, Nov 25, 2016 at 08:33:01AM +0100, Simon Horman wrote:
> Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy file")
> removed the sh7272 SoC from the kernel in v4.1.
> 
> This patch removes support for the sh7272 SoC from the sh_flctl driver.
> As that SoC was the only user of device tree support also remove that
> from the driver.
> 
> In essence it reverts commit 7c8f680e96ed ("mtd: sh_flctl: Add device tree
> support"). This commit may be used as a reference for re-adding device
> tree support to this driver if a need for it is found in future.
> 
> This commit has been build-testesd against the ap325rxa_defconfig.
> I do not have access to the hardware to perform run-time testing
> on that board which appears to be the only remaining user of this driver.
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  .../devicetree/bindings/mtd/flctl-nand.txt         | 49 ---------------
>  drivers/mtd/nand/sh_flctl.c                        | 70 +++-------------------
>  2 files changed, 8 insertions(+), 111 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/flctl-nand.txt

While I'm not the maintainer for this (and I'm not clear that the
linux-sh list even should have been cc'd; it seems to be shmobile arm
soc stuff rather than sh arch) I think this is a bad change. If the
driver is completely unused, it should just be removed, but if there
are remaining users that are still using legacy platform device
bindings, they should gradually be transitioned to device tree, and
having the device tree support still present makes it easier to do
that.

Removing the *bindings* is even worse, as these are a permanent
interface between hardware/firmware and software.

Rich
