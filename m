From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Jun 2020 07:17:06 +0000
Subject: Re: [PATCH 2/2] input: i8042 - Remove special Cayman handling
Message-Id: <CAK8P3a2JuoO42Jw59xrKPHEaib=kuKJ_B4_kPpgxbZAOzv_gBQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200617065539.25805-1-geert+renesas@glider.be> <20200617065539.25805-3-geert+renesas@glider.be>
In-Reply-To: <20200617065539.25805-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jun 17, 2020 at 8:55 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> As of commit 37744feebc086908 ("sh: remove sh5 support"), support for
> the SH5-based Cayman platform can no longer be selected.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>
