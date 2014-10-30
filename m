From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Oct 2014 11:03:22 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: koelsch dts: Drop console= bootargs parameter
Message-Id: <CAMuHMdUOX845FFaNkEan9c+fRrsSk4q0gXUeknTn-MK5JAYWGg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414592918-25138-1-git-send-email-geert+renesas@glider.be>
	<1414592918-25138-4-git-send-email-geert+renesas@glider.be>
	<42870768.kOpZNjp1qs@avalon>
In-Reply-To: <42870768.kOpZNjp1qs@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Oct 30, 2014 at 11:44 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 29 October 2014 15:28:38 Geert Uytterhoeven wrote:
>> Since commit 595c6a4bb77f0096 ("ARM: shmobile: koelsch: Remove legacy C
>> board code"), koelsch is restricted to booting from DT, so
>> chosen/stdout-path is always used, and we can drop the "console="
>> parameter from chosen/bootargs.
>
> I'm curious, how is the baud rate now selected ?

From an earlier response for kzm9d:

"I forgot emev is the only supported SoC not using sh-sci.
 drivers/tty/serial/sh-sci.c:serial_console_setup() defaults to 115200 baud,
 while serial8250_console_setup() defaults to 9600 baud."

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
