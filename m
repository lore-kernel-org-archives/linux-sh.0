From: Simon Horman <horms@verge.net.au>
Date: Thu, 08 Oct 2015 02:11:55 +0000
Subject: Re: [PATCH] ata: sata_rcar: Remove obsolete platform_device_id entries
Message-Id: <20151008021154.GC8756@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1444215442-27269-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444215442-27269-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Oct 07, 2015 at 12:57:22PM +0200, Geert Uytterhoeven wrote:
> Since commit c99cd90d98a98aa1 ("ARM: shmobile: r8a7779: Remove legacy
> SoC code"), R-Car SoCs are only supported in generic DT-only ARM
> multi-platform builds.  The driver doesn't need to match platform
> devices by name anymore, hence remove the remaining platform_device_id
> entries and platform device support.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

