From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 09 Jan 2015 08:45:52 +0000
Subject: Re: [PATCH v3 0/7] Pinctrl support for Zynq
Message-Id: <CACRpkdaKH21qz_RAcDtw6ycsw+5FD0RXQQs91_tZV53EuKVusQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1d59c0972da04ec89dec6c09724986a1@BY2FFO11FD010.protection.gbl>
 <4d544fe425694a4e8043ddbf604db062@BN1AFFO11FD033.protection.gbl>
In-Reply-To: <4d544fe425694a4e8043ddbf604db062@BN1AFFO11FD033.protection.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 12, 2014 at 5:37 PM, S=C3=B6ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> Argh, this went through the wrong SMTP. I suspect threading is broken
> due to that. Let me know if you want me to resend this with intact
> threading.

I don't care much about the threading, but all messages are quoted-printable
which doesn't apply :(

i.e.:

Content-Transfer-Encoding: quoted-printable
(...)

+ const char *subnode_target_type =3D "pins";
=20
(...)

Can you resent with more sane encoding? I don't know where this
comes from but suspect the Microsoft Exchange SMTP server
does this when you use diacritics and german letters...

Yours,
Linus Walleij
