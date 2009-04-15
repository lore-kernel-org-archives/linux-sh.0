From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Apr 2009 12:39:39 +0000
Subject: Re: [PATCH 6/6] Add VEU support for SH7724
Message-Id: <aec7e5c30904150539l4f9b131aufcab264dd0caea59@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uvdp71ub3.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uvdp71ub3.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Apr 15, 2009 at 11:43 AM, Kuninori Morimoto
<morimoto.kuninori@renesas.com> wrote:
> @@ -204,6 +262,8 @@ static struct platform_device *sh7724_devices[] __ini=
tdata =3D {
> =A0 =A0 =A0 =A0&iic0_device,
> =A0 =A0 =A0 =A0&iic1_device,
> =A0 =A0 =A0 =A0&vpu_device,
> + =A0 =A0 =A0 &veu0_device,
> + =A0 =A0 =A0 &veu1_device,

What about JPU?

/ magnus
