From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jan 2018 08:12:48 +0000
Subject: Re: [PATCH 2/2] sh_eth: get Ether port # only when needed
Message-Id: <CAMuHMdV-PHbf1zko2URteFVEUZGsrnu5GXQ2eYDVDR2Z=qVT_A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180114175203.191929089@cogentembedded.com>
In-Reply-To: <20180114175203.191929089@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev <netdev@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Sun, Jan 14, 2018 at 6:47 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The dual-port Ether configurations always have a shared TSU to e.g. pass
> the packets between those  ports.  With the  TSU init. code gathered under
> the single *if*, we now can only get the port # from 'platform_device::id'
> only when we actually  need it  (and not recalculate it each time)...
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
