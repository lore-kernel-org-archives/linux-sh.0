From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 27 Feb 2015 17:48:37 +0000
Subject: [PATCH 0/2] ARM: shmobile: ape6evm: Fix GPIO keys and wake-up
Message-Id: <1425059319-13403-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

	Hi Simon, Magnus,

This patch series adds the missing pull-up bias configuration for the
switches on the r8a73a4/ape6evm development board, and configures the
custom switch as a wake-up source.

After this, the keys actually work, and the system can be resumed from
s2ram by pressing the custom switch.

This depends functionally on "[PATCH 1/4] pinctrl: sh-pfc: Do not
overwrite bias configuration" in the series "[PATCH 0/4] pinctrl:
sh-pfc: Fix pin bias and cleanups" which I've just sent. But as this is
DTS, it can be applied independently.

Thanks for your comments!

Geert Uytterhoeven (2):
  ARM: shmobile: ape6evm dts: Enable pull-up for GPIO switches
  ARM: shmobile: ape6evm dts: Configure the custom switch as wake-up
    source

 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
