From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Thu, 13 Sep 2018 13:25:45 +0000
Subject: Re: [PATCH] clocksource: sh_cmt: fix clocksource width for 32-bit machines
Message-Id: <e6f0e5e5-7c57-917b-98ce-80fe9242b292@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <749e6480-aed6-041c-0209-8dc74c07f344@cogentembedded.com>
In-Reply-To: <749e6480-aed6-041c-0209-8dc74c07f344@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Thomas Gleixner <tglx@linutronix.de>, linux-renesas-soc@vger.kernel.org
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>, linux-sh@vger.kernel.org

On 10/09/2018 22:22, Sergei Shtylyov wrote:
> The driver seems to abuse *unsigned long* not only for the (32-bit)
> register values but also for the 'sh_cmt_channel::total_cycles' which
> needs to always be 64-bit -- as a result, the clocksource's mask is
> needlessly clamped down to 32-bits on the 32-bit machines...
>=20
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> ---
> This patch is against the 'tip.git' repo's 'timers/core' branch plus the =
fixup
> for the 64-bit machines reposted last Saturday...

Why not against timers/urgent ?



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
