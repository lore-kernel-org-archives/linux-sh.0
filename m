From: Simon Horman <horms@verge.net.au>
Date: Tue, 16 Sep 2014 00:37:58 +0000
Subject: Re: [PATCH] [RESEND] ARM: shmobile: r8a73a4 dtsi: Add SoC-specific irqc compatible property
Message-Id: <20140916003758.GB26557@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1410776477-7725-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1410776477-7725-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 15, 2014 at 12:21:17PM +0200, Geert Uytterhoeven wrote:
> The interrupt controller used the generic compatible property only.
> Add the SoC-specific one, to make it future proof.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Binding has been accepted in commit 41a3322a93395e02 ("irqchip: renesas-irqc:
> Add DT binding documentation"), in
> git://git.infradead.org/users/jcooper/linux.git#irqchip/for-next
> 
>  arch/arm/boot/dts/r8a73a4.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, I have queued this up.
