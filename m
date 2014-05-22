From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 May 2014 09:21:35 +0000
Subject: Re: [PATCH 00/03] staging: Emma Mobile USB driver and KZM9D board code
Message-Id: <CAMuHMdW=UdR9sk_jBZu_14LvkHUqg+tXtGaFtLGD0+ikwqO+bw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140522085339.26279.83340.sendpatchset@w520>
In-Reply-To: <20140522085339.26279.83340.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, Linux-sh list <linux-sh@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Olof Johansson <olof@lixom.net>

Hi Magnus,

Thanks for your series! This looks like a good solution for interim board
support.

On Thu, May 22, 2014 at 10:53 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Olof, patch 3/3 contains some board staging code for KZM9D. As it is
> today the EMEV2 SoC is DT-only and we neither have defconfig nor Kconfig
> definitions for the KZM9D board (emev2-kzm9d.dts).

Although there's no KZM9D-specific defconfig anymore, support for it is
included in shmobile_defconfig, right?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
