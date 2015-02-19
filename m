From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Feb 2015 10:46:37 +0000
Subject: Re: [PATCH] drm/cma: Fix 64-bit size_t build warnings
Message-Id: <CAMuHMdUAeGAy44LY+28XgOfZyiJUv9XRZHaTGTuLHXm6rSKcow@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150219010639.1654.35019.sendpatchset@little-apple>
In-Reply-To: <20150219010639.1654.35019.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Feb 19, 2015 at 2:06 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Fix warnings related to size_t when building for 64-bit architectures:
>
> drivers/gpu/drm/drm_gem_cma_helper.c: In function â€˜drm_gem_cma_createâ€™:

Content-Type: TEXT/PLAIN; charset=ISO-8859-1

But the atcual content is UTF8?

> drivers/gpu/drm/drm_gem_cma_helper.c:114:4: warning: format â€˜%dâ€™ expects argument of type â€˜intâ€™, but argument 3 has type â€˜size_tâ€™ [-Wformat=]
>     size);
>     ^
> drivers/gpu/drm/drm_gem_cma_helper.c: In function â€˜drm_gem_cma_describeâ€™:
> drivers/gpu/drm/drm_gem_cma_helper.c:393:4: warning: format â€˜%dâ€™ expects argument of type â€˜intâ€™, but argument 8 has type â€˜size_tâ€™ [-Wformat=]
>     off, &cma_obj->paddr, cma_obj->vaddr, obj->size);
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
