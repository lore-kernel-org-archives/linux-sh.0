From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Oct 2015 11:06:42 +0000
Subject: Re: [PATCH] serial: sh-sci: Fix length of scatterlist
Message-Id: <CAMuHMdVwiHP+B40CxDzJJ8T=QGwcXtm0o80=OnpZHd+xiscmbw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445496086-5972-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1445496086-5972-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Oct 22, 2015 at 8:41 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch fixes an issue that the "length" of scatterlist should be
> set using sg_dma_len(). Otherwise, a dmaengine driver cannot work
> correctly if CONFIG_NEED_SG_DMA_LENGTH=y.
>
> Fixes: 7b39d90184 (serial: sh-sci: Fix NULL pointer dereference if HIGHMEM is enabled)
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
