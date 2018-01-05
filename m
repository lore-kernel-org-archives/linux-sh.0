From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 05 Jan 2018 08:56:56 +0000
Subject: Re: [PATCH v3 1/9] dt-bindings: media: Add Renesas CEU bindings
Message-Id: <CAMuHMdU=CCsn21pkzmKN=9yFn4f2H6QAKSJ5DWCzRBT-F=U=dA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1515081797-17174-1-git-send-email-jacopo+renesas@jmondi.org>
 <1515081797-17174-2-git-send-email-jacopo+renesas@jmondi.org> <14433032.8RBNSVMmkm@avalon>
In-Reply-To: <14433032.8RBNSVMmkm@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Jan 4, 2018 at 11:28 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday, 4 January 2018 18:03:09 EET Jacopo Mondi wrote:
>> Add bindings documentation for Renesas Capture Engine Unit (CEU).

>> +++ b/Documentation/devicetree/bindings/media/renesas,ceu.txt
>> @@ -0,0 +1,85 @@
>> +Renesas Capture Engine Unit (CEU)
>> +----------------------------------------------
>> +
>> +The Capture Engine Unit is the image capture interface found in the Renesas
>> +SH Mobile and RZ SoCs.
>> +
>> +The interface supports a single parallel input with data bus width of 8 or
>> 16
>> +bits.
>> +
>> +Required properties:
>> +- compatible: Must be one of the following.
>> +     - "renesas,r7s72100-ceu" for CEU units found in R7S72100 (RZ/A1) SoCs.
>> +     - "renesas,ceu" as a generic fallback.
>
> As asked in my review of patch 3/9, what's your policy for compatible strings
> ? As far as I understand there's no generic CEU, as the SH4 and RZ versions
> are not compatible. Should the "renesas,ceu" compatible string then be
> replaced by "renesas,rz-ceu" ?

If they're not compatible, it indeed doesn't make much sense to have a
generic "renesas,ceu".

Note that anything with "rz-" is a bad idea, as after RZ/A1, Renesas introduced
RZ/G1, RZ/N1, and RZ/T1, which are completely different (yes I know
we have a few of these in use, unfortunately).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
