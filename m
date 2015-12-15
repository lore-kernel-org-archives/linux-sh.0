From: Simon Horman <horms@verge.net.au>
Date: Tue, 15 Dec 2015 06:41:38 +0000
Subject: Re: [PATCH v3 2/3] usb: renesas_usbhs: add fallback compatibility strings
Message-Id: <20151215064134.GA29842@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449799947-19866-1-git-send-email-horms+renesas@verge.net.au>
 <1449799947-19866-3-git-send-email-horms+renesas@verge.net.au>
 <566AC07B.6060201@cogentembedded.com>
In-Reply-To: <566AC07B.6060201-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Dec 11, 2015 at 03:24:27PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 12/11/2015 5:12 AM, Simon Horman wrote:
> 
> >Add fallback compatibility strings for R-Car Gen2 and Gen3.
> >This is in keeping with the fallback scheme being adopted wherever
> >appropriate for drivers for Renesas SoCs.
> >
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >v3
> >* Moved documentation of SoC names to a separate patch
> >* Use correct fallback compatibility string in example
> >
> >v2
> >* Add R-Car Gen2 and Gen3 fallback compatibility strings rather than
> >   a single compatibility string for all of R-Car.
> >---
> >  Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 10 +++++++++-
> >  drivers/usb/renesas_usbhs/common.c                      |  9 +++++++++
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> >
> >diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> >index a14c0bb561d5..c55cf77006d0 100644
> >--- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> >+++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> >@@ -2,10 +2,18 @@ Renesas Electronics USBHS driver
> >
> >  Required properties:
> >    - compatible: Must contain one of the following:
> 
>    Really?

Would "...one or more of the following" help?

> >+
> >  	- "renesas,usbhs-r8a7790" for r8a7790 (R-Car H2) compatible device
> >  	- "renesas,usbhs-r8a7791" for r8a7791 (R-Car M2-W) compatible device
> >  	- "renesas,usbhs-r8a7794" for r8a7794 (R-Car E2) compatible device
> >  	- "renesas,usbhs-r8a7795" for r8a7795 (R-Car H3) compatible device
> >+	- "renesas,rcar-gen2-usbhs" for R-Car Gen2 compatible device
> >+	- "renesas,rcar-gen3-usbhs" for R-Car Gen3 compatible device
> >+
> >+	When compatible with the generic version, nodes must list the
> >+	SoC-specific version corresponding to the platform first followed
> >+	by the generic version.
> >+
> 
>    This kinda contradicts the above claim.
> 
> [...]
> 
> MBR, Sergei
> 
