From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 29 Jun 2015 09:13:15 +0000
Subject: Re: [PATCH 1/2] clocksource: sh_cmt: Remove obsolete sh-cmt-32-fast platform_device_id entry
Message-Id: <55910C2B.7090209@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1435064189-10889-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435064189-10889-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On 06/23/2015 02:56 PM, Geert Uytterhoeven wrote:
> Since commit 59b89af1d5551c12 ("ARM: shmobile: sh7372: Remove Legacy C
> SoC code"), there are no more users left of the "sh-cmt-32-fast"
> platform device name. Hence remove the corresponding platform_device_id
> entry from the driver.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied both to my tree for 4.3.

Thanks !

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

