From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Apr 2015 11:44:43 +0000
Subject: Re: [PATCH/RFC] v4l: vsp1: Align crop rectangle to even boundary for YUV formats
Message-Id: <CAMuHMdVufCUC+kP-mHgZNLHsvCbMvTGzehdX3X9J9t1SPTQY=Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430327133-8461-1-git-send-email-ykaneko0929@gmail.com>
	<5542105A.1010601@cogentembedded.com>
In-Reply-To: <5542105A.1010601@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Apr 30, 2015 at 1:22 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> Since there is no distintion between 12bit and 16bit YUV formats in
>
>    Вistinсtion.

Distinction?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
