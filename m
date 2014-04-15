From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Apr 2014 12:24:41 +0000
Subject: Re: Renesas clock clk-mstp updates for clock-indices
Message-Id: <CAMuHMdWR=XZCv-ZP7u7DAU=joiGSb0W9Z1Y-4og_B1h06PWQTw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394196400-17112-1-git-send-email-ben.dooks@codethink.co.uk>
 <CAMuHMdVVc-9n4mQSj6qVyP5k9xzSstSw==nfYcFSOXtb895QUw@mail.gmail.com>
 <534D1B60.8030007@codethink.co.uk>
 <CAMuHMdWQ5WvLvaZp7Vaj3tHGJioR+rtfmWxSAaiKTDUrmN-e+w@mail.gmail.com>
 <534D1D91.2050602@codethink.co.uk>
In-Reply-To: <534D1D91.2050602@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Ben,

On Tue, Apr 15, 2014 at 1:52 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Mike, would you prefer an Ack for 1/2, have them both in via yourself
> (and revert 2/2 later) or have them as one patch and sort out fixing
> up later?

Having 1/2 and 2/2 separate breaks bisection, so it should be one patch.
I'm afraid we can't revert 2/2 later anymore, due to backwards compatibility.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
