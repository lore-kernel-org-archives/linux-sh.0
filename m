From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Aug 2009 08:35:24 +0000
Subject: Re: [PATCH] sh: USB0 resource area fix for ms7724se
Message-Id: <aec7e5c30908190135t1e8e0719yfcbd7f958863c629@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uvdkk64rk.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uvdkk64rk.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Aug 19, 2009 at 9:12 AM, Kuninori
Morimoto<morimoto.kuninori@renesas.com> wrote:
>
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> Magnus
>
> in 15 Apr 2009, "Re: [PATCH 3/6] Add USB support for SH7724"
> you taught me about USB area miss. (do you remember ?)
> I think this is just your mistake. or is there any reason ?

You are correct. But please fix other boards and processors using the
same driver!

> --- a/arch/sh/boards/mach-se/7724/setup.c
> +++ b/arch/sh/boards/mach-se/7724/setup.c
> @@ -319,7 +319,7 @@ static struct r8a66597_platdata sh7724_usb0_host_data=
 =3D {
> =A0static struct resource sh7724_usb0_host_resources[] =3D {
> =A0 =A0 =A0 =A0[0] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.start =A0=3D 0xa4d80000,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xa4d800ff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xa4d80124 - 1,

Correct but not so pretty with "- 1" in my opinion.

Thanks for your help!

/ magnus
