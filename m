From: Simon Horman <horms@verge.net.au>
Date: Mon, 07 Dec 2015 06:23:06 +0000
Subject: Re: [PATCH] usb: phy: Remove unused Renesas R-Car (Gen1) USB PHY driveer
Message-Id: <20151207062305.GB22834@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449245065-23664-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449245065-23664-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 04, 2015 at 05:04:25PM +0100, Geert Uytterhoeven wrote:
> As of commit 3d7608e4c169af03 ("ARM: shmobile: bockw: remove legacy
> board file and config"), the Renesas R-Car (Gen1) USB PHY driver is no
> longer used.
> In theory it could still be used on R-Car Gen1 SoCs, but that would
> require adding DT support to the driver. Instead, a new driver using the
> generic PHY framework should be written, as was done for R-Car Gen2.
> 
> Remove the driver for good.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

There is a typo in the subject, but that aside:

Acked-by: Simon Horman <horms+renesas@verge.net.au>

