From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 05 May 2018 00:02:20 +0000
Subject: Re: [PATCH v3 1/3] clocksource: timer-ti-dm: remove the early platform driver registration
Message-Id: <CAK8P3a3hVxZe8vb82aRzu7=VMJP_yL+CskndLo2HQ58cZ5Q+FA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180504132731.14574-1-brgl@bgdev.pl>
 <20180504132731.14574-2-brgl@bgdev.pl>
In-Reply-To: <20180504132731.14574-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, May 4, 2018 at 9:27 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This driver is no longer used as an early platform driver. Remove the
> registration macro.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
