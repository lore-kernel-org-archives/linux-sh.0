From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 Apr 2015 13:21:00 +0000
Subject: Re: [PATCH] sh_eth: move inline functions to the header file
Message-Id: <CAMuHMdWS05eOT11prYaVddGwUjGCEDHfd=kn7JYv73HKw0s2BQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4254119.qJUdUQCUqs@wasted.cogentembedded.com>
In-Reply-To: <4254119.qJUdUQCUqs@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Sergei,

On Sun, Apr 5, 2015 at 11:13 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The explicitly inline functions belong to the header files, so move
> cpu_to_edmac() and edmac_to_cpu() into the driver header.

Why do they belong in the header file? Are they (planned to be) used by
another source file (EtherAVB?)?

Currently no other source file besides sh_eth.c includes sh_eth.h, so
IMHO sh_eth.h could just be absorbed by sh_eth.c.

> While at it, make these functions return 'u32' instead of '__u32'.

That change is fine for me.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
