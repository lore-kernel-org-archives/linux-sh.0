From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 08 May 2014 13:06:01 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: r8a7740 dtsi: Add Ethernet support
Message-Id: <CAMuHMdVoYnRcOVht0_Bt5_NJA3vZ40svftRXN-xbqHSMHZR5dg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1399494750-31996-1-git-send-email-geert+renesas@glider.be>
	<1399494750-31996-2-git-send-email-geert+renesas@glider.be>
	<536B7FD3.5090506@cogentembedded.com>
In-Reply-To: <536B7FD3.5090506-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastian Hecht <hechtb+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Sergei,

On Thu, May 8, 2014 at 3:00 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> +       ether: ethernet@e9a00000 {
>
>    Are you really going to refer to this node somewhere, using its label?

Yes, from r8a7740-armadillo800eva-reference.dts

>> +               compatible = "renesas,gether-r8a7740";
>> +               reg = <0xe9a00000 0x800>,
>> +                     <0xe9a01800 0x800>;
>> +               interrupt-parent = <&gic>;
>> +               interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
>> +               /* clocks = <&mstp3_clks R8A7740_CLK_GETHER>; */
>
>    This property is mandatory, according to the bindings.

Indeed, but you cannot put anything there until the platform has CCF, as
mstp3_clks doesn't exist yet.
Currently it relies on a matching CLKDEV_DEV_ID() in platform code.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
