From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 08 Jan 2015 11:57:15 +0000
Subject: Re: [PATCH v2] sh_eth: Fix access to TRSCER register
Message-Id: <CAMuHMdUnZ1jORHmcJ9rVmyvttUXfrK5Pe7b83bRPdBt9QRa_zg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420698307-3707-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1420698307-3707-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Jan 8, 2015 at 7:25 AM, Nobuhiro Iwamatsu
<nobuhiro.iwamatsu.yj@renesas.com> wrote:
> TRSCER register is configured differently by SoCs. TRSCER of R-Car Gen2 is
> RINT8 bit only valid, other bits are reserved bits. This removes access to
> TRSCER register reserve bit by adding variable trscer_err_mask to
> sh_eth_cpu_data structure, set the register information to each SoCs.
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be> (on r8a7791)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
