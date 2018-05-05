From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 05 May 2018 00:04:52 +0000
Subject: Re: [PATCH v3 3/3] sh: add the sh_ prefix to early platform symbols
Message-Id: <CAK8P3a3-2jyajsN+p0X_VEVG3B3GJ5fL0T90FV5_Sraz+Lzp4Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180504132731.14574-1-brgl@bgdev.pl>
 <20180504132731.14574-4-brgl@bgdev.pl>
In-Reply-To: <20180504132731.14574-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, May 4, 2018 at 9:27 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Old early platform device support is now sh-specific. Before moving on
> to implementing new early platform framework based on real platform
> devices, prefix all early platform symbols with 'sh_'.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Looks good. I was thinking of something shorter as the new namespace,
but actually using a longer name like you do seems appropriate since
we don't want anyone to actually use it. ;-)

        Arnd
