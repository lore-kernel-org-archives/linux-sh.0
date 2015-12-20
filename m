From: Rob Herring <robh@kernel.org>
Date: Sun, 20 Dec 2015 03:39:34 +0000
Subject: Re: [PATCH v3 02/27] serial: sh-sci: Add fallback compatibility strings
Message-Id: <20151220033934.GM9883@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
 <1450119456-964-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1450119456-964-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Dec 14, 2015 at 07:57:11PM +0100, Geert Uytterhoeven wrote:
> Add fallback compatibility strings for R-Car Gen1, Gen2, and Gen3.
> This is in keeping with the fallback scheme being adopted wherever
> appropriate for drivers for Renesas SoCs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: devicetree@vger.kernel.org
> ---
> v3:
>   - New.
> ---
>  .../devicetree/bindings/serial/renesas,sci-serial.txt   | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
