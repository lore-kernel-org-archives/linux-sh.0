From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 31 May 2016 06:56:05 +0000
Subject: Re: [PATCH v4 00/16] genrtc removal
Message-Id: <CAMuHMdV5mcKZcBz=v7Pn2pbDiuwMpQYs-70e6NmH6CZ88=JNzA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
	<20160530203207.GY3451@piout.net>
In-Reply-To: <20160530203207.GY3451-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, alpha <linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Parisc List <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-m68k <linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Allo Alexandre,

On Mon, May 30, 2016 at 10:32 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 30/05/2016 at 20:57:48 +0200, Arnd Bergmann wrote :
>> This is the promised resend of the removal of the genrtc driver and some
>> related code, now that we are at a good time to merge this for the coming
>> merge window.
>>
>
> Thanks a lot!
>
> I'm applying the series right now so it sits in linux-next for a while
> before the next merge window.
>
> I would still happily take any acks, Reviewed-by or Tested-by tags.

Looks like Arnd forgot to include these when reposting:

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

For the m68k bits:
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
