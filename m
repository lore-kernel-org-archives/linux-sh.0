From: Tejun Heo <tj@kernel.org>
Date: Tue, 04 Nov 2014 14:16:23 +0000
Subject: Re: [PATCH 2/3] sata_rcar: Document deprecated "renesas,rcar-sata"
Message-Id: <20141104141623.GC14459@htj.dyndns.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1414591131-21771-1-git-send-email-geert+renesas@glider.be>
 <1414591131-21771-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414591131-21771-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Oct 29, 2014 at 02:58:50PM +0100, Geert Uytterhoeven wrote:
> Commit e67adb4e669db834 ("sata_rcar: Add R-Car Gen2 SATA PHY support")
> deprecated "renesas,rcar-sata" in favor of "renesas,sata-r8a7779", but
> the deprecated value was never documented in the binding documentation,
> while it is still in active use.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This one doesn't apply anymore.  Can you please refresh it against
libata/for-3.19.

Thanks.

-- 
tejun
