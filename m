From: Rob Herring <robh@kernel.org>
Date: Sat, 19 Dec 2015 04:19:27 +0000
Subject: Re: [PATCH v4 2/3] usb: renesas_usbhs: add fallback compatibility strings
Message-Id: <20151219041927.GQ14936@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1450241512-24699-1-git-send-email-horms+renesas@verge.net.au>
 <1450241512-24699-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1450241512-24699-3-git-send-email-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Dec 16, 2015 at 01:51:51PM +0900, Simon Horman wrote:
> Add fallback compatibility strings for R-Car Gen2 and Gen3.
> This is in keeping with the fallback scheme being adopted wherever
> appropriate for drivers for Renesas SoCs.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v4
> * State that one or more compat string should be used
> 
> v3
> * Moved documentation of SoC names to a separate patch
> * Use correct fallback compatibility string in example
> 
> v2
> * Add R-Car Gen2 and Gen3 fallback compatibility strings rather than
>   a single compatibility string for all of R-Car.
> ---
>  Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 12 ++++++++++--
>  drivers/usb/renesas_usbhs/common.c                      |  9 +++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
