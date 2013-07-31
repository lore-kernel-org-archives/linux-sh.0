From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Wed, 31 Jul 2013 09:09:59 +0000
Subject: Re: [PATCH/RESEND] clocksource: em_sti: Convert to devm_* managed helpers
Message-Id: <51F8D467.1030400@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1375194277-2850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375194277-2850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 07/30/2013 04:24 PM, Laurent Pinchart wrote:
> Replace kzalloc, clk_get, ioremap and request_irq by their managed
> counterparts to simplify error paths.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> ---

Sounds good.

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

