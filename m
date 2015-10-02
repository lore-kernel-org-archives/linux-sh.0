From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 02 Oct 2015 11:25:40 +0000
Subject: Re: [PATCH v3 00/09] ARM: shmobile: APMU DT support via SMP Enable method V3
Message-Id: <CAMuHMdV7WkVKjP59DjrGULF=-uBiirKUwVSAfREO6sNC+_1jUQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917063240.26016.93772.sendpatchset@little-apple>
In-Reply-To: <20150917063240.26016.93772.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?B?5bCP5p6X5pWs5aSq?= <keita.kobayashi.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Hi Magnus,

On Thu, Sep 17, 2015 at 8:32 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> ARM: shmobile: APMU DT support via SMP Enable method V3
>
> [PATCH v3 01/09] devicetree: bindings: Renesas APMU and SMP Enable method
> [PATCH v3 02/09] ARM: shmobile: Add APMU DT support via Enable method
> [PATCH v3 03/09] ARM: shmobile: Add APMU nodes to r8a7793 DTSI
> [PATCH v3 04/09] ARM: shmobile: r8a7793 boot address update
> [PATCH v3 05/09] ARM: shmobile: Add APMU nodes to r8a7790 DTSI
> [PATCH v3 06/09] ARM: shmobile: Add APMU nodes to r8a7791 DTSI
> [PATCH v3 07/09] ARM: shmobile: Add function to prioritize DT SMP
> [PATCH v3 08/09] ARM: shmobile: Prioritize r8a7790 DT APMU support
> [PATCH v3 09/09] ARM: shmobile: Prioritize r8a7791 DT APMU support

Thanks for your series!

> via the DT enable-method then it will not be overriden by older non-DT

overridden (thanks, checkpatch.pl!)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
