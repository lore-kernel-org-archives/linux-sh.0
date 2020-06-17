From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Jun 2020 07:16:46 +0000
Subject: Re: [PATCH 1/2] sh: Remove SH5-based Cayman platform
Message-Id: <CAK8P3a05scGaz6ATu1-QkbxOsgCW8_OAGSZ0v9GRt6P3Xs5Qxg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200617065539.25805-1-geert+renesas@glider.be> <20200617065539.25805-2-geert+renesas@glider.be>
In-Reply-To: <20200617065539.25805-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jun 17, 2020 at 8:55 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Since the removal of core support for SH5, Cayman support can no longer
> be selected.
>
> Fixes: 37744feebc086908 ("sh: remove sh5 support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Good catch!

I thought I had recursively checked for all unused Kconfig symbols,
but I somehow missed this.

Acked-by: Arnd Bergmann <arnd@arndb.de>
