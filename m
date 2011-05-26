From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 26 May 2011 13:15:18 +0000
Subject: Re: [PATCH 1/2] ARM: arch-shmobile: sh7372: add renesas_usbhs irq support
Message-Id: <BANLkTikv=hi1W4-PMxSyEkzEed-xKnB0OQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pboyrv6j8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pboyrv6j8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, May 25, 2011 at 11:49 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> renesas_usbhs is remake version of r8a66597
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> =A0arch/arm/mach-shmobile/clock-sh7372.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)

I don't mind the contents of this patch, but I don't understand how a
patch with title
"ARM: arch-shmobile: sh7372: add renesas_usbhs irq support" adds code
that only deals with clocks.

Perhaps it's a good idea to double check these things in the future.

/ magnus
