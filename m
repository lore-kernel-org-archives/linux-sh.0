From: Kevin Hilman <khilman@kernel.org>
Date: Tue, 31 Mar 2015 22:25:46 +0000
Subject: Re: [PATCH/RFC 1/5] clk: shmobile: rcar-gen2: Add CPG Clock Domain support
Message-Id: <7h4mp0953p.fsf@deeprootsystems.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
 <1426708017-28885-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1426708017-28885-2-git-send-email-geert+renesas@glider.be>
 (Geert Uytterhoeven's message of "Wed, 18 Mar 2015 20:46:53 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> Add Clock Domain support to the R-Car Gen2 Clock Pulse Generator (CPG)
> driver using the generic PM Domain.  This allows to power-manage the
> module clocks of SoC devices that are part of the CPG Clock Domain using
> Runtime PM, or for system suspend/resume.
>
> SoC devices that are part of the CPG Clock Domain and can be
> power-managed through their primary clock should be tagged in DT with a
> proper "power-domains" property.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Kevin Hilman <khilman@linaro.org>
