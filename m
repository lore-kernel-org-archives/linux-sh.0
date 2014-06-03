From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 03 Jun 2014 07:05:42 +0000
Subject: Re: [PATCH v2 0/7] ARM: shmobile: koelsch reference: Enable DMA for QSPI
Message-Id: <CAMuHMdVnmsjf29X4KF0co+WwUh9i0DQe6hE0hNFMCv-+GeHP_w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
 <538D50D1.7010900@renesas.com>
In-Reply-To: <538D50D1.7010900@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jun 3, 2014 at 6:36 AM, Khiem Nguyen
<khiem.nguyen.xt@renesas.com> wrote:
> I think this patch series should be divided into 2 parts,
> one for DMA in general and one for DMA supporting QSPI.
>
> How do you think about it ?

I don't think it's worth splitting off just the last patch into a separate
series.

This is a series, not a single patch. The applyer can always drop some
patches.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
