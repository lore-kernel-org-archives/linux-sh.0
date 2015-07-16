From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Thu, 16 Jul 2015 11:55:33 +0000
Subject: Re: [PATCH] clocksource: sh_cmt: Remove obsolete sh-cmt-48 platform_device_id entry
Message-Id: <55A79BB5.1080102@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1436875247-14130-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436875247-14130-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/14/2015 02:00 PM, Geert Uytterhoeven wrote:
> Since the removal of the r8a7740 legacy SoC code in commit
> 44d88c754e57a6d9 ("ARM: shmobile: Remove legacy SoC code for R-Mobile
> A1"), all former users of the "sh-cmt-48-gen2" platform device name are
> only supported in generic DT-only ARM multi-platform builds.  The driver
> doesn't need to match platform devices by name anymore, hence remove the
> corresponding platform_device_id entry.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied for 4.3

Thanks !

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

