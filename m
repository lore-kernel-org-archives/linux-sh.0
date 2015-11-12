From: Simon Horman <horms@verge.net.au>
Date: Thu, 12 Nov 2015 01:15:26 +0000
Subject: Re: [PATCH] ARM: shmobile: koelsch: Move SPI FLASH partitions to subnode
Message-Id: <20151112011522.GB19649@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1447144506-20336-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1447144506-20336-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-mtd@vger.kernel.org

On Tue, Nov 10, 2015 at 09:35:06AM +0100, Geert Uytterhoeven wrote:
> As of commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
> dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
> partitions in a special 'partitions' subnode"), having partitions as
> direct subnodes of an mtd device is discouraged:
> 
>     spi0.0: 'partitions' subnode not found on /spi@e6b10000/flash@0. Trying to parse direct subnodes as partitions.

I seem to see something else, perhaps I have a hardware problem?

     m25p80 spi0.0: unrecognized JEDEC id bytes: 01,  2, 20

> Hence move the SPI FLASH partitions to a "partitions" subnode.

Thanks, I will queue this up.

I assume we also need this for other boards with flash nodes
in mainline: bockw, lager, porter, silk.

I'm happy to prepare patches to do that if you want to pass.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

[snip]
