From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Dec 2015 11:00:17 +0000
Subject: Re: [PATCH v3 2/3] usb: renesas_usbhs: add fallback compatibility strings
Message-Id: <CAMuHMdXMB4nsbaT8vo_sOd8mzSABLyk3+_sPHnm2q_p7vR-qHA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449799947-19866-1-git-send-email-horms+renesas@verge.net.au>
	<1449799947-19866-3-git-send-email-horms+renesas@verge.net.au>
	<566AC07B.6060201@cogentembedded.com>
	<20151215064134.GA29842@verge.net.au>
In-Reply-To: <20151215064134.GA29842-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, Dec 15, 2015 at 7:41 AM, Simon Horman <horms@verge.net.au> wrote:
>> >diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
>> >index a14c0bb561d5..c55cf77006d0 100644
>> >--- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
>> >+++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
>> >@@ -2,10 +2,18 @@ Renesas Electronics USBHS driver
>> >
>> >  Required properties:
>> >    - compatible: Must contain one of the following:
>>
>>    Really?
>
> Would "...one or more of the following" help?

+1

>> >+
>> >     - "renesas,usbhs-r8a7790" for r8a7790 (R-Car H2) compatible device
>> >     - "renesas,usbhs-r8a7791" for r8a7791 (R-Car M2-W) compatible device
>> >     - "renesas,usbhs-r8a7794" for r8a7794 (R-Car E2) compatible device
>> >     - "renesas,usbhs-r8a7795" for r8a7795 (R-Car H3) compatible device
>> >+    - "renesas,rcar-gen2-usbhs" for R-Car Gen2 compatible device
>> >+    - "renesas,rcar-gen3-usbhs" for R-Car Gen3 compatible device
>> >+
>> >+    When compatible with the generic version, nodes must list the
>> >+    SoC-specific version corresponding to the platform first followed
>> >+    by the generic version.
>> >+
>>
>>    This kinda contradicts the above claim.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
