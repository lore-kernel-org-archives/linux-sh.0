From: Olof Johansson <olof@lixom.net>
Date: Sun, 18 Dec 2011 04:23:56 +0000
Subject: Re: [PATCH v5 1/5] ARM: l2x0/pl310: Refactor Kconfig to be more maintainable
Message-Id: <CAOesGMibYSA-hJUzpeqFAR0NwewvqHYgujU7SW6-Ua7vxC=-3w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1323964434-6764-1-git-send-email-dave.martin@linaro.org>
 <1323964434-6764-2-git-send-email-dave.martin@linaro.org>
In-Reply-To: <1323964434-6764-2-git-send-email-dave.martin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 15, 2011 at 7:53 AM, Dave Martin <dave.martin@linaro.org> wrote:
> Making CACHE_L2X0 depend on (huge list of MACH_ and ARCH_ configs)
> is bothersome to maintain and likely to lead to merge conflicts.
>
> This patch moves the knowledge of which platforms have a L2x0 or
> PL310 cache controller to the individual machines. =A0To enable this,
> a new MIGHT_HAVE_CACHE_L2X0 config option is introduced to allow
> machines to indicate that they may have such a cache controller
> independently of each other.
>
> Boards/SoCs which cannot reliably operate without the L2 cache
> controller support will need to select CACHE_L2X0 directly from
> their own Kconfigs instead. =A0This applies to some TrustZone-enabled
> boards where Linux runs in the Normal World, for example.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
> =A0 =A0 =A0 =A0(for cns3xxx)
> Acked-by: Tony Lindgren <tony@atomide.com>
> =A0 =A0 =A0 =A0(for omap)

Acked-by: Olof Johansson <olof@lixom.net> (for tegra)


-Olof
