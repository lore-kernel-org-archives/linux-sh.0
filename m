From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 02 Dec 2014 21:06:49 +0000
Subject: Re: [PATCH 0/5] R-Car Gen2 removal and cleanups
Message-Id: <CAMuHMdWB2r3qhvKQLytf5y4ZKNGasMzx4P5fzbmTBF2Z2U9_+w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417538146-23350-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1417538146-23350-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Tue, Dec 2, 2014 at 5:35 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> This patch series remove the Lager legacy and reference board files from the
> kernel. It builds upon two patches previously posted by Magnus and updated to
> removal left-overs.
>
> The rationale for the change, beside keeping the ARM SoC maintainers happy, is
> that the Lager board is now correctly supported using DT boot and generic code
> only, so there's no reason to keep board files along.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> The second reason to repost the patches is to include a pet peeve of mine that
> I've been carrying in my local branches for too long. The last two patches
> update the Lager and Koelsch DT files to finally rename the two serial ports
> to ttySC0 and ttySC1.

I'm not opposed to this change.

> The patches are targeted at v3.20, as they depend on the "ARM: shmobile:
> lager: Remove DU platform device" patch scheduled for merge in v3.19-rc1
> through the DRM tree.

Given the issues with armadillo-legacy (and perhaps some other -legacy
platform(s)?) in -next (https://lkml.org/lkml/2014/12/2/339), we may have to
accelerate kicking out -legacy...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
