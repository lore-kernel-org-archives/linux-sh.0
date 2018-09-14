From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Fri, 14 Sep 2018 14:33:16 +0000
Subject: Re: [PATCH v3] clocksource: sh_cmt: fixup for 64-bit machines
Message-Id: <7340b1af-933d-cc4f-5973-e2ab7e068698@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <46a8a01b-e849-6d62-3c61-fbae48f34e58@cogentembedded.com>
In-Reply-To: <46a8a01b-e849-6d62-3c61-fbae48f34e58@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Thomas Gleixner <tglx@linutronix.de>, linux-renesas-soc@vger.kernel.org
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>, linux-sh@vger.kernel.org

On 08/09/2018 22:54, Sergei Shtylyov wrote:
> When trying to use CMT for clockevents on R-Car gen3 SoCs, I noticed
> that 'max_delta_ns' for the broadcast timer (CMT) was shown as 1000 in
> /proc/timer_list. It turned out that when calculating it, the driver did
> 1 << 32 (causing what I think was undefined behavior) resulting in a zero
> delta, later clamped to 1000 by cev_delta2ns(). The root cause turned out
> to be that the driver abused *unsigned long* for the CMT register values
> (which are 16/32-bit), so that the calculation of 'ch->max_match_value'
> in sh_cmt_setup_channel() used the wrong branch. Using more proper 'u32'
> instead fixed 'max_delta_ns' and even fixed the switching an active
> clocksource to CMT (which caused the system to turn non-interactive
> before).
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> ---
> This patch is against the 'tip.git' repo's 'timers/core' branch.
> The CMT driver wasn't ever used on SH64; on R-Car gen3 (ARM64) I'm only
> enabling building of this driver now, so not sure how urgent is this...
>=20
> Changes in version 3:
> - made the 'overflow_bit' and 'clear_bits' members of 'struct sh_cmt_info'
>   'u32';
> - made the 2nd parameter of sh_cmt_write_cmstr() 'u32';
> - made the result, the 2nd parameter, and 'o{1|2}' local variables of
>   sh_cmt_get_counter() 'u32';
> - made the 'has_wrapped' local variables 'u32' in sh_cmt_clocksource_read=
()
>   and sh_cmt_clock_event_program_verify();
> - fixed a typo in the patch description.
>=20
> Changes in version 2:
> - completely redid the patch, fixing abuse of *unsigned long* for the CMT
>   register values.
>=20
>  drivers/clocksource/sh_cmt.c |   72 +++++++++++++++++++-----------------=
-------
>  1 file changed, 33 insertions(+), 39 deletions(-)
>=20

Applied for 4.20, thanks.

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
