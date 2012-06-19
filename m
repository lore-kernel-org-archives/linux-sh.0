From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Jun 2012 06:12:54 +0000
Subject: Re: [PATCH 5/6] ARM: mach-shmobile: Kota2: Use leds-pwm + rmob-tpu-pwm
Message-Id: <CANqRtoTdZeHFj+x8MFY3YtZ_Q5hzCkuQAcca6=e1-kqtbxGDBQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1339773427-29508-6-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1339773427-29508-6-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Laurent,

On Sat, Jun 16, 2012 at 12:17 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Instead of using the LED-specific TPU PWM driver, switch to the generic
> TPU PWM driver with leds-pwm.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> =A0arch/arm/mach-shmobile/board-kota2.c =A0| =A0173 +++++++++++++++++++--=
------------
> =A0arch/arm/mach-shmobile/clock-sh73a0.c | =A0 =A08 +-
> =A02 files changed, 104 insertions(+), 77 deletions(-)

Thanks for your effort in making use of the generic PWM infrastructure.

In general I think this patch looks fine. I need to test it on actual
hardware too.

Thanks,

/ magnus
