From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Mar 2014 07:41:58 +0000
Subject: Re: [PATCH/RFC 0/5] Fix the sh_eth race between open and MDIO bus registration
Message-Id: <CAMuHMdUA_oo3t5GM6NBceSjFjY+BfMEY4=QnRZAKw=wdhSX4QA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395185156-6681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1395185156-6681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Mar 19, 2014 at 12:25 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Laurent Pinchart (5):
>   sh_eth: Use the platform device for memory allocation
>   sh_eth: Use the platform device as the MDIO bus parent
>   sh_eth: Simplify MDIO bus initialization and release
>   sh_eth: Register MDIO bus before registering the network device
>   sh_eth: Remove goto statements that jump straight to a return

Thanks, the changes look fine to me, so

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Still have to do a test run on Koelsch, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
