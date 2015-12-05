From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 05 Dec 2015 10:57:49 +0000
Subject: Re: [PATCH v2 00/32] VSP: Add R-Car Gen3 support
Message-Id: <CAMuHMdW13=rftd1HOWBGcjH8aYCjyGZ0u60TkVeTif7+HFuwsQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449281586-25726-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1449281586-25726-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Laurent,

On Sat, Dec 5, 2015 at 3:12 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> This patch set adds support for the Renesas R-Car Gen3 SoC family to the VSP1
> driver. The large number of patches is caused by a change in the display
> controller architecture that makes usage of the VSP mandatory as the display
> controller has lost the ability to read data from memory.
>
> Patch 01/32 to 27/32 prepare for the implementation of an API exported to the
> DRM driver in patch 28/32. Patches 31/32 enables support for the R-Car Gen3
> family, and patch 32/32 finally enhances perfomances by implementing support
> for display lists.
>
> The major change compared to v1 is the usage of the IP version register
> instead of DT properties to configure device parameters such as the number of
> BRU inputs or the availability of the BRU.

Thanks for your series!

As http://git.linuxtv.org/pinchartl/media.git/tag/?id=vsp1-kms-20151112 is
getting old, and has lots of conflicts with recent -next, do you plan to publish
this in a branch, and a separate branch for integration, to ease integration
in renesas-drivers?

Alternatively, I can just import the series you posted, but having the
broken-out integration part would be nice.

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
