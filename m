From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Aug 2017 13:00:15 +0000
Subject: Re: [PATCH repost] serial: sh-sci: use of_property_read_bool()
Message-Id: <CAMuHMdVWi-xdeiTYF91-0sOJwLfR26GOnPxWkxQO9JfwQqV7_A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170813191134.674818373@cogentembedded.com>
In-Reply-To: <20170813191134.674818373@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Sun, Aug 13, 2017 at 9:11 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Use more compact of_property_read_bool() call for a boolean property
> instead  of of_find_property() call in sci_parse_dt().
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
