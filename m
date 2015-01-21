From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2015 13:09:56 +0000
Subject: Re: [PATCH v3] ARM: multi_v7_defconfig: Enable shmobile platforms
Message-Id: <CAMuHMdWObPPnpDPQbrq1HRj9BSBFuNNusQkDhaDTxP+_16oMNg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421684018-11894-1-git-send-email-geert+renesas@glider.be>
 <1467925.IxO001Hv1t@avalon>
In-Reply-To: <1467925.IxO001Hv1t@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Laurent,

On Wed, Jan 21, 2015 at 2:02 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> To avoid bloating the kernel needlessly, couldn't at least some of the drivers
> needed for the shmobile boards be compiled as modules ? Audio, USB, SATA,
> touchscreen are possible candidates, depending on what we need to boot the
> boards to userspace.

That's a possibility.

Note that currently there are almost no modules in multi_v7_defconfig:
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
CONFIG_IPV6_TUNNEL=m
CONFIG_CFG80211=m
CONFIG_MAC80211=m
CONFIG_BRCMFMAC=m
CONFIG_RT2X00=m
CONFIG_RT2800USB=m

Arnd, Olof: What do you prefer?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
